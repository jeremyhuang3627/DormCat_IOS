//
//  OrderViewController.h
//  DormCat
//
//  Created by Huang Jie on 7/22/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBarViewController;

@interface OrderViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIView *topBar;
@property (nonatomic, weak) TabBarViewController * dcTabBarViewController;
@property (nonatomic,strong) IBOutlet UILabel * bedRoomNumberLabel;
@property (nonatomic,strong) IBOutlet UILabel * bathRoomNumberLabel;
@property (nonatomic,strong) IBOutlet UILabel * livingRoomNumberLabel;
@property (nonatomic,strong) IBOutlet UILabel * kitchenNumberLabel;
@property (nonatomic,strong) IBOutlet UILabel * totalAmountLabel;
@property (nonatomic,strong) IBOutlet UILabel * bedRoomLabel;
@end
