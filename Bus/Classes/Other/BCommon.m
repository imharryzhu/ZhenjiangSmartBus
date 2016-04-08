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
    formatter.timeZone = [NSTimeZone systemTimeZone];
    // 设置格式字符串
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:dateString];
    
    // 转换成需要的字符串
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:date];
}

+ (NSDate*)dateFromDateString:(NSString*)dateString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    // 设置格式字符串
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:dateString];
    return [self UTCToLocalTime:date];
}

+ (NSDate*)UTCToLocalTime:(NSDate*)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

+ (NSDate*)localDate
{
    NSDate *date = [NSDate date];
    
    return [self UTCToLocalTime:date];
}

+ (NSString*)stringFromTimeInterval:(NSDate*)time
{
    NSTimeInterval timeInterval = [[BCommon localDate] timeIntervalSinceDate:time];
    
    int temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    
    return  result;
}


+ (NSArray<NSString*>*)subNameInStationName:(NSString*)fullname {
    if(fullname == nil) return @[@"", @""];
    
    NSString* pattern = @"(.+)[/(（](.+)[/)）]?$";
    NSRegularExpression* reg = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult*>* arr = [reg matchesInString:fullname options:0 range:NSMakeRange(0, fullname.length)];
    
    
    if(arr.count > 0)
    {
        NSTextCheckingResult* result = [arr firstObject];
        NSRange range1 = [result rangeAtIndex:1];
        NSRange range2 = [result rangeAtIndex:2];
        return @[[fullname substringWithRange:range1],[fullname substringWithRange:range2]];
        
    }else{
        return @[fullname, @""];
    }
}


@end
