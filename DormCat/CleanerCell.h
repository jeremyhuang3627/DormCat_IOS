//
//  CleanerCell.h
//  DormCat
//
//  Created by Huang Jie on 7/21/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CleanerCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *username;
@property (nonatomic, weak) IBOutlet UILabel *description;
@property (nonatomic, weak) IBOutlet UILabel *favorites;
@property (nonatomic, weak) IBOutlet UILabel *rating;
@end
