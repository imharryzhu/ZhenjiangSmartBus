//
//  BHomeController.m
//  Bus
//
//  Created by 朱辉 on 16/3/16.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BHomeController.h"
#import "Masonry.h"

#import "BBusLineController.h"

#import "BCollectionViewLayout.h"
#import "BBFavoriteBusCardCell.h"
#import "BAddFavoriteBusCell.h"

@interface BHomeController () <UICollectionViewDataSource, UICollectionViewDelegate, BAddFavoriteBusCellDelegate>

@property (nonatomic,weak) UICollectionView* collectionView;
@property (nonatomic,weak) UIView* updateView;

@end

@implementation BHomeController

static NSString* reuseId_favorite = @"favorite";
static NSString* reuseId_addFavorite = @"addfavorite";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupUI];
    
}


- (void)setupUI {
    
    UIView* superView = self.view;
    
    // 创建公交卡片切换容器
    
    BCollectionViewLayout* layout = [[BCollectionViewLayout alloc]init];
    
    UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 隐藏水平滚动条
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    
    // 添加左右边框
    collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
//    collectionView.pagingEnabled = YES;
//    collectionView.bounces = NO;
    collectionView.delaysContentTouches = NO;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(superView).with.multipliedBy(0.7);
    }];
    
    [collectionView registerClass:[BBFavoriteBusCardCell class] forCellWithReuseIdentifier:reuseId_favorite];
    [collectionView registerClass:[BAddFavoriteBusCell class] forCellWithReuseIdentifier:reuseId_addFavorite];
    
    
    // 创建时时公交显示View
    UIView* updateView = [[UIView alloc]init];
    [self.view addSubview:updateView];
    _updateView = updateView;
    
    updateView.backgroundColor = [UIColor redColor];
    
    
    
    [updateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.bottom.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(collectionView.mas_bottom);
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = nil;
    if (indexPath.row == 3) {
        BAddFavoriteBusCell* busCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId_addFavorite forIndexPath:indexPath];
        cell = busCell;
        busCell.delegate = self;
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId_favorite forIndexPath:indexPath];
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

/**
 *  scrollView开始惯性滑动时
 */
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    // 阻止惯性继续滑动
    [scrollView setContentOffset:scrollView.contentOffset animated:NO];
}


//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"%d", scrollView.scrollEnabled);
//    [scrollView.layer removeAllAnimations];
//    
//}


#pragma mark - BAddFavoriteBusCellDelegate

/**
 *  添加按钮点击时
 */
- (void)busCellDidClickPlusButton:(BAddFavoriteBusCell *)busCell {
    BBusLineController* buslineVC = [[BBusLineController alloc]initWithStyle:UITableViewStylePlain];
    buslineVC.title = @"这个吊";
    
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:buslineVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}


@end
