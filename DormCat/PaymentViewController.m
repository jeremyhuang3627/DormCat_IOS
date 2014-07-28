//
//  PaymentViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/25/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "PaymentViewController.h"
#import "Macros.h"
#import "MBProgressHUD.h"
#import <Braintree/Braintree.h>
#import "AddPaymentViewController.h"
#import "CardCell.h"

@interface PaymentViewController ()
@end

static NSString *const CardCellIdentifier = @"CardCell";

@implementation PaymentViewController{
    BOOL showNoCardCell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = self.tableView.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    UINib *cellNib = [UINib nibWithNibName:CardCellIdentifier bundle:nil];
	[self.tableView registerNib:cellNib forCellReuseIdentifier:CardCellIdentifier];
    [self.tableView setRowHeight:80];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData * data = [defaults objectForKey:@"USERINFO"];
    self.creditCards = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data][@"creditCards"]];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    showNoCardCell = YES;
}

-(IBAction)addCard
{
    AddPaymentViewController * addPaymentViewController = [AddPaymentViewController new];
    addPaymentViewController.delegate = self;
    [self presentViewController:addPaymentViewController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if([self.creditCards count]==0 && showNoCardCell){
        return 1;
    }else{
        return [self.creditCards count];
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardCell * cc = (CardCell *)[tableView dequeueReusableCellWithIdentifier:CardCellIdentifier];
    if([self.creditCards count] == 0 && showNoCardCell){
        [cc.cardLabel setText:@"No credit card yet."];
    }else{
        [cc.cardLabel setText:(NSString *)[self.creditCards objectAtIndex:indexPath.row][@"maskedNumber"]];
    }
    return cc;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString * token = [self.creditCards objectAtIndex:indexPath.row][@"token"];
        [self removeCard:token atIndexPath:indexPath tableView:tableView];
    }
}

-(void)removeCard:(NSString *)token atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.creditCards removeObjectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[DEV_HOST stringByAppendingString:[NSString stringWithFormat:@"/remove_credit_card"]]];
    NSString * postString = [NSString stringWithFormat:@"token=%@",token];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue * q = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:req queue:q completionHandler:^(NSURLResponse * response, NSData * data,NSError * error){
        NSString * res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if([res isEqualToString:@"SUCCESS"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                showNoCardCell = NO;
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            });
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"This is embarrasing."
                                                             message:@"Opps,an error occured."
                                                            delegate:self
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
            [alert show];
        }
    }];
}

-(void)addCardDictionary:(NSMutableDictionary *)card
{
    [self.creditCards addObject:card];
    [self.tableView reloadData];
}

@end
