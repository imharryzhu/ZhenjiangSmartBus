//
//  BBusGPSTool.m
//  Bus
//
//  Created by 朱辉 on 16/3/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusGPSTool.h"
#import "BNetworkTool.h"

#import "MJExtension.h"

#import "BBusLine.h"
#import "BBusGPS.h"

@implementation BBusGPSTool

+ (void)busGPSForBusLine:(BBusLine*)busLine WithDirection:(BBusStationDirection)dir success:(void(^)(NSArray<BBusGPS*>* busGPSs))success withFailure:(void(^)(NSError* error))failure {
    
    NSString* url = [NSString stringWithFormat:@"http://%@/Wcity/Bus/BusGPS/0/%@/%lu?format=json", ZJ_BUSLINES_HOST, busLine.orderno, (unsigned long)dir];
    
    [BNetworkTool GET:url parameters:nil success:^(id responseObject) {
        
        NSArray* busGps = [BBusGPS mj_objectArrayWithKeyValuesArray:responseObject[@"GPSlist"]];
        success(busGps);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}


@end
