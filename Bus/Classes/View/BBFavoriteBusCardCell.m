
//
//  BBFavoriteBusCardCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/19.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBFavoriteBusCardCell.h"

@implementation BBFavoriteBusCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        
        // 设置卡片的圆角
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card1"]];
    [self addSubview:imageView];
//
    imageView.center = CGPointMake(self.width/2, self.height/2);
}

@end
