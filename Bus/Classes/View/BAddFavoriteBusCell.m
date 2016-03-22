//
//  BAddFavoriteBusCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/20.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BAddFavoriteBusCell.h"
#import "Masonry.h"

@implementation BAddFavoriteBusCell

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
    
    UIButton* plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview: plusButton];
    [plusButton setImage:[UIImage imageNamed:@"favorite_plus"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"favorite_plus_highlight"] forState:UIControlStateHighlighted];
    
    [plusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        __weak typeof(self) superView = self;
        
        make.centerX.equalTo(superView);
        make.centerY.equalTo(superView).with.offset(41);
    }];
    
    // 注册事件
    [plusButton addTarget:self  action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)plusClick {
    if ([self.delegate respondsToSelector:@selector(busCellDidClickPlusButton:)]) {
        [self.delegate busCellDidClickPlusButton:self];
    }
    
}

@end
