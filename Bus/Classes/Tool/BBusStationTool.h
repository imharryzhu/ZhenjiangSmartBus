//
//  BBusStationTool.h
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBusStation;
@class BBusLine;

@interface BBusStationTool : NSObject

/**
 *  获取某条公交线路上的具体公交站
 *  @param busLine     busline
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
+ (void)busStationForBusLine:(BBusLine*)busLine success:(void(^)(NSArray<BBusStation*>* busStations))success withFailure:(void(^)(NSError* error))failure;

@end
