
//
//  BBFavoriteBusCardCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/19.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BFavoriteBusCardCell.h"
#import "BFavoriteBusLine.h"
#import "BBusLine.h"

@interface BFavoriteBusCardCell()

@property (nonatomic,weak) UILabel* label;

@end

@implementation BFavoriteBusCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        
        // 设置卡片的圆角
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [self setupUI];
        
        UILabel* label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:80];
        label.center = CGPointMake(0, self.height/2);
        self.label = label;
        [self addSubview:label];
        
        
    }
    return self;
}


- (void)setupUI {
//    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"card1"]];
//    [self addSubview:imageView];
////
//    imageView.center = CGPointMake(self.width/2, self.height/2);
}

- (void)setFavoriteBusLine:(BFavoriteBusLine *)favoriteBusLine {
    _favoriteBusLine = favoriteBusLine;
    
    
    self.label.text = favoriteBusLine.busLine.fullname;
    [self.label sizeToFit];
    
}

@end
