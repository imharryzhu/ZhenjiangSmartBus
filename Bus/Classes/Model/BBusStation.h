//
//  BBusStation.h
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBusStation : NSObject

/**
 *  "gprsid" = 1161,
 "Id" = 0,
 "longitude" = 119.441035116848,
 "isdisable" = 0,
 "latitude" = 32.2019244544248,
 "bystartdistance" = 0.0,
 "direction" = 0,
 "orderno" = 1,
 "name" = 火车站南广场
 */


@property (nonatomic,copy) NSString* gprsid;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSNumber* longitude;
@property (nonatomic,copy) NSString* isdisable;
@property (nonatomic,copy) NSNumber* latitude;
@property (nonatomic,copy) NSString* bystartdistance;
@property (nonatomic,copy) NSString* direction;
@property (nonatomic,copy) NSString* orderno;
@property (nonatomic,copy) NSString* name;


@end
