//
//  AppDelegate.m
//  Bus
//
//  Created by 朱辉 on 16/3/16.
//  Copyright © 2016年 朱辉. All rights reserved.
//

#import "AppDelegate.h"
#import "BHomeController.h"
#import "MobClick.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // UMENGE 测试模式
    [MobClick setLogEnabled:NO];

    UIWindow* window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    [window makeKeyAndVisible];
    
    BHomeController* vc = [[BHomeController alloc]init];
    window.rootViewController = vc;
    
    /**
     *  友盟 统计
     */

    [MobClick setAppVersion:BVersion];
    
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:BATCH channelId:@""];
    
    
    // 记录App启动次数
    int open_time = [[NSUserDefaults standardUserDefaults]integerForKey:KEY_APP_OPEN_TIME];
    [[NSUserDefaults standardUserDefaults]setInteger:open_time+1 forKey:KEY_APP_OPEN_TIME];
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
