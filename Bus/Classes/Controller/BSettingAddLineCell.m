//
//  BSettingAddLineCell.m
//  Bus
//
//  Created by 朱辉 on 16/4/15.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BSettingAddLineCell.h"

@interface BSettingAddLineCell()


@end

@implementation BSettingAddLineCell

- (void)awakeFromNib {
    self.imageView.image = [UIImage imageNamed:@"favorite_plus"];
    self.textLabel.font = [UIFont systemFontOfSize:17];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    CGFloat imageH = self.height - insets.top - insets.bottom;
    CGFloat imageW = imageH;
    
    CGFloat imageX = insets.left;
    CGFloat imageY = insets.top;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + insets.right;
}

@end
