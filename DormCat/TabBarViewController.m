//
//  CenterViewController.m
//  DormCat
//
//  Created by Huang Jie on 7/21/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "TabBarViewController.h"
#import "CleanersViewController.h"
#import "MSDynamicsDrawerViewController.h"
#import "OrderViewController.h"
#import "Macros.h"
#import "LogInViewController.h"
#import "TimePickerViewController.h"

@interface TabBarViewController ()
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation TabBarViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.tabBarController = [UITabBarController new];
        CleanersViewController * cleanersViewController = [CleanersViewController new];
        OrderViewController * orderViewController = [OrderViewController new];
        orderViewController.delegate = self;
        cleanersViewController.dcTabBarViewController = orderViewController.dcTabBarViewController = self;
        NSArray * viewControllers = [NSArray arrayWithObjects:orderViewController,cleanersViewController,nil];
        self.tabBarController.viewControllers = viewControllers;
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.tabBarController];
        [self.navigationController.view addSubview:self.tabBarController.view];
        [self.view addSubview:self.navigationController.view];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarController.tabBar setTintColor:UIColorFromRGB(0xffffff)];
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.tabBarController.tabBar.frame.size.height);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    [v setBackgroundColor:UIColorFromRGB(BACKGROUND_COLOR)];
    [self.tabBarController.tabBar insertSubview:v atIndex:0];
    [self.tabBarController.tabBar setBackgroundImage:[[UIImage alloc] init]];
    [self.tabBarController.tabBar setShadowImage:[[UIImage alloc] init]];
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

- (void)dynamicsDrawerRevealRightBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionRight animated:YES allowUserInterruption:YES completion:nil];
}

-(CGRect)frameForContentController
{
    return self.view.frame;
}

#pragma mark OrderViewDelegate methods

-(void)placedOrder
{
    NSLog(@"pushing time picker");
    TimePickerViewController * timePickerViewController = [TimePickerViewController new];
    [self.navigationController pushViewController:timePickerViewController animated:YES];
}
@end
