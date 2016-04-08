//
//  BCommon.h
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCommon : NSObject

/**
 *  从日期字符串截取时间部分
 *
 *  @param dateString 日期字符串
 *  @param formate 格式符
 *
 *  @return 时间
 */
+ (NSString*)timeFromDateString:(NSString*)dateString;

/**
 *  将时间字符串转换为时间
 */
+ (NSDate*)dateFromDateString:(NSString*)dateString;


/**
 *  将时间间隔转换为字符串
 *  如 -28，转换为 28秒前
 */
+ (NSString*)stringFromTimeInterval:(NSDate*)time;

/*
 *  将公交名称包含()的，截取未 主名称和子名称
 *  返回  [主, 子]
 */
+ (NSArray<NSString*>*)subNameInStationName:(NSString*)fullname;

@end
