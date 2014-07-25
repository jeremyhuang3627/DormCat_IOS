//
//  RightViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/21/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftPanelViewController.h"
#import "macros.h"
#import "DormCatCustomer.h"

@interface LeftPanelViewController ()

@end

@implementation LeftPanelViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.customer = [DormCatCustomer new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
    // Do any additional setup after loading the view.
    [self.logInLabel setText:[NSString stringWithFormat:@"Log in to awesomeness"]];
    [self.signUpTextField setText:[NSString stringWithFormat:@"Sign Up for more\n kitty power"]];
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

-(IBAction)logout:(id)sender
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate logout];
}

@end
