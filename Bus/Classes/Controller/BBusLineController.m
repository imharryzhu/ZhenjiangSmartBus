//
//  BBusLineController.m
//  Bus
//
//  Created by 朱辉 on 16/3/20.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusLineController.h"
#import "BBusStationController.h"
#import "BBusLineCell.h"

#import "BBusLineViewModel.h"
#import "BBusLine.h"
#import "BFavoriteBusLine.h"

#import "BBusLineTool.h"
#import "BFavoriteBusLineTool.h"

#import "SVProgressHUD.h"

#import "MJRefresh.h"
#import "MJRefreshComponent.h"
#import "MJRefreshStateHeader.h"

#import "MobClick.h"

@interface BBusLineController ()

@property (nonatomic,strong) NSArray<BBusLineViewModel*>* busLineViewModels;

@end

@implementation BBusLineController

+ (NSString*)description {
    return [NSString stringWithFormat:@"收藏线路(%@)",NSStringFromClass([self class])];
}

#pragma mark - 友盟页面统计

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[[self class]description]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick endLogPageView:[[self class]description]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"公交列表";
    
    [self initView];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadBusLinesFromInternet)];
    
    // 尝试从本地加载数据
    NSArray* busLines = [BBusLineTool busLinesFromLocal];
    
    if(busLines.count == 0){
        [self.tableView.mj_header beginRefreshing];
    } else {
        NSMutableArray* buslineViewModels = [NSMutableArray array];
        
        for (BBusLine* busline in busLines) {
            BBusLineViewModel* viewModel = [[BBusLineViewModel alloc]init];
            viewModel.busLine = busline;
            [buslineViewModels addObject:viewModel];
        }
        self.busLineViewModels = buslineViewModels;
        [self.tableView reloadData];
    }
    
}

/**
 *  从网络获取公交数据
 */
- (void)loadBusLinesFromInternet {
    // 请求数据
    [BBusLineTool busLineswithSuccess:^(NSArray<BBusLine *> *busLines) {
        [SVProgressHUD dismiss];
        
        NSMutableArray* buslineViewModels = [NSMutableArray array];
        
        for (BBusLine* busline in busLines) {
            BBusLineViewModel* viewModel = [[BBusLineViewModel alloc]init];
            viewModel.busLine = busline;
            [buslineViewModels addObject:viewModel];
        }
        self.busLineViewModels = buslineViewModels;
        
        
        [self.tableView reloadData];
        
    } withFailure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
    [self.tableView.mj_header endRefreshing];
}

/**
 *  初始化tableView
 */
- (void)initView {
    // tableView的颜色
    self.tableView.backgroundColor = rgb(213, 213, 213);
    
    // 去除分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 20;
    
//    self.tableView.contentInset =  UIEdgeInsetsMake(0, 0, 0, 10);
}

#pragma mark - tableView代理

/**
 * tableView列数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.busLineViewModels.count;
}

/**
 *  返回每行的cell
 *
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBusLineCell* cell = [BBusLineCell busLineCellWithTableView:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BBusLineViewModel* viewModel = self.busLineViewModels[indexPath.row];
    
    cell.viewModel = viewModel;
    
    return cell;
}

/**
 *  每行cell的高度
 */
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BBusStationController* stationVC = [[BBusStationController alloc]init];
    
    BBusLineViewModel* viewModel = [self.busLineViewModels objectAtIndex:indexPath.row];
    
    stationVC.busLine = viewModel.busLine;
    
    // 判断是否收藏
    BOOL tmp = NO;
    // 判断是否收藏
    for (BFavoriteBusLine* line in [BFavoriteBusLineTool defaultTool].favoriteBusLines) {
        if([line.busLine.fullname isEqualToString:viewModel.busLine.fullname]){
            tmp = YES;
            break;
        }
    }
    
    stationVC.collected = tmp;
    stationVC.row = indexPath.row;
    
    [self.navigationController pushViewController:stationVC animated:YES];
}

@end
