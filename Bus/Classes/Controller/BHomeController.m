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
#import "BBusGPSView.h"

#import "BFavoriteBusLine.h"
#import "BBusLine.h"

#import "BFavoriteBusLineTool.h"

#import "BCollectionViewLayout.h"
#import "BFavoriteBusCardCell.h"
#import "BAddFavoriteBusCell.h"

#import <CoreLocation/CoreLocation.h>

@interface BHomeController () <UICollectionViewDataSource, UICollectionViewDelegate, BAddFavoriteBusCellDelegate, CLLocationManagerDelegate>

@property (nonatomic,weak) UICollectionView* collectionView;
@property (nonatomic,weak) BBusGPSView* gpsView;

/**
 *  记录上一次选中的卡片
 */
@property (nonatomic,weak) BFavoriteBusCardCell* lastFavotireCell;

/**
 *  定时器，如果当前cell在屏幕中停留指定时间的话，则cell开始执行刷新函数
 */
@property (nonatomic,strong) NSTimer* timer;

/**
 *  定位
 */
@property (nonatomic,strong) CLLocationManager* locationMgr;

@end

@implementation BHomeController

static NSString* reuseId_favorite = @"favorite";
static NSString* reuseId_addFavorite = @"addfavorite";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupUI];
    
    /**
     *  监听 用户收藏改变
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(favoriteBusLinesDidchange) name:BFavoriteChangeNotification object:nil];
    
    
    // 开始定位
    self.locationMgr = [[CLLocationManager alloc]init];
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0) {
        [self.locationMgr requestAlwaysAuthorization];
    }
    self.locationMgr.delegate = self;
    // 位置偏移 500m
    self.locationMgr.distanceFilter = 500;
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyKilometer;
    [self.locationMgr startUpdatingLocation];
    
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
//    collectionView.delaysContentTouches = NO;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.equalTo(superView);
        make.right.equalTo(superView);
        make.height.equalTo(superView).with.multipliedBy(0.7);
    }];
    
//    [collectionView registerClass:[BFavoriteBusCardCell class] forCellWithReuseIdentifier:reuseId_favorite];
    [collectionView registerNib:[UINib nibWithNibName:@"BFavoriteBusCardCell" bundle:nil] forCellWithReuseIdentifier:reuseId_favorite];
    [collectionView registerClass:[BAddFavoriteBusCell class] forCellWithReuseIdentifier:reuseId_addFavorite];
    
    
    // 创建时时公交显示View
    BBusGPSView* updateView = [[BBusGPSView alloc]init];
    [self.view addSubview:updateView];
    _gpsView = updateView;
    
    updateView.backgroundColor = [UIColor whiteColor];
    
    
    [updateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView);
        make.bottom.equalTo(superView);
        make.right.equalTo(superView);
        make.top.equalTo(collectionView.mas_bottom);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {    
    return [[BFavoriteBusLineTool defaultTool]favoriteBusLines].count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = nil;
    
    NSArray* favorite = [[BFavoriteBusLineTool defaultTool]favoriteBusLines];
    
    if (indexPath.row == favorite.count) {
        BAddFavoriteBusCell* busCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId_addFavorite forIndexPath:indexPath];
        cell = busCell;
        busCell.delegate = self;
    } else {
        
        BFavoriteBusCardCell* favoriteCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseId_favorite forIndexPath:indexPath];
        cell = favoriteCell;
        
        favoriteCell.favoriteBusLine = favorite[indexPath.row];
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

/**
 *  当页面滑动完毕后
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 判断是否为该类
    if(scrollView == self.collectionView) {
        // 取消原来的计时
        [self.timer invalidate];
        
        // 开始新的计时
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(busCardDidSelected) userInfo:nil repeats:NO];
    }
}

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

#pragma mark - 定位代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"%f -- %f",[locations lastObject].coordinate.latitude, [locations lastObject].coordinate.longitude);
    
    CLGeocoder* geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count == 0 || error) {
            NSLog(@"你他妈是在火星吧");
            return;
        }
        
        for (CLPlacemark *placemark in placemarks) {
            
            //获取城市名称 --> 一定要加判断 locality有可能获取不到值
            
            //locality : 城市名
            //administrativeArea : 行政区域
            if (placemark.locality) {
                NSLog(@"city: %@",placemark.locality);
            } else {
                NSLog(@"city: %@",placemark.administrativeArea);
            }
        }
    }];
    
}

#pragma mark - 通知消息

/**
 *  当收藏发生改变时
 */
- (void)favoriteBusLinesDidchange {
    [self.collectionView reloadData];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

/**
 *  公交卡被选中
 */
- (void)busCardDidSelected {
    
    CGPoint centerPos = CGPointMake(self.collectionView.contentOffset.x + self.collectionView.width/2, self.collectionView.height/2);
    
    // 获取屏幕中心点所在的cell
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:centerPos];
    
    UICollectionViewCell* cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[BFavoriteBusCardCell class]]) {
        BFavoriteBusCardCell* favotireCell = (BFavoriteBusCardCell*)cell;
        if(self.lastFavotireCell != favotireCell) {
            self.lastFavotireCell= favotireCell;
//            self.gpsView.busLine = favotireCell.favoriteBusLine.busLine;
        }
    }
}

@end
