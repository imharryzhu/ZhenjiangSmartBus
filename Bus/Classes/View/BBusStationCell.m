//
//  BBusStationCell.m
//  Bus
//
//  Created by 朱辉 on 16/3/23.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BBusStationCell.h"

#import "BBusStation.h"

@interface BBusStationCell()

@property (nonatomic,weak) UILabel* label;
@property (nonatomic,weak) UISwitch* switc;

@end

@implementation BBusStationCell

+ (instancetype)busStationCellWithTableView:(UITableView*)tableView {
    static NSString* reuseId = @"busstation";
    
    BBusStationCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if(!cell) {
        
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"BBusLineCell" owner:nil options:nil] lastObject];
        cell = [[BBusStationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [self addSubview:label];
        self.label = label;
        
        label.x = 10;
        label.y = 10;
    }
    return self;
}

- (void)setBusStation:(BBusStation *)busStation {
    _busStation = busStation;
    
    
    self.label.text = busStation.name;
    [self.label sizeToFit];
}

@end
