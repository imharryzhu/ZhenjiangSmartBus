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

@end
