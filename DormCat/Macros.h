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
#define FAINT_BLACK 0x2e2e2f
#define NAVIGATION_BAR_COLOR 0x9b59b6
#define PROFILE_COLOR 0xe7e7e5
#define DEV_HOST @"http://192.168.1.16:8000"
#define PRODUCTION_HOST @"http://nameless-meadow-2419.herokuapp.com"
#define EMAIL @"email"
#define MOBILE @"mobile"
#define FIRST_NAME @"first_name"
#define LAST_NAME @"last_name"
#define STREET_ADDRESS @"street_address"
#define ROOM_NUMBER @"room_number"
#define ZIP_CODE @"zip_code"
#define BEDROOMNUMBER @"BEDROOMNUMBER"
#define BATHROOMNUMBER @"BATHROOMNUMBER"
#define LIVINGROOMNUMBER @"LIVINGROOMNUMBER"
#define KITCHENNUMBER @"KITCHENNUMBER"
#define TOTALAMOUNT @"TOTALAMOUNT"
#define SUCCESS_MSG @"SUCCESS"
#define APPLICATION_STATUS @"applciation_status"
#endif
