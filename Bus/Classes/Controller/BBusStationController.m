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

#import "BBusStation.h"

#import "BBusStationCell.h"

@interface BBusStationController()

@property (nonatomic,strong) NSArray<BBusStation*>* busStations;

@end

@implementation BBusStationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeClick)];
    
    UIButton* changeDirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeDirBtn setImage:[UIImage imageNamed:@"change_direction"] forState:UIControlStateNormal];
    [changeDirBtn sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:changeDirBtn];
    
}

- (void)setBusLine:(BBusLine*)busLine {
    _busLine = busLine;
    
    [SVProgressHUD show];
    [BBusStationTool busStationForBusLine:busLine success:^(NSArray<BBusStation *> *busStations) {
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

/**
 *  关闭按钮
 */
- (void)closeClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
