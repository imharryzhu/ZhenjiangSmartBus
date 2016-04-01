//
//  NSString+Extension.h
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 * 返回值是该字符串所占的大小(width, height)
 * font : 该字符串所用的字体(字体大小不一样,显示出来的面积也不同)
 * maxSize : 为限制改字体的最大宽和高(如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值,高设置为MAXFLOAT)
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 *  在某个区域内最大的字体
 *
 *  @param maxSize 区域
 *  @param maxFontSize 最大字体 ，默认为50
 */
- (UIFont*)maxFontInSize:(CGSize)maxSize maxFontSize:(NSInteger)maxFontSize;

@end
