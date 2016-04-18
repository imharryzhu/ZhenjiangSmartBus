//
//  BBusGPSTool.h
//  Bus
//
//  Created by 朱辉 on 16/3/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBusLine;
@class BBusGPS;
@interface BBusGPSTool : NSObject

// gprs /Wcity/Bus/BusGPS/0/191/0?format=json

/**
 *  获取时时公交
 *  @param busLine     busline
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
+ (void)busGPSForBusLine:(BBusLine*)busLine WithDirection:(BBusStationDirection)dir success:(void(^)(NSArray<BBusGPS*>* busGPSs))success withFailure:(void(^)(NSError* error))failure;

@end
