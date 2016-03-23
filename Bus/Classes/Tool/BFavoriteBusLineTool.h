//
//  BFavoriteBusLineTool.h
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFavoriteBusLine;

static NSString* BFavoriteChangeNotification = @"BFavoriteChangeNotification";

@interface BFavoriteBusLineTool : NSObject

/**
 *  获取实例
 */
+ (instancetype)defaultTool;

/**
 *  获取用户收藏的公交线路
 */
- (NSArray<BFavoriteBusLine*>*)favoriteBusLines;

/**
 *  重新刷新收藏
 */
- (void)flush;

/**
 *  保存到文件
 */
- (BOOL)saveToFile;

/**
 *  删除某个收藏
 */
- (BOOL)deleteBusLine:(BFavoriteBusLine*)busLine;

/**
 *  添加某个收藏
 */
- (BOOL)addBusLine:(BFavoriteBusLine*)busLine;

@end
