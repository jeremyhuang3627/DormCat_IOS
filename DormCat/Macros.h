//
//  macros.h
//  DormCat
//
//  Created by Huang Jie on 7/22/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#ifndef DormCat_macros_h
#define DormCat_macros_h
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define PRICE_PER_ROOM 16
#define BACKGROUND_COLOR 0x2b2b2d//0x374246
#define NAVIGATION_BAR_COLOR 0x9b59b6
#define PROFILE_COLOR 0xe7e7e5
#define DEV_HOST @"http://192.168.1.16:8000"
#define PRODUCTION_HOST @"http://nameless-meadow-2419.herokuapp.com"
#endif
