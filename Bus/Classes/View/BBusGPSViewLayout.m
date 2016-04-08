//
//  BBusGPSViewLayout.m
//  Bus
//
//  Created by 朱辉 on 16/3/29.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusGPSViewLayout.h"

#import "BBusGPSView.h"
#import "BBusLine.h"
#import "BBusStation.h"

#import <CoreLocation/CoreLocation.h>

@interface BBusGPSViewLayout()

@property (nonatomic,assign) CGFloat maxX;

@end

@implementation BBusGPSViewLayout

- (instancetype)init {
    if(self = [super init]) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

/**
 *  返回对应位置的item属性
 */
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes* attr = [super layoutAttributesForItemAtIndexPath:indexPath];
//    
//    NSArray<BBusStation*>* busStations = self.gpsView.busLine.busStations;
//    
//    BBusStation* preStation = indexPath.row > 0?[busStations objectAtIndex:indexPath.row - 1]:nil;
//    BBusStation* curStation = [busStations objectAtIndex:indexPath.row];
//    
//    CLLocation* preLocation = [[CLLocation alloc]initWithLatitude:preStation.latitude.doubleValue longitude:preStation.longitude.doubleValue];
//    CLLocation* curLocation = [[CLLocation alloc]initWithLatitude:curStation.latitude.doubleValue longitude:curStation.longitude.doubleValue];
//    
//    double distance  = indexPath.row == 0 ? 0 : [preLocation distanceFromLocation:curLocation];
//    
//    CGSize size = attr.size;
//    size.width += (int)distance / 10;
//    size.height = self.collectionView.height;
//    
//    attr.frame = (CGRect){{self.maxX, 0}, size};
//    
//    self.maxX += size.width;
//    
//    return attr;
//}
//
//- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    self.maxX = 0;
//    NSMutableArray* array = [NSMutableArray array];
//    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
//        
//        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        
//        UICollectionViewLayoutAttributes* attr = [self layoutAttributesForItemAtIndexPath:indexPath];
//        [array addObject:attr];
//    }
//    return array;
//}


- (void)prepareLayout {
    
    self.itemSize = CGSizeMake(30, self.collectionView.frame.size.height);
    self.minimumLineSpacing = 0;
}

@end
