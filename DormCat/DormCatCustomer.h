//
//  DormCatCustomer.h
//  DormCat
//
//  Created by Huang Jie on 7/24/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DormCatCustomer : NSObject
@property (nonatomic,strong) NSString * username;
@property (nonatomic,strong) NSString * profile_image;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * mobile;
@property (nonatomic,strong) NSArray * saved_cleaners;
@end
