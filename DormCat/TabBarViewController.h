//
//  CenterViewController.h
//  DormCat
//
//  Created by Huang Jie on 7/21/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MSDynamicsDrawerViewController;

@interface TabBarViewController : UIViewController <UITabBarDelegate>
@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;
- (void)dynamicsDrawerRevealRightBarButtonItemTapped:(id)sender;
@end