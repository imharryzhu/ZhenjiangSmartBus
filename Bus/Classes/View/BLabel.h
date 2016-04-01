//
//  BLabel.h
//  Bus
//
//  Created by 朱辉 on 16/3/31.
//  Copyright © 2016年 朱辉. All rights reserved.
//  为Label添加垂直对齐功能

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface BLabel : UILabel

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
