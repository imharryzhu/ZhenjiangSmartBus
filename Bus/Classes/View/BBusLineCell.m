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
#import "BFavoriteBusLineTool.h"
#import "BFavoriteBusLine.h"

#import "AFNetworking.h"
#import <objc/runtime.h>

@interface BBusLineCell() <UIAlertViewDelegate>

@property (nonatomic,weak) IBOutlet UILabel* fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startStationLabel;
@property (weak, nonatomic) IBOutlet UILabel *terminalStationLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UILabel *nearsetStationName;


/********* autolayout *********/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fullNameWidth;



@property (nonatomic,assign, getter=isFavorite) BOOL favorite;

@end

@implementation BBusLineCell

-(void)awakeFromNib {
    
    if([UIScreen mainScreen].bounds.size.height <= 480) { // 4s
        self.fullNameWidth.constant = 80;
    } else if ([UIScreen mainScreen].bounds.size.height <= 568) { // 5s
        self.fullNameWidth.constant = 80;
    }else if([UIScreen mainScreen].bounds.size.height <= 667) {  // 6s
        self.fullNameWidth.constant = 90;
    }else if([UIScreen mainScreen].bounds.size.height <= 736) { // 6sp
        self.fullNameWidth.constant = 100;
    }
    
    self.favoriteBtn.imageView.center = CGPointMake(self.favoriteBtn.width/2,0);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)busLineCellWithTableView:(UITableView*)tableView {
    static NSString* reuseId = @"busline";
    
    BBusLineCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if(!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BBusLineCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

/**
 *  设置模型数据
 */
- (void)setViewModel:(BBusLineViewModel *)viewModel {
    _viewModel = viewModel;
    
    self.fullNameLabel.font = [viewModel.busLine.fullname maxFontInSize:self.fullNameLabel.bounds.size maxFontSize:100];
    
    self.fullNameLabel.text = viewModel.busLine.fullname;
    
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
    
    BOOL tmp = NO;
    // 判断是否收藏
    for (BFavoriteBusLine* line in [BFavoriteBusLineTool defaultTool].favoriteBusLines) {
        if([line.busLine.fullname isEqualToString:viewModel.busLine.fullname]){
            tmp = YES;
            break;
        }
    }
    self.favorite = tmp;
    
}

- (void)setFavorite:(BOOL)favorite {
    _favorite = favorite;
    
    UIImage* image = [UIImage imageNamed:favorite ? @"favorite_yes_normal" : @"favorite_no_normal"];
    UIImage* imagehighlight = [UIImage imageNamed:favorite ? @"favorite_yes_highlight" : @"favorite_no_highlight"];
    [self.favoriteBtn setImage:image forState:UIControlStateNormal];
    [self.favoriteBtn setImage:imagehighlight forState:UIControlStateHighlighted];
    [self.favoriteBtn setTitle:favorite ? @"已收藏" : @"未收藏" forState:UIControlStateNormal];
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

/**
 *  收藏按钮点击
 */
- (IBAction)favoriteBtnClick:(id)sender {
    if (self.favorite) { //取消收藏
        
        UIAlertView* view = [[UIAlertView alloc]initWithTitle:@"" message:@"删除该收藏？" delegate:nil cancelButtonTitle:@"不删除" otherButtonTitles:@"是的", nil];
        view.delegate = self;
        [view show];
        
    }else{ // 添加收藏
        BFavoriteBusLine* favorite = [[BFavoriteBusLine alloc]init];
        favorite.busLine = _viewModel.busLine;
        
        if([[BFavoriteBusLineTool defaultTool]addBusLine:favorite]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:BFavoriteChangeNotification object:nil];
        }
        self.favorite = YES;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1) {
        NSArray* array = [[BFavoriteBusLineTool defaultTool]favoriteBusLines];
        for (int i = (int)array.count-1 ; i >= 0; i--) {
            BFavoriteBusLine* favorite = [array objectAtIndex:i];
            if([favorite.busLine.fullname isEqualToString:self.viewModel.busLine.fullname]){
                if([[BFavoriteBusLineTool defaultTool]deleteBusLine:favorite]){
                    [[NSNotificationCenter defaultCenter]postNotificationName:BFavoriteChangeNotification object:nil];
                }
            }
        }
        self.favorite = NO;
    }
}

@end
