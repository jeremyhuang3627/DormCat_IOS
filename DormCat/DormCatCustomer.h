//
//  DormCatCustomer.h
//  DormCat
//
//  Created by Huang Jie on 7/24/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DormCatCustomer : NSObject
@property (nonatomic,strong) NSString * user_id;
@property (nonatomic,strong) NSString * first_name;
@property (nonatomic,strong) NSString * last_name;
@property (nonatomic,strong) NSString * profile_image;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSString * address;
@property (nonatomic,strong) NSString * mobile;
@property (nonatomic,strong) NSArray * saved_cleaners;
@end
