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
@property (nonatomic,strong) IBOutlet UILabel * logInLabel;
@property (nonatomic,strong) IBOutlet UILabel * signUpTextField;
@property (nonatomic,strong) DormCatCustomer *customer;
@end
