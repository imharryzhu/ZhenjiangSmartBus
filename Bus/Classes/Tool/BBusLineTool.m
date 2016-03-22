//
//  BBusLineTool.m
//  Bus
//
//  Created by 朱辉 on 16/3/22.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusLineTool.h"
#import "BNetworkTool.h"

#import "BBusLine.h"

#import "MJExtension.h"

#define ZJ_BUSLINES_HOST @"221.131.71.166:55905"

@implementation BBusLineTool

+ (void)busLineswithSuccess:(void(^)(NSArray<BBusLine*>* busLines))success withFailure:(void(^)(NSError* error))failure {
    // 从网络数据
    [self busLinesFromInternetWithsuccess:^(NSArray<BBusLine *> *busLines) {
        // 成功回调
        success(busLines);
    } failure:^(NSError* error){
        failure(error);
    }];
}

/**
 *  从网络获取BusLine数组
 */
+ (void)busLinesFromInternetWithsuccess:(void(^)(NSArray<BBusLine*>* busLines))success failure:(void(^)(NSError* error))failure {
    NSString* url = [NSString stringWithFormat:@"http://%@/Wcity/Bus/Line/%d?format=json", ZJ_BUSLINES_HOST, 0];
    [BNetworkTool GET:url parameters:nil success:^(id responseObject) {
        
        NSArray* array = [BBusLine mj_objectArrayWithKeyValuesArray:responseObject[@"linelist"]];
        success(array);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
