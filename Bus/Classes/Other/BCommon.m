//
//  BCommon.m
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BCommon.h"

@implementation BCommon

+ (NSString*)timeFromDateString:(NSString*)dateString {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    // 设置格式字符串
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:dateString];
    
    // 转换成需要的字符串
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:date];
}

@end
