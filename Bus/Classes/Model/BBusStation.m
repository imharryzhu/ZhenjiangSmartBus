//
//  BBusStation.m
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusStation.h"
#import <CoreLocation/CoreLocation.h>

@implementation BBusStation

- (NSString *)description {
    
    
    
    return [NSString stringWithFormat:@"%@", self.name];
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"location"];
}

- (CLLocation *)location {
    return [[CLLocation alloc]initWithLatitude:self.latitude.doubleValue longitude:self.longitude.doubleValue];
}

@end
