//
//  BNavigationController.m
//  Bus
//
//  Created by 朱辉 on 16/4/15.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BNavigationController.h"

@interface BNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation BNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置全屏滑动返回
    UIGestureRecognizer* gesture = self.interactivePopGestureRecognizer;
    // 停用原有的手势
    gesture.enabled = NO;
    
    UIView* gestureView = gesture.view;
    
    // 自定义手势
    UIPanGestureRecognizer* popGesture = [[UIPanGestureRecognizer alloc]init];
    popGesture.delegate = self;
    popGesture.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popGesture];
    
    // 获取系统的手势监听方法
    NSMutableArray* targets = [gesture valueForKey:@"_targets"];
    id gestureRecognizerTarget = targets.firstObject;
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    
    SEL handelTransition = NSSelectorFromString(@"handleNavigationTransition:");
    [popGesture addTarget:navigationInteractiveTransition action:handelTransition];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //这里有两个条件不允许手势 1 当前控制器为根控制器 2 如果这个push  pop 动画正在执行(私有属性)
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
