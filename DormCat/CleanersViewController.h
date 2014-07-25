//
//  CleanersViewController.h
//  DormCat
//
//  Created by Huang Jie on 7/22/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBarViewController;

@interface CleanersViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIButton *rightButton;
@property (nonatomic, weak) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, weak) TabBarViewController * dcTabBarViewController;
@end
