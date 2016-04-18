//
//  BFavoriteBusLine.h
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBusLine;

@interface BFavoriteBusLine : NSObject

@property (nonatomic,strong) BBusLine* busLine;

/**
 *  用户选择的方向
 */
@property (nonatomic,assign) int direction;

@end
