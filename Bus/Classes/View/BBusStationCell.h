//
//  BBusStationCell.h
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBusStation;

@interface BBusStationCell : UITableViewCell

+ (instancetype)busStationCellWithTableView:(UITableView*)tableView;

@property (nonatomic,strong) BBusStation* busStation;

@end
