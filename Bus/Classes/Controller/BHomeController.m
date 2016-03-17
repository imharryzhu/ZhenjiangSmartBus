//
//  BHomeController.m
//  Bus
//
//  Created by 朱辉 on 16/3/16.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BHomeController.h"

@interface BHomeController ()

@property (nonatomic,weak) UICollectionView* collectionView;
@property (nonatomic,weak) UIView* updateView;

@end

@implementation BHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}


- (void)setupUI {
    // 创建公交卡片切换容器
    UICollectionView* collectionView = [[UICollectionView alloc]init];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    // 创建时时公交显示View
    UIView* updateView = [[UIView alloc]init];
    [self.view addSubview:updateView];
    _updateView = updateView;
    
    
}


@end
