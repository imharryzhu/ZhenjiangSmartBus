//
//  BCollectionViewLayout.m
//  Bus
//
//  Created by 朱辉 on 16/3/19.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BCollectionViewLayout.h"

@implementation BCollectionViewLayout

- (instancetype)init {
    if(self = [super init]) {
        
        // 水平滚动
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    }
    return self;
}

/**
 *  返回对应位置的item属性
 */
- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* attr = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    
    return attr;
}

/**
 *  当手指离开时调用，始终保持卡片在屏幕中心
 *
 *  @param proposedContentOffset 原本应该停留的位置
 *  @param velocity              力度
 *
 *  @return 最终应该停留的位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    // 当前可见范围的cell
    CGRect nowVisibleRect = (CGRect){self.collectionView.contentOffset, self.collectionView.frame.size};
    
    // 取出屏幕的中心点
    CGFloat screenCenter = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    
    NSArray<UICollectionViewLayoutAttributes*>* nowAttributes = [self layoutAttributesForElementsInRect:nowVisibleRect];
    
    CGFloat minDistance = CGFLOAT_MAX;
    int minIndex = -1;
    for(int i = 0; i < nowAttributes.count; i++) {
        UICollectionViewLayoutAttributes* attr = nowAttributes[i];
        CGFloat distance =  attr.center.x - screenCenter;
        if (fabs(distance) < fabs(minDistance)) {
            minDistance = distance;
            minIndex = i;
        }
    }
    
    // 当力度大于0.3时，说明一定要切换到另一页
    if (fabs(velocity.x) > 0.3) {
        
        // 右边还有元素
        if ( velocity.x > 0 && nowAttributes.count-1 > minIndex) {
            minDistance = nowAttributes[minIndex+1].center.x - screenCenter;
        }else if(velocity.x < 0 && minIndex > 0) {
            minDistance = nowAttributes[minIndex-1].center.x - screenCenter;
        }
    }
    
    CGPoint destPoint = CGPointMake(self.collectionView.contentOffset.x + minDistance, proposedContentOffset.y);
    
    
    // 动画移动到指定位置
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction animations:^{
        self.collectionView.contentOffset = destPoint;
    } completion:^(BOOL finished) {
        if(finished && [self.collectionView.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            [self.collectionView.delegate scrollViewDidEndDecelerating:self.collectionView];
        }
    }];
    

    
    return destPoint;
}


/**
 *  当刷新布局时调用
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    
    self.itemSize = CGSizeMake(self.collectionView.width - 40, self.collectionView.height - 10);
    
}

@end
