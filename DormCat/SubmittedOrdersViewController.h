//
//  MyOrdersViewController.h
//  DormCat
//
//  Created by Huang Jie on 7/29/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmittedOrdersViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end
