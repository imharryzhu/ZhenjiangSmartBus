//
//  BPreference.m
//  Bus
//
//  Created by 朱辉 on 16/4/16.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BPreference.h"

#define BPreference_intervalTimeType @"BPreference_intervalTimeType"
#define BPreference_secondForCustom  @"BPreference_secondForCustom"



@implementation BPreference

+ (NSInteger)intervalTimeTypeToSecond:(NSString*)type {
    NSDictionary* dic = @{@"1秒":@1, @"5秒":@5, @"20秒":@20, @"30秒":@30, @"1分钟":@60, @"2分钟":@120, @"5分钟":@300, @"手动刷新":@0, @"自定义":@([self secondForCustom])};
    
    return [[dic objectForKey:type]integerValue];
}

+ (NSString*)intervalTimeType {
    NSString* str =  [[NSUserDefaults standardUserDefaults]stringForKey:BPreference_intervalTimeType];
    
    if(!str) {
        str = @"5秒";
    }
    
    return str;
}

+ (void)setIntervalTimeType:(NSString*)typeStr
{
    [[NSUserDefaults standardUserDefaults]setObject:typeStr forKey:BPreference_intervalTimeType];
}

+ (NSInteger)secondForCustom {
    return [[NSUserDefaults standardUserDefaults]integerForKey:BPreference_secondForCustom];
}

+ (void)setSecondForCustom:(NSInteger)secondCount {
    [[NSUserDefaults standardUserDefaults]setObject:@(secondCount) forKey:BPreference_secondForCustom];
}

@end
