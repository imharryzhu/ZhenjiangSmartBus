//
//  NSString+Extension.m
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (UIFont*)maxFontInSize:(CGSize)maxSize
{
    NSInteger fontSize = 50;
    
    for (NSInteger i = fontSize; i >= 1; i--) {
        UIFont* font = [UIFont systemFontOfSize:i];
        CGSize textSize = [self sizeWithFont:font maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        if(textSize.width <= maxSize.width && textSize.height <= maxSize.height) {
            fontSize = i;
            break;
        }
    }
    return [UIFont systemFontOfSize:fontSize];
}

@end
