//
//  BBusGPSView.h
//  Bus
//
//  Created by 朱辉 on 16/3/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBusLine;
@class BBusStation;
@class BFavoriteBusLine;

@interface BBusGPSView : UIView

@property (nonatomic,strong) BFavoriteBusLine* favoriteBusLine;

/**
 *  用户选择某个公交站点
 */
- (void)selectBusStation:(BBusStation*)busStation;

/**
 *
 */
- (void)pause;
- (void)resume;


@end
