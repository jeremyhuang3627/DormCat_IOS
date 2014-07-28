//
//  AccountViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/25/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "AccountViewController.h"
#import "Macros.h"
@interface AccountViewController ()

@end

@implementation AccountViewController

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
    NSData * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"USERINFO"];
    NSDictionary * userDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [self.emailLabel setText:userDictionary[@"email"]];
    [self.mobileLabel setText:userDictionary[@"mobile"]];
    [self.firstNameLabel setText:userDictionary[@"first_name"]];
    [self.lastNameLabel setText:userDictionary[@"last_name"]];
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
