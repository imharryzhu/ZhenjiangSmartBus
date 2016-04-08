//
//  BBusGPSCell.h
//  Bus
//
//  Created by 朱辉 on 16/3/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBusStation;


typedef NS_ENUM(NSUInteger, BBusGPSCellTipType) {
    BBusGPSCellTipTypeNone = 0,
    BBusGPSCellTipTypeBusIn,    // bus 所在的站点(已经过)
    BBusGPSCellTipTypeBusArrive,// bus 已经到达的站点(已到站)
    BBusGPSCellTipTypeSelected, // 用户选择的站
    BBusGPSCellTipTypeCurrent, // 用户距离最近的站
};


@interface BBusGPSCell : UICollectionViewCell

@property (nonatomic,strong) BBusStation* busStation;

@property (nonatomic,assign) BBusGPSCellTipType tipType;

@end
