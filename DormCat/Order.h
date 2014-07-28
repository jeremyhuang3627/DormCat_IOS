//
//  Order.h
//  DormCat
//
//  Created by Huang Jie on 7/26/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
@property (nonatomic,copy) NSNumber * bedRoomNumber;
@property (nonatomic,copy) NSNumber * bathRoomNumber;
@property (nonatomic,copy) NSNumber * livingRoomNumber;
@property (nonatomic,copy) NSNumber * kitchenNumber;
@property (nonatomic,copy) NSNumber * totalPrice;
@end
