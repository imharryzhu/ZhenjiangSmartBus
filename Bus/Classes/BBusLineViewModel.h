//
//  BBusLineViewModel.h
//  Bus
//
//  Created by 朱辉 on 16/3/22.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBusLine;

@interface BBusLineViewModel : NSObject

@property (nonatomic,strong) BBusLine* busLine;

/**
 *  公交名称
 */
@property (nonatomic,copy) NSString* busName;

/**
 *  始发站
 */
@property (nonatomic,copy) NSString* startStation;

/**
 *  终点站
 */
@property (nonatomic,copy) NSString* terminateStation;

@end
