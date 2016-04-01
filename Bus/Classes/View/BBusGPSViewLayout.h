//
//  BBusGPSViewLayout.h
//  Bus
//
//  Created by 朱辉 on 16/3/29.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBusGPSView;

@interface BBusGPSViewLayout : UICollectionViewFlowLayout

/**
 *  所在的view，可以获取数据
 */
@property (nonatomic,weak) BBusGPSView* gpsView;

@end
