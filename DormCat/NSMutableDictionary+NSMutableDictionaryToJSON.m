//
//  NSMutableDictionary+NSMutableDictionaryToJSON.m
//  DormCat
//
//  Created by Huang Jie on 7/29/14.
//  Copyright (c) 2014 Huang Jie. All rights reserved.
//

#import "NSMutableDictionary+NSMutableDictionaryToJSON.h"

@implementation NSMutableDictionary (NSMutableDictionaryToJSON)
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
@end
