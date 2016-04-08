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
#import "BBusGPS.h"
#import "BUser.h"

#import "BBusGPSCell.h"

#import "BBusStationTool.h"
#import "BBusGPSTool.h"

#import <CoreLocation/CoreLocation.h>

@interface BBusGPSView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) NSArray<BBusGPS*>* busGPSs;

@property (nonatomic,weak) UICollectionView* collectionView;

/**
 *  保存用户选中的公交站点
 */
@property (nonatomic,weak) BBusStation* selectedBusStation;

@end

@implementation BBusGPSView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        BBusGPSViewLayout* layout = [[BBusGPSViewLayout alloc]init];
        
        
        UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        self.collectionView = collectionView;
        [self addSubview:collectionView];
        
//        collectionView.contentInset = UIEdgeInsetsMake(0, 50, 0, 50);
        
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
//        layout.itemSize = CGSizeMake(50, 50);
        
        [collectionView registerNib:[UINib nibWithNibName:@"BBusGPSCell" bundle:nil]  forCellWithReuseIdentifier:@"busgps"];
        
        collectionView.backgroundColor = [UIColor whiteColor];
        
        
        __weak typeof(self) superView = self;
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superView);
            make.bottom.equalTo(superView);
            make.right.equalTo(superView);
            make.top.equalTo(superView);
        }];
    }
    return self;
}

- (void)setBusLine:(BBusLine *)busLine {
    _busLine = busLine;
    
    [SVProgressHUD show];

    [BBusStationTool busStationForBusLine:busLine success:^(NSArray<BBusStation *> *busStations) {
        [SVProgressHUD dismiss];
        
        self.busLine.busStations = busStations;
        [self.collectionView reloadData];
        
        [BBusGPSTool busGPSForBusLine:busLine success:^(NSArray<BBusGPS*>* busGPSs){
            self.busGPSs = busGPSs;
            
            [self updateBusGps];
            
        } withFailure:^(NSError *error) {
        }];
        
    } withFailure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"获取公交站台失败"];
    }];
    
    // 清理用户选择的站点
    self.selectedBusStation = nil;
    
}

#pragma mark - UICollectionViewCell代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.busLine.busStations.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BBusGPSCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"busgps" forIndexPath:indexPath];
    BBusStation* station = self.busLine.busStations[indexPath.row];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.busStation = station;
    
    BBusGPSCellTipType type = BBusGPSCellTipTypeNone;
    
    // bus 是否到站信息
    for (BBusGPS* gps in self.busGPSs) {
        if (gps.stationNo.intValue == station.orderno.intValue) {
            type = BBusGPSCellTipTypeBusIn;
            NSLog(@"%@ %@", station.name, gps.date);
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
- (void)updateBusGps {
    [self.collectionView reloadData];
    // 向外部发送通知，表示收到了
    [[NSNotificationCenter defaultCenter]postNotificationName:BBusGPSDidUpdateNotifcation object:nil userInfo:@{BBusGPSsName:self.busGPSs}];
}

- (void)selectBusStation:(BBusStation*)busStation {
    self.selectedBusStation = busStation;
    [self.collectionView reloadData];
}

@end
