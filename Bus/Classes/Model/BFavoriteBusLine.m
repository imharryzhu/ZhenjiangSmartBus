//
//  BFavoriteBusLine.m
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BFavoriteBusLine.h"

@implementation BFavoriteBusLine

- (instancetype)init {
    if(self = [super init]) {
     
        // 默认下行
        self.direction = BBusStationDirectionDwon;
    }
    return self;
}

@end
