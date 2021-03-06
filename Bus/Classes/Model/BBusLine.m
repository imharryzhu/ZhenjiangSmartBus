//
//  BBusLine.m
//  Bus
//
//  Created by 朱辉 on 16/3/22.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusLine.h"
#import "BBusStationTool.h"

@implementation BBusLine

- (NSString *)description {
    return self.fullname;
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"busStations"];
}

- (NSArray<BBusStation *> *)busStations {
    if(!_busStations) {
//        NSArray<BBusStation*>* busStation = [BBusStationTool busStationsFromLocal:self.fullname WithDirection:];
//        _busStations = busStation;
    }
    return _busStations;
}

- (nullable NSArray<BBusStation*>*)busStationsWithDirection:(BBusStationDirection)direction {
    
    NSArray<BBusStation*>* busStation = [BBusStationTool busStationsFromLocal:self.fullname WithDirection:direction];
    
    return busStation;
}

@end
