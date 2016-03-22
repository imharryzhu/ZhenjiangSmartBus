//
//  NSArray+Log.m
//  MyZJ
//
//  Created by 朱辉 on 16/2/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "NSArray+Log.h"


@implementation NSArray (Log)


- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}
@end


@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
       id value= self[key];
       [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];

    return str;
}
@end

