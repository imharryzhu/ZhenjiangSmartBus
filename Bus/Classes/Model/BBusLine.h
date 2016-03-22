//
//  BBusLine.h
//  Bus
//
//  Created by 朱辉 on 16/3/22.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBusLine : NSObject

@property (nonatomic,copy) NSString* gprsid;
/**
 *  末班车 时间
 */
@property (nonatomic,copy) NSString* lasttime;
/**
 *  首班车 时间
 */
@property (nonatomic,copy) NSString* firstimeLs;
/**
 *  方向
 */
@property (nonatomic,copy) NSString* direction;
/**
 *  公交线路编号
 */
@property (nonatomic,copy) NSString* orderno;

@property (nonatomic,copy) NSString* firsttime;
/**
 *  线路名称
 */
@property (nonatomic,copy) NSString* fullname;

@end
