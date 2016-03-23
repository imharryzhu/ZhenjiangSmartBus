//
//  BBusLineCell.h
//  Bus
//
//  Created by 朱辉 on 16/3/20.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBusLineViewModel;

@interface BBusLineCell : UITableViewCell

+ (instancetype)busLineCellWithTableView:(UITableView*)tableView;

/**
 *  viewmodel
 */
@property (nonatomic,strong) BBusLineViewModel* viewModel;

@end
