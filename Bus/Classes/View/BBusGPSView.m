//
//  BBusGPSView.m
//  Bus
//
//  Created by 朱辉 on 16/3/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusGPSView.h"
#import "BBusGPSViewLayout.h"

#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "Masonry.h"

#import "BBusLine.h"
#import "BBusStation.h"
#import "BFavoriteBusLine.h"
#import "BBusGPS.h"
#import "BUser.h"

#import "BBusGPSCell.h"

#import "BBusStationTool.h"
#import "BBusGPSTool.h"
#import "BPreference.h"

#import <CoreLocation/CoreLocation.h>

@interface BBusGPSView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) NSArray<BBusGPS*>* busGPSs;

@property (nonatomic,weak) UICollectionView* collectionView;

@property (nonatomic,strong) NSTimer* timer;

@property (nonatomic,strong) NSURLSessionDataTask* urlSessionTask;

/**
 *  保存用户选中的公交站点
 */
@property (nonatomic,strong) BBusStation* selectedBusStation;

@property (nonatomic,copy) NSDate* date;

@end

@implementation BBusGPSView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        BBusGPSViewLayout* layout = [[BBusGPSViewLayout alloc]init];
        
        
        UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        self.collectionView = collectionView;
        [self addSubview:collectionView];
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        [collectionView registerNib:[UINib nibWithNibName:@"BBusGPSCell" bundle:nil]  forCellWithReuseIdentifier:@"busgps"];
        
        collectionView.backgroundColor = [UIColor whiteColor];
        
        
        __weak typeof(self) superView = self;
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView);
            make.bottom.equalTo(superView);
            make.right.equalTo(superView);
            make.top.equalTo(superView);
        }];
        
        // 监听间隔时间修改事件
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(intervalTimeSelected) name:BGPSIntervalTimeSelectedNotifcation object:nil];
        
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setFavoriteBusLine:(BFavoriteBusLine *)favoriteBusLine {
    _favoriteBusLine = favoriteBusLine;
    
    // 清理上次选中的数据
    self.selectedBusStation = nil;
    
    [self restartGPSTimer];
    [self.timer fire];
}

- (void)updateBusGps {
    
    [SVProgressHUD show];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLSessionDataTask* task = [BBusStationTool busStationForBusLine:self.favoriteBusLine.busLine WithDirection:self.favoriteBusLine.direction success:^(NSArray<BBusStation *> *busStations) {
        
        [SVProgressHUD dismiss];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        self.favoriteBusLine.busLine.busStations = busStations;
        
        [BBusGPSTool busGPSForBusLine:self.favoriteBusLine.busLine WithDirection:self.favoriteBusLine.direction success:^(NSArray<BBusGPS*>* busGPSs){
            self.busGPSs = busGPSs;
            
            [self didUpdateBusGps];
            
        } withFailure:^(NSError *error) {
        }];
        
    } withFailure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [SVProgressHUD showErrorWithStatus:@"获取公交站台失败"];
    }];
    self.urlSessionTask = task;
    
}

#pragma mark - UICollectionViewCell代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.favoriteBusLine.busLine.busStations.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BBusGPSCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"busgps" forIndexPath:indexPath];
    BBusStation* station = self.favoriteBusLine.busLine.busStations[indexPath.row];
    
    cell.busStation = station;
    
    BBusGPSCellTipType type = BBusGPSCellTipTypeNone;
    
    // bus 是否到站信息
    for (BBusGPS* gps in self.busGPSs) {
        if (gps.stationNo.intValue == station.orderno.intValue) {
            type = BBusGPSCellTipTypeBusIn;
            if (gps.arriveStation.intValue == 1) {
                type = BBusGPSCellTipTypeBusArrive;
            }
            break;
        }
    }
    
    // 如果station是用户距离最近的站
    if ([BUser defaultUser].nearestStation.orderno.intValue == station.orderno.intValue) {
        type = BBusGPSCellTipTypeCurrent;
        // 用户选择的station
    }else if(self.selectedBusStation.orderno.intValue == station.orderno.intValue) {
        type = BBusGPSCellTipTypeSelected;
    }

    cell.tipType = type;
    return cell;
}


/**
 *  获取公交最新位置时，更新列表
 */
- (void)didUpdateBusGps {
    [self.collectionView reloadData];
    // 向外部发送通知，表示收到了
    [[NSNotificationCenter defaultCenter]postNotificationName:BBusGPSDidUpdateNotifcation object:nil userInfo:@{BBusGPSsName:self.busGPSs}];
}

- (void)selectBusStation:(BBusStation*)busStation {
    
    _selectedBusStation = busStation;
    [self.collectionView reloadData];
}

- (void)pause {
    self.date = self.timer.fireDate;
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)resume {
    [self.timer setFireDate:self.date];
}

/**
 *  用户重新选择了 公交间隔时间
 */

- (void)intervalTimeSelected {
    
    // 重启定时器
    [self restartGPSTimer];
    
    self.date = [NSDate date];
    [self.timer setFireDate:[NSDate distantFuture]];
}

/**
 *  重新启动定时器
 */
- (void)restartGPSTimer {
    
    NSInteger interval = [BPreference intervalTimeTypeToSecond:[BPreference intervalTimeType]];
    
    [self.timer invalidate];
    
    NSTimer* timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(updateBusGps) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
}

@end
