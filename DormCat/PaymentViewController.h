//
//  PaymentViewController.h
//  DormCat
//
//  Created by Huang Jie on 7/25/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPaymentViewController.h"

@interface PaymentViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,AddPaymentViewControllerDelegate>
@property (nonatomic,strong) IBOutlet UIButton * addCardBtn;
@property (nonatomic,strong) IBOutlet UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * creditCards;
@end
