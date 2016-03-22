//
//  BBusLineCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/20.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusLineCell.h"

@interface BBusLineCell()

/**
 *  公交名称
 */
@property (nonatomic,weak) UILabel* fullNameLabel;

/**
 *  始发站名称
 */
@property (nonatomic,weak) UILabel* startStationNameLabel;

/**
 *  终点站名称
 */
@property (nonatomic,weak) UILabel* terminateStationNameLabel;

@end

@implementation BBusLineCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)busLineCellWithTableView:(UITableView*)tableView {
    static NSString* reuseId = @"busline";
    
    BBusLineCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if(!cell) {
        cell = [[BBusLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cell已收藏"]];
        imageView.x = 0;
        imageView.y = 0;
        [self addSubview:imageView];
        
        
        // 去除分割线
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/**
 *  设置模型数据
 */
- (void)setViewModel:(BBusLineViewModel *)viewModel {
    _viewModel = viewModel;
    
    
}


@end
