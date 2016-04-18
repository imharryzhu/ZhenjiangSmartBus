//
//  BBusStationTool.m
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusStationTool.h"

#import "MJExtension.h"

#import "BNetworkTool.h"

#import "BBusLine.h"
#import "BBusStation.h"

#import "BBusStationTool.h"

#define BBuslineCacheFile(buslinName, dir) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"busline_%@_%d.plist", buslinName, dir]]

@implementation BBusStationTool

+ (NSURLSessionDataTask*)busStationForBusLine:(BBusLine*)busLine WithDirection:(BBusStationDirection)dir success:(void(^)(NSArray<BBusStation*>* busStations))success withFailure:(void(^)(NSError* error))failure {
    
    NSString* url = [NSString stringWithFormat:@"http://%@/Wcity/Bus/Station/0/%@/%lu?format=json", ZJ_BUSLINES_HOST, busLine.gprsid, (unsigned long)dir];
    
    
    
    return [BNetworkTool GET:url parameters:nil success:^(id responseObject) {
        NSArray* array = [BBusStation mj_objectArrayWithKeyValuesArray:responseObject[@"stationlist"]];
        
        // 保存到本地
        NSString* localFileName = BBuslineCacheFile(busLine.fullname, dir);
        [responseObject[@"stationlist"] writeToFile:localFileName atomically:YES];
        
        if(success) {
            success(array);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


/**
 *  从文件中获取
 */
+ (NSArray<BBusStation*>*)busStationsFromLocal:(NSString*)busLineName WithDirection:(BBusStationDirection)dir{
    
    NSString* fileName = BBuslineCacheFile(busLineName, dir);
    
    return [BBusStation mj_objectArrayWithFile:fileName];
}


@end
