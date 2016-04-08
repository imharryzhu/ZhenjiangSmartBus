//
//  BBFavoriteBusCardCell.h
//  Bus
//
//  Created by 朱辉 on 16/3/19.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFavoriteBusLine;
@class BBusStation;
@class BBusGPS;
@class BFavoriteBusCardCell;

@class BBusGPSView;


@protocol BFavoriteBusCardDelegate <NSObject>

@optional
/**
 *  当关闭按钮按下
 */
- (void)favoriteBusCardDidCloseClick:(BFavoriteBusCardCell*)cardCell;

@end

@interface BFavoriteBusCardCell : UICollectionViewCell

@property (nonatomic,strong) BFavoriteBusLine* favoriteBusLine;
@property (nonatomic,strong) NSArray<BBusGPS*>* busGPSs;

@property (nonatomic,weak) BBusGPSView* gpsView;

/**
 *  用户选择某个公交站点
 */
- (void)selectBusStation:(BBusStation*)busStation;

/**
 *  使用定位服务定位用户位置，判定周边最近的公交站作为当前站
 */
- (void)setUserCurrentStationWithUserLocation;

@property (nonatomic,strong) id<BFavoriteBusCardDelegate> delegate;

@end
