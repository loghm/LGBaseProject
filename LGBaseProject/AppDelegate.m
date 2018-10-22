//
//  AppDelegate.m
//  LGBaseProject
//
//  Created by loghm on 2017/12/13.
//  Copyright © 2017年 loghm. All rights reserved.
//

#import "AppDelegate.h"
#import "LGMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.rootTabBarViewController = [[LGMainViewController alloc] init];

//设置一些在调试阶段不需要运行的框架，类似bugly
#if !DEBUG
    
#else
    
#endif
//    配置键盘
    [self setKeyBoard];
    //app 初始化
    [self initailApp];
    
    self.window.rootViewController = self.rootTabBarViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 配置键盘
- (void)setKeyBoard{
    //    //配置键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    //    控制整个功能是否启用。
    manager.enable = YES;
    manager.overrideKeyboardAppearance = YES;
    //控制点击背景是否收起键盘
    manager.shouldResignOnTouchOutside = YES;
    //控制是否显示键盘上的工具条。
    manager.enableAutoToolbar = NO;
    manager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}

#pragma mark 进入app的初始化
- (void)initailApp {
    //    获取系统设置
    [[NetworkManager shareInstance] requestGetWithURL:ConfigURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        DTSystemConfigModel *model = [DTSystemConfigModel mj_objectWithKeyValues:responseObject];
        [HelpManager setData:model forKey:AppInitialKey];
    } failure:^(NSURLSessionDataTask *task, NSError *error, NSString *errMessage) {
        DLog(@"缓存失败");
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
