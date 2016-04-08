//
//  BUser.h
//  Bus
//
//  Created by 朱辉 on 16/4/2.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;
@class BBusStation;

@interface BUser : NSObject

+ (instancetype)defaultUser;

/**
 *  保存用户当前位置
 */
@property (nonatomic,strong) CLLocation* curLocation;

/**
 *  保存用户距离最近的公交站点
 */
@property (nonatomic,weak) BBusStation* nearestStation;

@end
