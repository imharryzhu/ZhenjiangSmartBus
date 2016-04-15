//
//  BAddFavoriteBusCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/20.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BAddFavoriteBusCell.h"
#import "Masonry.h"

@interface BAddFavoriteBusCell ()

@property (nonatomic,weak) UIButton* plusButton;
@property (nonatomic,weak) UIButton* settingButton;

@end

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
    self.plusButton = plusButton;
    [self addSubview: plusButton];
    plusButton.imageView.contentMode = UIViewContentModeScaleToFill;
    [plusButton setBackgroundImage:[UIImage imageNamed:@"favorite_plus"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"favorite_plus_highlight"] forState:UIControlStateHighlighted];
    // 注册事件
    [plusButton addTarget:self  action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingButton = settingButton;
    [self addSubview: settingButton];
    settingButton.imageView.contentMode = UIViewContentModeScaleToFill;
    [settingButton setBackgroundImage:[UIImage imageNamed:@"favorite_setting"] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"favorite_setting_highlight"] forState:UIControlStateHighlighted];
    // 注册事件
    [settingButton addTarget:self  action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    
    UIEdgeInsets btnInsets = UIEdgeInsetsMake(10, 30, 10, 30);
    
    CGFloat btnH = (size.height / 2) - btnInsets.top - btnInsets.bottom;
    CGFloat btnW = btnH;
    
    CGFloat plusX = (size.width - btnW) / 2;
    CGFloat plusY = (size.height / 2 - btnH) / 2;
    self.plusButton.frame = CGRectMake(plusX, plusY, btnW, btnH);
    
    CGFloat settingX = plusX;
    CGFloat settingY = plusY + size.height/2;
    self.settingButton.frame = CGRectMake(settingX, settingY, btnW, btnH);
}

- (void)plusClick {
    if ([self.delegate respondsToSelector:@selector(busCellDidClickPlusButton:)]) {
        [self.delegate busCellDidClickPlusButton:self];
    }
}

- (void)settingClick {
    if ([self.delegate respondsToSelector:@selector(busCellDidClickSettingButton:)]) {
        [self.delegate busCellDidClickSettingButton:self];
    }
}

@end
