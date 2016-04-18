//
//  BBusStationController.h
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBusStation;
@class BBusLine;

@interface BBusStationController : UITableViewController


@property (nonatomic,strong) BBusLine* busLine;

@property (nonatomic,assign) int row;

/**
 *  是否收藏
 */
@property (nonatomic,assign,getter=isCollected) BOOL collected;

@end
