//
//  BBFavoriteBusCardCell.h
//  Bus
//
//  Created by 朱辉 on 16/3/19.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFavoriteBusLine;

@interface BFavoriteBusCardCell : UICollectionViewCell

@property (nonatomic,strong) BFavoriteBusLine* favoriteBusLine;

/**
 *  当cell到屏幕中心时
 */
- (void)didSelectedCell;

@end
