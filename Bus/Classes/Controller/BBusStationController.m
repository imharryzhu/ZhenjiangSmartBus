//
//  BBusStationController.m
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusStationController.h"

#import "SVProgressHUD.h"

#import "BBusStationTool.h"
#import "BFavoriteBusLineTool.h"

#import "BBusStation.h"
#import "BBusLine.h"
#import "BFavoriteBusLine.h"

#import "BBusStationCell.h"

#import "MobClick.h"

@interface BBusStationController()

@property (nonatomic,strong) NSArray<BBusStation*>* busStations;

@end

@implementation BBusStationController

+ (NSString*)description {
    return [NSString stringWithFormat:@"线路详情(%@)",NSStringFromClass([self class])];
}

#pragma mark - 友盟页面统计

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[[self class]description]];
    
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick endLogPageView:[[self class]description]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setBusLine:(BBusLine*)busLine {
    _busLine = busLine;
    
    self.title = busLine.fullname;
    
    [SVProgressHUD show];
    [BBusStationTool busStationForBusLine:busLine WithDirection:BBusStationDirectionDwon success:^(NSArray<BBusStation *> *busStations) {
        [SVProgressHUD dismiss];
        
        self.busStations = busStations;
        
        [self.tableView reloadData];
        
        for (BBusStation *station in self.busStations) {
            NSLog(@"！！！%@", station);
        }
        
    } withFailure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)setCollected:(BOOL)collected {
    _collected = collected;
    
    NSString* title = collected ? @"取消收藏" : @"收藏";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(collectClick)];
    
}


/**
 * tableView列数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.busStations.count;
}

/**
 *  返回每行的cell
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BBusStationCell* cell = [BBusStationCell busStationCellWithTableView:tableView];
    
    BBusStation* busStation = [self.busStations objectAtIndex:indexPath.row];
    
    cell.busStation = busStation;
    
    return cell;
}

/**
 *  每行cell的高度
 */
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 108;
//}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)collectClick {
    
    if (self.collected) { //取消收藏
        
        UIAlertView* view = [[UIAlertView alloc]initWithTitle:@"" message:@"删除该收藏？" delegate:nil cancelButtonTitle:@"不删除" otherButtonTitles:@"是的", nil];
        view.delegate = self;
        [view show];
        
    }else{ // 添加收藏
        BFavoriteBusLine* favorite = [[BFavoriteBusLine alloc]init];
        favorite.busLine = self.busLine;
        
        if([[BFavoriteBusLineTool defaultTool]addBusLine:favorite]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:BFavoriteChangeNotification object:nil];
        }
        self.collected = YES;
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1) {
        NSArray* array = [[BFavoriteBusLineTool defaultTool]favoriteBusLines];
        for (int i = (int)array.count-1 ; i >= 0; i--) {
            BFavoriteBusLine* favorite = [array objectAtIndex:i];
            if([favorite.busLine.fullname isEqualToString:self.busLine.fullname]){
                if([[BFavoriteBusLineTool defaultTool]deleteBusLine:favorite]){
                    [[NSNotificationCenter defaultCenter]postNotificationName:BFavoriteChangeNotification object:nil];
                    self.collected = NO;
                }
            }
        }
    }
}


@end
