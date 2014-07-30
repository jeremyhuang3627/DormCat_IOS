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
#import "AccountViewController.h"
#import "MSDynamicsDrawerViewController.h"
#import "PaymentViewController.h"
#import "BecomeCleanerViewController.h"
#import "SubmittedOrdersViewController.h"
#import "TakenOrdersViewController.h"

@interface LeftPanelViewController ()

@end

@implementation LeftPanelViewController{
    AccountViewController *accountViewController;
    PaymentViewController *paymentViewController;
    BecomeCleanerViewController *becomeCleanerViewController;
    SubmittedOrdersViewController *submittedOrdersViewController;
    TakenOrdersViewController *takenOrdersViewController;
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
    NSString * padding = @"          ";
    [self.homeBtn setTitle:[padding stringByAppendingString:@"Home"] forState:UIControlStateNormal];
    [self.accountBtn setTitle:[padding stringByAppendingString:@"My Account"] forState:UIControlStateNormal];
    [self.paymentBtn setTitle:[padding stringByAppendingString:@"Payment"] forState:UIControlStateNormal];
    [self.submittedOrdersBtn setTitle:[padding stringByAppendingString:@"Submitted Orders"] forState:UIControlStateNormal];
    [self.becomeCleanerBtn setTitle:[padding stringByAppendingString:@"Become A Cleaner"] forState:UIControlStateNormal];
    [self.takenOrdersBtn setTitle:[padding stringByAppendingString:@"Taken Orders"] forState:UIControlStateNormal];
    [self.logOutBtn setTitle:[padding stringByAppendingString:@"Log Out"] forState:UIControlStateNormal];
    self.homeBtn.contentHorizontalAlignment =
    self.becomeCleanerBtn.contentHorizontalAlignment =
    self.logOutBtn.contentHorizontalAlignment =
    self.accountBtn.contentHorizontalAlignment =
    self.paymentBtn.contentHorizontalAlignment =
    self.takenOrdersBtn.contentHorizontalAlignment =
    self.submittedOrdersBtn.contentHorizontalAlignment =
    UIControlContentHorizontalAlignmentLeft;
    // Do any additional setup after loading the view.
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

-(IBAction)pushViewController:(id)sender{
    NSLog(@"pushViewController tapped");
    switch([sender tag]){
        {case 0:
            NSLog(@"pushing home view controller");
            AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
           [self.dynamicsDrawerViewController setPaneViewController:appDelegate.tabBarViewController animated:YES completion:NULL];
            break;}
        {case 1:
            NSLog(@"pushing account view controller");
            accountViewController = [AccountViewController new];
            [self.dynamicsDrawerViewController setPaneViewController:accountViewController animated:YES completion:NULL];
            break;}
        {case 2:
            paymentViewController = [PaymentViewController new];
            [self.dynamicsDrawerViewController setPaneViewController:paymentViewController animated:YES completion:NULL];
            break;
        }
        {case 3:
            becomeCleanerViewController = [BecomeCleanerViewController new];
            [self.dynamicsDrawerViewController setPaneViewController:becomeCleanerViewController animated:YES completion:NULL];
            break;
        }
        {case 4:
            submittedOrdersViewController = [SubmittedOrdersViewController new];
            [self.dynamicsDrawerViewController setPaneViewController:submittedOrdersViewController animated:YES completion:NULL];
            break;
        }
        {case 5:
            takenOrdersViewController = [TakenOrdersViewController new];
            [self.dynamicsDrawerViewController setPaneViewController:takenOrdersViewController animated:YES completion:NULL];
            break;
        }
    }
}

-(IBAction)logout:(id)sender
{
    AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate logout];
}

@end
