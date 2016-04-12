//
//  BBusGPSCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/24.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusGPSCell.h"
#import "BBusLine.h"
#import "BBusStation.h"

#import "BCommon.h"

#import "Masonry.h"

@interface BBusGPSCell()

@property (weak, nonatomic) IBOutlet UILabel *busStationNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *tipButton;

@end

@implementation BBusGPSCell


-(void)awakeFromNib {
    self.selected = NO;
}

- (void)setBusStation:(BBusStation *)busStation {
    _busStation = busStation;
//    self.backgroundColor = [UIColor lightGrayColor];
    
    _busStation = busStation;
    
    // 截取公交站点主要部分
    NSArray* stationName = [BCommon subNameInStationName:busStation.name];
    NSMutableString* name = [NSMutableString stringWithString:stationName[0]];
    
    for (int i = (int)name.length - 1; i > 0; i--) {
        [name insertString:@"\n" atIndex:i];
    }
    
    self.busStationNameLabel.text = name;
    
    self.busStationNameLabel.font = [name maxFontInSize:CGSizeMake(self.busStationNameLabel.width, self.busStationNameLabel.height) maxFontSize:20];
    
}

- (void)setTipType:(BBusGPSCellTipType)tipType {
    _tipType = tipType;
    
    self.tipButton.hidden = NO;
    if(tipType == BBusGPSCellTipTypeCurrent) {
        [self.tipButton setImage:[UIImage imageNamed:@"favorite_card_location"] forState:UIControlStateNormal];
    } else if (tipType == BBusGPSCellTipTypeSelected) {
        [self.tipButton setImage:[UIImage imageNamed:@"favorite_card_location_highlight"] forState:UIControlStateNormal];
    } else if (tipType == BBusGPSCellTipTypeBusIn) {
        [self.tipButton setImage:[UIImage imageNamed:@"busstation_bus_small"] forState:UIControlStateNormal];
    } else if(tipType == BBusGPSCellTipTypeBusArrive) {
        [self.tipButton setImage:[UIImage imageNamed:@"busstation_bus_small"] forState:UIControlStateNormal];
//        self.tipButton.backgroundColor = [UIColor yellowColor];
    } else {
        self.tipButton.hidden = YES;
        self.tipButton.backgroundColor = [UIColor clearColor];
    }
    
    
}

/**
 *  用户手动选择了公交站点
 */
- (IBAction)btnClick:(id)sender {
    // 通知外部，用户选择了哪个
    [[NSNotificationCenter defaultCenter]postNotificationName:BBuStationDidSelectedNotifcation object:nil userInfo:@{BSelectedBusStation:self.busStation}];
}


@end
