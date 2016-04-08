
//
//  BBFavoriteBusCardCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/19.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BFavoriteBusCardCell.h"
#import "BFavoriteBusLine.h"
#import "BBusGPSView.h"

#import "BBusLine.h"
#import "BBusStation.h"
#import "BUser.h"
#import "BBusGPS.h"

#import "BLabel.h"
#import "BCommon.h"

#import <CoreLocation/CoreLocation.h>

@interface BFavoriteBusCardCell()

@property (weak, nonatomic) IBOutlet BLabel *busLineNameLabel;

/**
 *  首班时间
 */
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
/**
 *  末班时间
 */
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;


@property (weak, nonatomic) IBOutlet UILabel *endStationLabel;
@property (weak, nonatomic) IBOutlet UILabel *endStationSubLabel;

@property (weak, nonatomic) IBOutlet UIButton *locationButton;

/**
 *  当前站
 */
@property (weak, nonatomic) IBOutlet UILabel *currentStationNameLabel;
/**
 *  当前站子标题
 */
@property (weak, nonatomic) IBOutlet UILabel *currentStationSubLabel;

/**
 *  公交所在的站点label
 */
@property (weak, nonatomic) IBOutlet UILabel *busArriveStationLabel;

@property (weak, nonatomic) IBOutlet UILabel *busArriveStationSubLabel;

/**
 *  计算剩余时间label
 */
@property (weak, nonatomic) IBOutlet UILabel *surplusTimeLabel;

/**
 *  预计用时label
 */
@property (weak, nonatomic) IBOutlet UILabel *guessLabel;
/**
 *  预计用时 时间单位Label
 */
@property (weak, nonatomic) IBOutlet UILabel *guessUnitLabel;

/**
 *  到站提醒label
 */
@property (weak, nonatomic) IBOutlet UILabel *busArriveTipLabel;
/**
 *  还剩多少站label
 */
@property (weak, nonatomic) IBOutlet UILabel *countOfStationLabel;

/*********autolayout*********/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *busLineNameLabelHeight;

/**
 *  开往方向view顶部距离
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *busDirViewTop;

/**
 *  用户选择位置view顶部距离
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selfLocationViewTop;

/**
 *  公交车view顶部距离
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *busLocationViewTop;

/**
 *  公交车view底部距离
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *busLocationViewBottom;

/**
 *  目的站底部 距离底部距离
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *endStationNameBottom;

/**
 *  busLineNameLabel上方的间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *busLineNameTop;
@property (weak, nonatomic) IBOutlet UILabel *aaa;


/********** 公交信息 ************/
@property (nonatomic,strong) BBusStation* currentStation;

@end

@implementation BFavoriteBusCardCell

- (void)awakeFromNib {
    // 设置卡片的圆角
    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    // 公交线路名称垂直居下
    self.busLineNameLabel.verticalAlignment = VerticalAlignmentBottom;
    
    if([UIScreen mainScreen].bounds.size.height <= 480) { // 4s
        self.busLineNameLabelHeight.constant = 60;
        self.busLineNameTop.constant = 0;
        self.busDirViewTop.constant = 0;
        self.selfLocationViewTop.constant = 0;
        self.busLocationViewTop.constant = 0;
        self.endStationNameBottom.constant = 0;
        // 预计/分钟字体大小
        self.guessLabel.font = [UIFont systemFontOfSize:9];
        self.guessUnitLabel.font = [UIFont systemFontOfSize:9];
        self.busArriveTipLabel.font =[UIFont systemFontOfSize:13];
    } else if ([UIScreen mainScreen].bounds.size.height <= 568) { // 5s
        self.busLineNameTop.constant /= 2;
        self.busDirViewTop.constant /= 2;
        self.selfLocationViewTop.constant /= 2;
        self.busLocationViewTop.constant /= 2;
        self.endStationNameBottom.constant /= 2;
        // 预计/分钟字体大小
        self.guessLabel.font = [UIFont systemFontOfSize:9];
        self.guessUnitLabel.font = [UIFont systemFontOfSize:9];
        self.busArriveTipLabel.font =[UIFont systemFontOfSize:13];
    }else if([UIScreen mainScreen].bounds.size.height <= 667) {  // 6s
        self.selfLocationViewTop.constant /= 2;
        self.busLocationViewTop.constant /= 2;
        // 预计/分钟字体大小
        self.guessLabel.font = [UIFont systemFontOfSize:11];
        self.guessUnitLabel.font = [UIFont systemFontOfSize:12];
        self.busArriveTipLabel.font =[UIFont systemFontOfSize:18];
    }else if([UIScreen mainScreen].bounds.size.height <= 736) { // 6sp
        self.busLocationViewBottom.constant = 45;
        self.busArriveTipLabel.font =[UIFont systemFontOfSize:22];
        self.guessLabel.font = [UIFont systemFontOfSize:14];
        self.guessUnitLabel.font = [UIFont systemFontOfSize:15];
    }
}

- (IBAction)closeCardClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(favoriteBusCardDidCloseClick:)]){
        [self.delegate favoriteBusCardDidCloseClick:self];
    }
}

- (IBAction)locationButtonClick:(id)sender {
    // 如果是选中状态，表示用户自己选择了某个公交站点，点击该按钮时，需要回到用户定位的公交站点
    if(self.locationButton.selected){
        
        [self setUserCurrentStationWithUserLocation];
        
        [self.gpsView selectBusStation:self.currentStation];
    }
}

- (void)setFavoriteBusLine:(BFavoriteBusLine *)favoriteBusLine {
    _favoriteBusLine = favoriteBusLine;
    
    // 公交名称
    
    self.busLineNameLabel.text = favoriteBusLine.busLine.fullname;
    
    // 首末班时间,需要将日期截掉
    self.startTimeLabel.text = [NSString stringWithFormat:@"早 %@", [BCommon timeFromDateString:favoriteBusLine.busLine.firsttime]];
    self.endTimeLabel.text = [NSString stringWithFormat:@"晚 %@", [BCommon timeFromDateString:favoriteBusLine.busLine.lasttime]];
    
    // 目的站
    BBusStation* endBusStation = [favoriteBusLine.busLine.busStations lastObject];
    NSArray<NSString*>* endBusStationName = [BCommon subNameInStationName:endBusStation.name];
    
    self.endStationLabel.text = endBusStationName[0];
    self.endStationSubLabel.text = endBusStationName[1];
    
    if([endBusStationName[1] isEqualToString:@""]) {
        self.endStationNameBottom.constant = 5;
    }else{
        self.endStationNameBottom.constant = 14;
    }
    
    [self updateConstraints];
    [self layoutIfNeeded];
    
    
    // fullName,fullName的宽度不超过自身宽的62%
    self.busLineNameLabel.font =[self.busLineNameLabel.text maxFontInSize:CGSizeMake(self.width * .62, self.busLineNameLabel.frame.size.height)  maxFontSize:50];
    self.busLineNameLabel.verticalAlignment = UIControlContentVerticalAlignmentBottom;

    
    // 开往
//    self.aaa.font = [self.aaa.text maxFontInSize:self.aaa.frame.size  maxFontSize:50];
    
    // 尾站
    self.endStationLabel.font = [self.endStationLabel.text maxFontInSize:self.endStationLabel.frame.size  maxFontSize:50];
    
    // 时间label
    
    self.surplusTimeLabel.font = [self.surplusTimeLabel.text maxFontInSize:CGSizeMake(CGFLOAT_MAX, self.endStationLabel.frame.size.height)   maxFontSize:100];
    // 设置当前位置
    [self setUserCurrentStationWithUserLocation];
}




/**
 *  设置公交GPS数据，并计算时时公交数据
 */
-(void)setBusGPSs:(NSArray<BBusGPS *> *)busGPSs {
    _busGPSs = busGPSs;
    
    [self updateBusInfo];
}


/**
 *  计算当前站与公交之间的信息，并显示在界面上
 */
- (void)updateBusInfo {
    
    // 计算最近一辆公交的所在站点
    BBusGPS* nearsetBusGPS = nil;
    for (BBusGPS* gps in self.busGPSs) {
        if(gps.stationNo.intValue >= self.currentStation.orderno.intValue) {
            break;
        }else{
            nearsetBusGPS = gps;
        }
    }
    
    NSString* stationName =nil;
    NSString* subText = nil;
    NSString* countOfStation = nil;
    do {
        
        if(nearsetBusGPS == nil) {
            stationName = @"目前没有公交在路上~~";
            subText = @"悲剧啊~~";
            countOfStation = @"还有0站";
            break;
        }
        
        BBusStation* nearestBusStation = nil;
        for (BBusStation* station in self.favoriteBusLine.busLine.busStations) {
            if(station.orderno.integerValue == nearsetBusGPS.stationNo.integerValue) {
                nearestBusStation = station;
            }
        }
        
        if(nearestBusStation != nil) {
            stationName = nearestBusStation.name;
        } else {
            stationName = @"卧槽什么情况???!";
            subText = @"尼玛!!!!";
            break;
        }
        
        // 计算两点之间的距离
        CLLocation* curLocation = [self currentLocation];
        CLLocation* busLocation = [[CLLocation alloc]initWithLatitude:nearestBusStation.latitude.doubleValue longitude:nearestBusStation.longitude.doubleValue];
        
        CLLocationDistance distance = [curLocation distanceFromLocation:busLocation];
        
        
        
        NSString* unit = @"米";
        if(distance > 10000) {
            distance /= 1000;
            unit = @"千米";
        }
        subText = [NSString stringWithFormat:@"%.2f%@", distance, unit];
        
        // 计算公交车离开上一站的时间
        
        NSString* timeTip = [BCommon stringFromTimeInterval:[BCommon dateFromDateString:nearsetBusGPS.date]];
        
        subText = [NSString stringWithFormat:@"%@, 距您%@", timeTip, subText];
        
        // 计算剩余站数量
        int countOfStationNum = self.currentStation.orderno.intValue - nearestBusStation.orderno.intValue;
        
        countOfStation = [NSString stringWithFormat:@"还有%d站", countOfStationNum];
        
        
    }while(0);
    
    self.busArriveStationLabel.text = stationName;
    self.busArriveStationSubLabel.text = subText;
    self.countOfStationLabel.text = countOfStation;
    self.surplusTimeLabel.text = @"30";
    
}

- (void)selectBusStation:(BBusStation*)busStation {
    // 如果选中的是当前站
    if(busStation.orderno.intValue == [BUser defaultUser].nearestStation.orderno.intValue) {
        [self setUserCurrentStationWithUserLocation];
        return;
    }
    
    CLLocation* curLocation =  [BUser defaultUser].curLocation;
    
    // 获取用户当前位置距离选中站间隔几站
    BBusStation* nearestStation = [self getNearsetBusStaionAtLocation:curLocation];
    
    int coutOf = abs(nearestStation.orderno.intValue - busStation.orderno.intValue);
    
    // 计算选中的站点距离用户的位置
    CLLocationDistance distance = [busStation.location distanceFromLocation:curLocation];
    
    // 用户自己选中时，图标设置为蓝色
    [self.locationButton setSelected:YES];
    
    self.currentStation = busStation;
    self.currentStationNameLabel.text = busStation.name;
    self.currentStationSubLabel.text = [NSString stringWithFormat:@"距您%d站, %@", coutOf, [self distanceToString:distance]];
    [self updateBusInfo];
}

- (void)setUserCurrentStationWithUserLocation {
    CLLocation* curLocation =  [BUser defaultUser].curLocation;
    
    BBusStation* minDistanceStation = [self getNearsetBusStaionAtLocation:curLocation];
    
    if (minDistanceStation == nil) {
        self.currentStationNameLabel.text = @"现在木有网";
    } else {
        self.currentStationNameLabel.text = minDistanceStation.name;
    }
    
    CLLocationDistance minDistance = [minDistanceStation.location distanceFromLocation:curLocation];
    
    self.currentStationSubLabel.text = [NSString stringWithFormat:@"大概%@", [self distanceToString:minDistance]];
    
    // 设置当前用户所在站点
    self.currentStation = minDistanceStation;
    
    // 保存到用户
    [BUser defaultUser].nearestStation = minDistanceStation;
    
    [self.locationButton setSelected:NO];
    [self updateBusInfo];
}

- (void)setUserCurrentStationWithBusStation:(BBusStation*)busStation {
    
    
}

/**
 *  返回当前用户的位置
 *  如果用户使用系统定位的位置，返回定位的位置
 *  如果用户手动选择了公交站点，则返回用户选择的公交站点位置
 */
- (CLLocation*)currentLocation {
    return [BUser defaultUser].curLocation;
}

/**
 *  计算指定地理位置最近的一个公交站点
 */
- (BBusStation*)getNearsetBusStaionAtLocation:(CLLocation*)location {
    
    CLLocationDistance minDistance = CGFLOAT_MAX;
    BBusStation* minDistanceStation = nil;
    
    // 计算当前距离用户最近的公交站点
    for (BBusStation* station in self.favoriteBusLine.busLine.busStations) {
        CLLocation* stationLocation = [[CLLocation alloc]initWithLatitude:station.latitude.doubleValue longitude:station.longitude.doubleValue];
        CLLocationDistance distance = [location distanceFromLocation:stationLocation];
        if(distance < minDistance) {
            minDistance = distance;
            minDistanceStation = station;
        }
    }
    
    return minDistanceStation;
}

/**
 *  将距离转化为字符串，>10km，返回10千米 否则返回 xxx米
 */
- (NSString*)distanceToString:(CLLocationDistance)distance {
    NSString* unit = @"米";
    
    if(distance > 10000) {
        distance /= 1000;
        unit = @"千米";
    }
    
    return [NSString stringWithFormat:@"%.2f%@", distance, unit];
}

@end
