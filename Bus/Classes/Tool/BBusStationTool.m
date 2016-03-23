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

@implementation BBusStationTool

+ (void)busStationForBusLine:(BBusLine*)busLine success:(void(^)(NSArray<BBusStation*>* busStations))success withFailure:(void(^)(NSError* error))failure {
    
    NSString* url = [NSString stringWithFormat:@"http://%@/Wcity/Bus/Station/0/%@/0?format=json", ZJ_BUSLINES_HOST, busLine.orderno];
    
    [BNetworkTool GET:url parameters:nil success:^(id responseObject) {
        NSArray* array = [BBusStation mj_objectArrayWithKeyValuesArray:responseObject[@"stationlist"]];
        success(array);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


@end
