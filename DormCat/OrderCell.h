//
//  OrderCell.h
//  DormCat
//
//  Created by Huang Jie on 7/30/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel * orderLabel;
@property (nonatomic,strong) IBOutlet UILabel * statusLabel;
@property (nonatomic,strong) IBOutlet UILabel * amountLabel;
@property (nonatomic,strong) IBOutlet UILabel * dateLabel;
@property (nonatomic,strong) IBOutlet UILabel * addressLabel;
@end
