//
//  BIntervalTimeToolBar.h
//  Bus
//
//  Created by 朱辉 on 16/4/16.
//  Copyright © 2016年 朱辉. All rights reserved.
//  选择公交刷新间隔时间 的键盘 toolbar

#import <UIKit/UIKit.h>

@class BIntervalTimeToolBar;

@protocol BIntervalTimeToolBarDelegate <NSObject>

@optional

- (void)intervalTimeToolBarDone:(BIntervalTimeToolBar*)toolBar;

@end


@interface BIntervalTimeToolBar : UIToolbar

+ (instancetype)toolBar;

@property (nonatomic,weak) id<BIntervalTimeToolBarDelegate> tbDelegate;

@end
