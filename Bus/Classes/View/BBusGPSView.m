//
//  BBusGPSView.m
//  Bus
//
//  Created by 朱辉 on 16/3/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusGPSView.h"

#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "Masonry.h"

#import "BBusLine.h"
#import "BBusStation.h"
#import "BBusGPS.h"

#import "BBusGPSCell.h"

#import "BBusStationTool.h"
#import "BBusGPSTool.h"

@interface BBusGPSView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) NSArray<BBusGPS*>* busGPSs;

@property (nonatomic,weak) UICollectionView* collectionView;

@end

@implementation BBusGPSView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(15, 182);
        
        
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
    
    cell.backgroundColor = [UIColor redColor];
    cell.busStation = station;
    
    for (BBusGPS* gps in self.busGPSs) {
        if (gps.stationNo.intValue == indexPath.row) {
            cell.backgroundColor = [UIColor greenColor];
            
            if(gps.arriveStation.intValue == 1)
            {
                cell.backgroundColor = [UIColor yellowColor];
            }
        }
        
    }
    
    return cell;
}


/**
 *  获取公交最新位置时，更新列表
 */
- (void)updateBusGps {
    
    [self.collectionView reloadData];
    
    // 当前站点
    int curStationNo = 6;
    int nearsetNo = 0;
    
    for (int no = 0; no < self.busGPSs.count; no++) {
        BBusGPS* gps = [self.busGPSs objectAtIndex:no];
        if(gps.stationNo.intValue > curStationNo) {
            break;
        }else{
            nearsetNo = gps.stationNo.intValue;
        }
    }
    
    NSLog(@"%@", self.busLine.busStations[nearsetNo]);
    
}

@end
