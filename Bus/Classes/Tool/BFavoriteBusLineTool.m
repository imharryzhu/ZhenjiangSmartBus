//
//  BFavoriteBusLineTool.m
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BFavoriteBusLineTool.h"
#import "BBusLine.h"
#import "BFavoriteBusLine.h"

#import "MJExtension.h"

#define BFavoriteBusLinesFileName @"FavoriteBusLines.plist"
#define BFavoriteBusLinesFullName [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:BFavoriteBusLinesFileName]


@interface BFavoriteBusLineTool()

@property (nonatomic,strong) NSMutableArray<BFavoriteBusLine*>* favoriteBusLines;

@end

@implementation BFavoriteBusLineTool

+ (instancetype)defaultTool {
    static BFavoriteBusLineTool* _instance = nil;
    
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        _instance = [[BFavoriteBusLineTool alloc]init];
    });
    return _instance;
}

- (NSArray<BFavoriteBusLine*>*)favoriteBusLines {
    if(!_favoriteBusLines) {
        _favoriteBusLines = [NSMutableArray array];
        
        // 从文件读取
        NSArray* array = [BFavoriteBusLine mj_objectArrayWithFile:BFavoriteBusLinesFullName];
        [_favoriteBusLines addObjectsFromArray:array];
        
        
        // 尝试从本地加载 公交线路
        for (BFavoriteBusLine* favorite in array) {
            [favorite.busLine busStations];
        }
        
    }
    return _favoriteBusLines;
}

- (void)flush {
    _favoriteBusLines = nil;
}

- (BOOL)saveToFile {
    
    NSArray* array = [BFavoriteBusLine mj_keyValuesArrayWithObjectArray:_favoriteBusLines];
    return [array writeToFile:BFavoriteBusLinesFullName atomically:YES];
}

- (BOOL)deleteBusLine:(BFavoriteBusLine*)busLine {
    [_favoriteBusLines removeObject:busLine];
    
    return [self saveToFile];
}

- (BOOL)addBusLine:(BFavoriteBusLine*)busLine {
    [_favoriteBusLines addObject:busLine];
    
    return [self saveToFile];
}

@end
