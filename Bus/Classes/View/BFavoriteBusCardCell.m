
//
//  BBFavoriteBusCardCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/19.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BFavoriteBusCardCell.h"
#import "BFavoriteBusLine.h"

#import "BBusLine.h"
#import "BBusStation.h"

#import "BLabel.h"

@interface BFavoriteBusCardCell()

@property (weak, nonatomic) IBOutlet BLabel *busLineNameLabel;
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
 *  计算剩余时间label
 */
@property (weak, nonatomic) IBOutlet UILabel *surplusTimeLabel;
/**
 *  时间单位label
 */
@property (weak, nonatomic) IBOutlet UILabel *timeNameLabel;
/**
 *  预计label
 */
@property (weak, nonatomic) IBOutlet UILabel *guessLabel;

/**
 *  到站提醒label
 */
@property (weak, nonatomic) IBOutlet UILabel *busArriveTipLabel;

/*********autolayout*********/

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
@property (weak, nonatomic) IBOutlet BLabel *aaa;

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
    
    
    NSLog(@"%f", [UIScreen mainScreen].bounds.size.height);
    
    if([UIScreen mainScreen].bounds.size.height <= 480) { // 4s
        self.busLineNameTop.constant = 0;
        self.busDirViewTop.constant = 0;
        self.selfLocationViewTop.constant = 0;
        self.busLocationViewTop.constant = 0;
        self.endStationNameBottom.constant = 0;
        // 预计/分钟字体大小
        self.guessLabel.font = [UIFont systemFontOfSize:9];
        self.timeNameLabel.font = [UIFont systemFontOfSize:9];
        self.busArriveTipLabel.font =[UIFont systemFontOfSize:11];
    } else if ([UIScreen mainScreen].bounds.size.height <= 568) { // 5s
        self.busLineNameTop.constant /= 2;
        self.busDirViewTop.constant /= 2;
        self.selfLocationViewTop.constant /= 2;
        self.busLocationViewTop.constant /= 2;
        self.endStationNameBottom.constant /= 2;
        // 预计/分钟字体大小
        self.guessLabel.font = [UIFont systemFontOfSize:9];
        self.timeNameLabel.font = [UIFont systemFontOfSize:9];
    }else if([UIScreen mainScreen].bounds.size.height <= 667) {  // 6s
        self.selfLocationViewTop.constant /= 2;
        self.busLocationViewTop.constant /= 2;
        // 预计/分钟字体大小
        self.guessLabel.font = [UIFont systemFontOfSize:12];
        self.timeNameLabel.font = [UIFont systemFontOfSize:12];
    }else if([UIScreen mainScreen].bounds.size.height <= 736) { // 6sp
        self.busLocationViewBottom.constant = 25;
    }
    
//    self.locationButton.imageView.center = CGPointMake(self.locationButton.width/2, 0);
//    self.locationButton.imageView.y = 0;
//    self.locationButton.titleLabel.center = CGPointMake(self.locationButton.width/2, 0);
//    self.locationButton.titleLabel.y = CGRectGetMaxY(self.locationButton.imageView.frame) ;
    
}

- (void)setFavoriteBusLine:(BFavoriteBusLine *)favoriteBusLine {
    _favoriteBusLine = favoriteBusLine;
    
    // 公交名称
    
    self.busLineNameLabel.text = favoriteBusLine.busLine.fullname;
    
    
    // 目的站
    BBusStation* endBusStation = [favoriteBusLine.busLine.busStations lastObject];
    NSArray<NSString*>* endBusStationName = [self subNameInStationName:endBusStation.name];
    endBusStationName = [self subNameInStationName:endBusStation.name];
    self.endStationLabel.text = endBusStationName[0];
    self.endStationSubLabel.text = endBusStationName[1];
    
    if([endBusStationName[1] isEqualToString:@""]) {
        self.endStationNameBottom.constant = 5;
    }else{
        self.endStationNameBottom.constant = 14;
    }
    
    [self updateConstraints];
//    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    
    // fullName
    self.busLineNameLabel.font =[self.busLineNameLabel.text maxFontInSize:self.busLineNameLabel.frame.size  maxFontSize:50];
    
    // 开往
    self.aaa.font = [self.aaa.text maxFontInSize:self.aaa.frame.size  maxFontSize:50];
    
    // 尾站
    self.endStationLabel.font = [self.endStationLabel.text maxFontInSize:self.endStationLabel.frame.size  maxFontSize:50];
    
    // 时间label
    self.surplusTimeLabel.font = [self.surplusTimeLabel.text maxFontInSize:self.surplusTimeLabel.frame.size  maxFontSize:50];

}


/*
 *  将公交名称包含()的，截取未 主名称和子名称
 *  返回  [主, 子]
 */
- (NSArray<NSString*>*)subNameInStationName:(NSString*)fullname
{
    NSString* pattern = @"(.+)[/(（](.+)[/)）]?$";
    NSRegularExpression* reg = [[NSRegularExpression alloc]initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray<NSTextCheckingResult*>* arr = [reg matchesInString:fullname options:0 range:NSMakeRange(0, fullname.length)];
    
    
    if(arr.count > 0)
    {
        NSTextCheckingResult* result = [arr firstObject];
        NSRange range1 = [result rangeAtIndex:1];
        NSRange range2 = [result rangeAtIndex:2];
        return @[[fullname substringWithRange:range1],[fullname substringWithRange:range2]];
        
    }else{
        return @[fullname, @""];
    }
}



@end
