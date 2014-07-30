//
//  RightViewController.h
//  DormCat
//
//  Created by Huang Jie on 7/21/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSDynamicsDrawerViewController;
@class DormCatCustomer;

@interface LeftPanelViewController : UIViewController
@property (weak, nonatomic) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UIButton *accountBtn;
@property (strong, nonatomic) IBOutlet UIButton *paymentBtn;
@property (strong, nonatomic) IBOutlet UIButton *submittedOrdersBtn;
@property (strong, nonatomic) IBOutlet UIButton *takenOrdersBtn;
@property (strong, nonatomic) IBOutlet UIButton *becomeCleanerBtn;
@property (strong, nonatomic) IBOutlet UIButton *logOutBtn;
@end
