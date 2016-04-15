//
//  BSettingController.m
//  Bus
//
//  Created by 朱辉 on 16/4/14.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BSettingController.h"

#import "MobClick.h"

@interface BSettingController ()



@end

@implementation BSettingController

+ (NSString*)description {
    return [NSString stringWithFormat:@"设置(%@)",NSStringFromClass([self class])];
}

#pragma mark - 友盟页面统计

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:[[self class]description]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick endLogPageView:[[self class]description]];
}


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
