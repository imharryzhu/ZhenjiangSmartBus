//
//  BVerticalButton.m
//  Bus
//
//  Created by 朱辉 on 16/4/9.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BVerticalButton.h"

@implementation BVerticalButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.frame.size;
    CGSize imageSize = [self.imageView intrinsicContentSize];
    CGSize titleSize = [self.titleLabel intrinsicContentSize];
    
    self.imageView.frame = CGRectMake((size.width - imageSize.width)/2, 0, imageSize.width, imageSize.height);
    self.titleLabel.frame = CGRectMake((size.width - titleSize.width)/2, CGRectGetMaxY(self.imageView.frame)+titleSize.height/2, titleSize.width, titleSize.height);
}

/**
 *  intrinsicContentSize 仅在autolayout下有用。 除此之外，在autolayout下，frame已经没有意义了(数据不会正确)
 *
 */
- (CGSize) intrinsicContentSize{
    CGSize size = [super intrinsicContentSize];
    
    CGSize imageSize = [self.imageView intrinsicContentSize];
    CGSize titleSize = [self.titleLabel intrinsicContentSize];
    
    
    return CGSizeMake(MAX(imageSize.width, titleSize.width), size.height);
}
@end
