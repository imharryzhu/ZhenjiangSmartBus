//
//  BBusGPS.h
//  Bus
//
//  Created by 朱辉 on 16/3/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBusGPS : NSObject

/*
"arriveStation" = 0,
"direction" = 0,
"busStatus" = 1,
"date" = 2016-3-24 18:44:9,
"stationNo" = 3,
"mygprsid" = 11,
"onboardid" = 7135,
*/

@property (nonatomic,copy) NSNumber* arriveStation;
@property (nonatomic,copy) NSString* direction;
@property (nonatomic,copy) NSNumber* busStatus;
@property (nonatomic,copy) NSString* date;
@property (nonatomic,copy) NSNumber* stationNo;
@property (nonatomic,copy) NSString* onboardid;

 
@end
