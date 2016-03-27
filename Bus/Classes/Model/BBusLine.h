//
//  BBusLine.h
//  Bus
//
//  Created by 朱辉 on 16/3/22.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBusStation;

@interface BBusLine : NSObject

@property (nonatomic,copy) NSString* gprsid;

/**
 *  方向
 */
@property (nonatomic,copy) NSString* direction;
/**
 *  公交线路编号
 */
@property (nonatomic,copy) NSString* orderno;

/**
 *  首班车 时间
 */
@property (nonatomic,copy) NSString* firsttime;
@property (nonatomic,copy) NSString* firstimeLs;

/**
 *  末班车 时间
 */
@property (nonatomic,copy) NSString* lasttimeLs;
@property (nonatomic,copy) NSString* lasttime;


/**
 *  线路名称
 */
@property (nonatomic,copy) NSString* fullname;

/**
 *  busstaitons
 */
@property (nonatomic,strong) NSArray<BBusStation*>* busStations;

@end
