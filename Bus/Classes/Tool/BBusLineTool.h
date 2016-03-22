//
//  BBusLineTool.h
//  Bus
//
//  Created by 朱辉 on 16/3/22.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBusLine;

@interface BBusLineTool : NSObject

/**
 *  获取城市公交线路
 *
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
+ (void)busLineswithSuccess:(void(^)(NSArray<BBusLine*>* busLines))success withFailure:(void(^)(NSError* error))failure;

@end
