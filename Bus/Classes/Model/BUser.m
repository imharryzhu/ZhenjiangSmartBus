//
//  BUser.m
//  Bus
//
//  Created by 朱辉 on 16/4/2.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BUser.h"

@implementation BUser

+ (instancetype)defaultUser {
    static BUser* _user = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _user = [[BUser alloc]init];
    });
    return _user;
}

@end
