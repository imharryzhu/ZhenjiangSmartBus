//
//  BAddFavoriteBusCell.h
//  Bus
//
//  Created by 朱辉 on 16/3/20.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAddFavoriteBusCell;

@protocol BAddFavoriteBusCellDelegate <NSObject>
@optional

- (void)busCellDidClickPlusButton:(BAddFavoriteBusCell*)busCell;

- (void)busCellDidClickSettingButton:(BAddFavoriteBusCell*)busCell;

@end

@interface BAddFavoriteBusCell : UICollectionViewCell

@property (nonatomic,weak) id<BAddFavoriteBusCellDelegate> delegate;

@end
