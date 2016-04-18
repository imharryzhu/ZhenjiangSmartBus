//
//  BPreference.h
//  Bus
//
//  Created by 朱辉 on 16/4/16.
//  Copyright © 2016年 朱辉. All rights reserved.
//  用户偏好设置类

#import <Foundation/Foundation.h>

@interface BPreference : NSObject


/**
 *  将用户选择的 实时公交刷新间隔类型 转换为 秒数
 */
+ (NSInteger)intervalTimeTypeToSecond:(NSString*)type;

/**
 *  用户选择的 实时公交刷新间隔类型
 *  @[@"1秒", @"5秒", @"20秒", @"30秒", @"1分钟", @"2分钟", @"5分钟", @"手动刷新", @"自定义"]
 *  默认值: "5秒"
 */
+ (NSString*)intervalTimeType;
+ (void)setIntervalTimeType:(NSString*)typeStr;

/**
 *  当用户选择 实时公交刷新间隔类型为 自定义时，用户自定义的间隔时间 (秒)
 */
+ (NSInteger)secondForCustom;
+ (void)setSecondForCustom:(NSInteger)secondCount;


@end
