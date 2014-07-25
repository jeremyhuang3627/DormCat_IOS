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
#define BACKGROUND_COLOR 0x374246
#define NAVIGATION_BAR_COLOR 0x9b59b6
#endif
