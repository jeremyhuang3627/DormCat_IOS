//
//  AccountViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/25/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "AccountViewController.h"
#import "Macros.h"
#import "MBProgressHUD.h"

@interface AccountViewController ()

@end

@implementation AccountViewController
{
    BOOL editEnabled;
}

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
    editEnabled = NO;
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [self setField:self.emailField withDefaults:defaults andKey:@"email"];
    [self setField:self.mobileField withDefaults:defaults andKey:@"mobile"];
    [self setField:self.firstNameField withDefaults:defaults andKey:@"first_name"];
    [self setField:self.lastNameField withDefaults:defaults andKey:@"last_name"];
    [self setField:self.streetAddressField withDefaults:defaults andKey:@"street_address"];
    [self setField:self.roomNumberField withDefaults:defaults andKey:@"room_number"];
    [self setField:self.zipCodeField withDefaults:defaults andKey:@"zip_code"];
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)setField:(UITextField *)field withDefaults:(NSUserDefaults *)defaults andKey:(NSString *)key
{
    if([[defaults objectForKey:key] length]==0){
        [field setText:@"Nothing"];
    }else{
        [field setText:[defaults objectForKey:key]];
    }
    field.enabled = NO;
    
}

-(IBAction)editSaveBtn:(UIButton *)sender
{
    editEnabled = !editEnabled;
    [self setEditState:editEnabled];
    if(editEnabled){
        [sender setTitle:@"Save" forState:UIControlStateNormal];
    }else{
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self saveCustomerInfo];
    }
}

-(void)setEditState:(BOOL)state
{
    for(UIView *subview in self.view.subviews){
        if([subview isKindOfClass:[UITextField class]]){
            ((UITextField *)subview).enabled = state;
            if(state){
                subview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textField_Border.png"]];
            }else{
                subview.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
            }
        }
    }
}

-(void)saveCustomerInfo
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    
    //save everything to NSUserDefaults
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.emailField.text forKey:EMAIL];
    [defaults setObject:self.mobileField.text forKey:MOBILE];
    [defaults setObject:self.firstNameField.text forKey:FIRST_NAME];
    [defaults setObject:self.lastNameField.text forKey:LAST_NAME];
    [defaults setObject:self.streetAddressField.text forKey:STREET_ADDRESS];
    [defaults setObject:self.roomNumberField.text forKey:ROOM_NUMBER];
    [defaults setObject:self.zipCodeField.text forKey:ZIP_CODE];
    
    NSURL *url = [NSURL URLWithString:[DEV_HOST stringByAppendingString:[NSString stringWithFormat:@"/update_user_info"]]];
    NSString * postString = [NSString stringWithFormat:@"email=%@&mobile=%@&first_name=%@&last_name=%@&street_address=%@&room_number=%@&zip_code=%@",
                             self.emailField.text,
                             self.mobileField.text,
                             self.firstNameField.text,
                             self.lastNameField.text,
                             self.streetAddressField.text,
                             self.roomNumberField.text,
                             self.zipCodeField.text
                             ];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue * q = [NSOperationQueue new];
    [NSURLConnection sendAsynchronousRequest:req queue:q completionHandler:^(NSURLResponse * response, NSData * data,NSError * error){
        NSString * res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"res %@",res);
        if([res isEqualToString:@"SUCCESS"]){
            dispatch_async(dispatch_get_main_queue(), ^{
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"Done";
                [hud hide:YES afterDelay:2];
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

-(void)dismissKeyboard
{
    for(UIView *subview in self.view.subviews){
        if([subview isKindOfClass:[UITextField class]] && subview.isFirstResponder){
            [subview resignFirstResponder];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
