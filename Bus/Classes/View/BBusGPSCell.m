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

#import "Masonry.h"

@interface BBusGPSCell()

@property (weak, nonatomic) IBOutlet UILabel *test;



@end

@implementation BBusGPSCell

- (void)setBusStation:(BBusStation *)busStation {
    _busStation = busStation;
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.test.text = busStation.name;
}

@end
