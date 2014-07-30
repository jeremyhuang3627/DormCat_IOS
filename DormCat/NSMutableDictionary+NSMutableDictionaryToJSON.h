//
//  NSMutableDictionary+NSMutableDictionaryToJSON.h
//  DormCat
//
//  Created by Huang Jie on 7/29/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NSMutableDictionaryToJSON)
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint;
@end
