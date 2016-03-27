//
//  BBusLineCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/20.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusLineCell.h"
#import "BBusLineViewModel.h"
#import "BBusLine.h"
#import "BBusStation.h"

#import "BBusStationTool.h"

#import "AFNetworking.h"
#import <objc/runtime.h>

@interface BBusLineCell()

@property (nonatomic,weak) IBOutlet UILabel* fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startStationLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminalStationLabel;

@end

@implementation BBusLineCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)busLineCellWithTableView:(UITableView*)tableView {
    static NSString* reuseId = @"busline";
    
    BBusLineCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if(!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BBusLineCell" owner:nil options:nil] lastObject];
        
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        // 去除分割线
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/**
 *  设置模型数据
 */
- (void)setViewModel:(BBusLineViewModel *)viewModel {
    _viewModel = viewModel;
    
    self.fullNameLabel.font = [viewModel.busLine.fullname maxFontInSize:self.fullNameLabel.bounds.size];
    
    self.fullNameLabel.text = viewModel.busLine.fullname;
    self.firstTimeLabel.text = [BCommon timeFromDateString:viewModel.busLine.firsttime];
    self.lastTimeLabel.text = [BCommon timeFromDateString:viewModel.busLine.lasttime];
    
    // 起始站终点站
    NSArray<BBusStation*>* busStations = viewModel.busLine.busStations;
    
    if(busStations) {
        BBusStation* startStation = [viewModel.busLine.busStations firstObject];
        self.startStationLabel.text = startStation.name;

        BBusStation* terminalStation = [viewModel.busLine.busStations lastObject];
        self.terminalStationLabel.text = terminalStation.name;
    }else{
        self.startStationLabel.text = nil;
        self.terminalStationLabel.text = nil;
        [self setBusStationInfo];
    }
}

/**
 *  从网络获取数据，并设置界面信息
 */
- (void)setBusStationInfo {
    
    // 取消上一次请求
    static NSString* taskKey = @"getstationtask";
    NSURLSessionDataTask* m_task = objc_getAssociatedObject(self, &taskKey);
    if(m_task) {
        [m_task cancel];
        objc_setAssociatedObject(self, &taskKey, nil, OBJC_ASSOCIATION_RETAIN);
    }
    
    
    NSURLSessionDataTask* task = [BBusStationTool busStationForBusLine:self.viewModel.busLine success:^(NSArray<BBusStation *> *busStations) {
        
        self.viewModel.busLine.busStations = busStations;
        
        BBusStation* startStation = [busStations firstObject];       
        self.startStationLabel.text = startStation.name;
        
        BBusStation* terminalStation = [busStations lastObject];
        self.terminalStationLabel.text = terminalStation.name;
        
    } withFailure:nil];
    
    
    objc_setAssociatedObject(self, &taskKey, task, OBJC_ASSOCIATION_RETAIN);
}


@end
