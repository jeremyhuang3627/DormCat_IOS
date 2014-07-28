//
//  AddPaymentViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/27/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "AddPaymentViewController.h"
#import "Macros.h"
#import "MBProgressHUD.h"
#import <Braintree/Braintree.h>

@interface AddPaymentViewController ()

@end

@implementation AddPaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    NSURL *url = [NSURL URLWithString:[DEV_HOST stringByAppendingString:@"/braintree_client_id"]];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    NSOperationQueue * q = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:request queue:q completionHandler:^(NSURLResponse * response, NSData * data,NSError * error){
        if(!error){
            NSString * clientToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Client Token %@",clientToken);
            [[NSUserDefaults standardUserDefaults] setObject:clientToken forKey:@"BTCLIENTTOKEN"];
        }else{
            NSLog(@"error %@",error.description);
        }
    }];
    
    CGRect f = CGRectMake(25,100,self.view.frame.size.width - 50, 220);
    self.cardFormView = [[BTUICardFormView alloc] initWithFrame:f];
    self.cardFormView.delegate = self;
    [self.view addSubview:self.cardFormView];
    [self updateValidity];
}

- (void)updateValidity {
    BOOL valid = self.cardFormView.valid;
    if(valid){
        self.saveBtn.alpha = 1.0;
    }else{
        self.saveBtn.alpha = 0.5;
    }
    [self.saveBtn setEnabled:valid];
}

-(IBAction)save:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *clientToken = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"BTCLIENTTOKEN"];
    NSMutableDictionary * cardDictionary = [NSMutableDictionary new];
    cardDictionary[@"maskedNumber"] = self.cardFormView.number;
    Braintree *braintree = [Braintree braintreeWithClientToken:clientToken];
    [braintree tokenizeCardWithNumber:self.cardFormView.number
                      expirationMonth:self.cardFormView.expirationMonth
                       expirationYear:self.cardFormView.expirationYear
                           completion:^(NSString *nonce, NSError *error){
                               NSLog(@"nonce %@",nonce);
                               NSString * postString = [NSString stringWithFormat:@"nonce=%@",nonce];
                               NSURL *url = [NSURL URLWithString:[DEV_HOST stringByAppendingString:@"/braintree_add_card"]];
                               NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
                               [request setHTTPMethod:@"POST"];
                               [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
                               NSOperationQueue * q = [NSOperationQueue new];
                               [NSURLConnection sendAsynchronousRequest:request queue:q completionHandler:^(NSURLResponse * response, NSData * data,NSError * error){
                                   NSString * res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   if([res isEqual:@"SUCCESS"] && !error){
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                                           [self.delegate addCardDictionary:cardDictionary];
                                           [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
                                       });
                                   }
                               }];
                           }];
}

-(IBAction)cancel
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark BTUICardFormViewDelegate methods

-(void)cardFormViewDidChange:(BTUICardFormView *)cardFormView
{
    [self updateValidity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
