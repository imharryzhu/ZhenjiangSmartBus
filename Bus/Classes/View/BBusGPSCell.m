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


@interface BBusGPSCell()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation BBusGPSCell

-(instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setBusStation:(BBusStation *)busStation {
    _busStation = busStation;
    
    self.label.text = busStation.name;
    
}

@end
