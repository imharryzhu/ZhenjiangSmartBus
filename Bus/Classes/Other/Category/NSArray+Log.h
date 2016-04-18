//
//  NSArray+Log.h
//  MyZJ
//
//  Created by 朱辉 on 16/2/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Log)

/**
 *  获取类的所有属性
 */
+ (instancetype)getProperties:(Class)cls;

@end

@interface NSDictionary (Log)

@end