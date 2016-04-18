//
//  BIntervalTimeToolBar.m
//  Bus
//
//  Created by 朱辉 on 16/4/16.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BIntervalTimeToolBar.h"

@implementation BIntervalTimeToolBar


+ (instancetype)toolBar {
    return [[[NSBundle mainBundle]loadNibNamed:@"BIntervalTimeToolBar" owner:nil options:nil] lastObject];
}

- (IBAction)doneClick:(id)sender {
    if([self.tbDelegate respondsToSelector:@selector(intervalTimeToolBarDone:)]) {
        [self.tbDelegate intervalTimeToolBarDone:self];
    }
}

@end
