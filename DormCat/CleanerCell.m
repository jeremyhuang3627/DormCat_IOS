//
//  CleanerCell.m
//  DormCat
//
//  Created by Huang Jie on 7/21/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "CleanerCell.h"
#import "Macros.h"

@implementation CleanerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initializat0xf9f8f8on code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.viewForBaselineLayout.backgroundColor = UIColorFromRGB(BACKGROUND_COLOR);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
