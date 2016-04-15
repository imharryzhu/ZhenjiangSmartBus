//
//  BAboutController.m
//  Bus
//
//  Created by 朱辉 on 16/4/14.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "BAboutController.h"

#import "MobClick.h"

@interface BAboutController ()

@end

@implementation BAboutController

+ (NSString*)description {
    return [NSString stringWithFormat:@"关于(%@)",NSStringFromClass([self class])];
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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 80;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* view = [[UIView alloc]init];
    
    CGFloat imageW = 64;
    CGFloat imageH = 64;
    
    CGFloat x = (tableView.width - imageW) / 2;
    CGFloat y = ([self tableView:tableView heightForHeaderInSection:section] - imageH) / 2;
    
    UIImageView* imageview = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, imageW, imageH)];
    NSString* path = [[NSBundle mainBundle]pathForResource:@"logo.png" ofType:nil];
    imageview.image = [UIImage imageWithContentsOfFile:path];
    
    [view addSubview:imageview];
    
    return view;
    
}



@end
