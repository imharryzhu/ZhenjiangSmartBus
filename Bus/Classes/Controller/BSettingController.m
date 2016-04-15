//
//  BSettingController.m
//  Bus
//
//  Created by 朱辉 on 16/4/14.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BSettingController.h"

@interface BSettingController ()



@end

@implementation BSettingController


+ (instancetype)settingVC {
    
    UIStoryboard* story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    return [story instantiateViewControllerWithIdentifier:@"settingvc"];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"设置";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}

@end
