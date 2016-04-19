//
//  BSettingController.h
//  Bus
//
//  Created by 朱辉 on 16/4/14.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSettingController;

@protocol BSettingControllerDelegate <NSObject>

- (void)settingControllerDidChangeCollected:(BSettingController*)vc;

@end

@interface BSettingController : UITableViewController

+ (instancetype)settingVC;

@property (nonatomic,weak) id<BSettingControllerDelegate> delegate;

@end
