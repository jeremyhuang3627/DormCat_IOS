//
//  TimePickerViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/26/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "TimePickerViewController.h"
#import "Macros.h"
#import "NSMutableDictionary+NSMutableDictionaryToJSON.h"
#import "MBProgressHUD.h"

@interface TimePickerViewController ()

@end

@implementation TimePickerViewController

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
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)submit
{
    if([self isEmptyKey:MOBILE] || [self isEmptyKey:STREET_ADDRESS] || [self isEmptyKey:ROOM_NUMBER] || [self isEmptyKey:ZIP_CODE])
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Address Missing"
                                                         message:@"Please give us your address and mobile number in your account panel."
                                                        delegate:self
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil];
        [alert show];
    }else{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Submiting";
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDate *chosen = [self.datePicker date];
    CFTimeInterval timeSinceEpoc = [chosen timeIntervalSince1970] * 1000;
    NSMutableDictionary * order = [NSMutableDictionary new];
    
    order[@"bedRoomNumber"] = [NSNumber numberWithInt:[defaults integerForKey:BEDROOMNUMBER]];
    order[@"bathRoomNumber"] = [NSNumber numberWithInt:[defaults integerForKey:BATHROOMNUMBER]];
    order[@"livingRoomNumber"] = [NSNumber numberWithInt:[defaults integerForKey:LIVINGROOMNUMBER]];
    order[@"kitchenNumber"] = [NSNumber numberWithInt:[defaults integerForKey:KITCHENNUMBER]];
    order[@"amount"] = [NSNumber numberWithDouble:[defaults doubleForKey:TOTALAMOUNT]];
    order[@"timeSinceEpoc"] = [NSNumber numberWithDouble:timeSinceEpoc];
    NSString * jsonString = [order bv_jsonStringWithPrettyPrint:YES];
    NSURL *url = [NSURL URLWithString:[DEV_HOST stringByAppendingString:[NSString stringWithFormat:@"/submit_order"]]];
    NSString * postString = [NSString stringWithFormat:@"order=%@",jsonString];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue * q = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:req queue:q completionHandler:^(NSURLResponse * response, NSData * data,NSError * error){
        NSString * res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"res %@",res);
        dispatch_async(dispatch_get_main_queue(), ^{
            hud.mode = MBProgressHUDModeText;
            if([res isEqualToString:SUCCESS_MSG]){
                hud.labelText = @"You are all set!";
            }else{
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"This is embarrasing."
                                                                 message:@"Opps,an error occured."
                                                                delegate:self
                                                       cancelButtonTitle:@"Ok"
                                                       otherButtonTitles:nil];
                [alert show];
            }
            [hud hide:YES afterDelay:2];
        });
    }];
        
    }
}

-(BOOL) isEmptyKey:(NSString *)key
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * val = (NSString *)[defaults objectForKey:key];
    BOOL isEmpty = [val length] == 0 || [[defaults stringForKey:key] isEqualToString:@"Nothing"];
    NSLog(@"key %@ with val %@ is %d",key,val,isEmpty);
    return isEmpty;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
