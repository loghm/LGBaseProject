//
//  LGRootViewController.m
//  LGBaseProject
//
//  Created by loghm on 2017/12/29.
//  Copyright © 2017年 loghm. All rights reserved.
//

#import "LGRootViewController.h"
#import "FMTabBar.h"
#import "FMLoginViewController.h"
#import "FMNavigationViewController.h"
#import "LGPersonalViewController.h"
#import "LGRangerReadingViewController.h"
#import "LGBorrowViewController.h"


@interface LGRootViewController ()

@end

@implementation LGRootViewController

- (void)viewDidLoad {
    
    self.fmTabDelegate=self;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mmApplicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    // Do any additional setup after loading the view.
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    //不让按钮同时点击
    if (IOS8)
        [[UIButton appearance] setExclusiveTouch:YES];

    self.fmViewControllers = [self rootViewControllers];

    [super viewDidLoad];
    
    
//    self.fm_Tabbar.centerButtonClickBlock = ^(id sender){
//中间按钮的点击
//        
//    };
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginView:) name:FMUserNeedLoginNotification object:nil];
    
    
}


#pragma mark - rootViewControllers

-(NSArray *)rootViewControllers {
    
    LGBorrowViewController *discoveryVC = [[LGBorrowViewController alloc] init];
    FMNavigationViewController *discoveryNav = [[FMNavigationViewController alloc] initWithRootViewController:discoveryVC];
    discoveryNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_hall_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoveryNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_hall"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    LGRangerReadingViewController *rangerVC = [[LGRangerReadingViewController alloc] init];
    FMNavigationViewController *rangerNav = [[FMNavigationViewController alloc] initWithRootViewController:rangerVC];
    rangerNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_radar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rangerNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_radar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    LGPersonalViewController *presonalVC = [[LGPersonalViewController alloc] init];
    FMNavigationViewController *personalNav = [[FMNavigationViewController alloc] initWithRootViewController:presonalVC];
    personalNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_personal_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    personalNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_personal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSArray *array = [NSArray arrayWithObjects:discoveryNav, rangerNav ,personalNav, nil];
    
    return array;
    
}




#pragma mark - showLoginView

- (void)showLoginView:(NSNotification*)notification
{
    UINavigationController *nav = [self.fmViewControllers objectAtIndex:self.fm_selectedIndex];
    UIViewController *topViewController = nav;
    if ([nav isKindOfClass:[UINavigationController class]])
    {
        topViewController = [nav topViewController];
    }
    
    if ([topViewController isKindOfClass:[FMLoginViewController class]])
    {
        //当前已是登陆页面就不再弹出登录页面
        return;
    }
    
    
    FMLoginViewController *controller = [[FMLoginViewController alloc] init];
    if ([topViewController isKindOfClass:[UINavigationController class]])
    {
        controller.lastViewImage = [FMToolsFunction screenShotWithView:topViewController.view];
    }
    else
    {
        controller.lastViewImage = [FMToolsFunction screenShotWithView:topViewController.navigationController.view];
    }
    if (notification.userInfo) {
        NSDictionary *dic = notification.userInfo;
        NSString * userAnimateString = [dic objectForKey:@"isUserAnimate"];
        if (userAnimateString && userAnimateString.length > 0) {
            controller.isUserAnimate = NO;
        }
    }
    
    if ([topViewController isKindOfClass:[FMBaseViewController class]])
    {
        FMBaseViewController *temp = (FMBaseViewController*)topViewController;
        controller.viewType = temp.needShowLoginViewType;
        if (notification.object)    //登录后需要跳转至的界面
        {
            controller.onComplete = ^{
                if ([notification.object isKindOfClass:[NSString class]])
                {
                    NSString *url = (NSString*)notification.object;
                    UIViewController *vc = nil;
                    if ([url hasSuffix:@"Controller"])      //普通的controller
                    {
                        NSString *filePath = [[NSBundle mainBundle] pathForResource:url ofType:@"nib"];
                        if (filePath)
                            vc = [[NSClassFromString(url) alloc] initWithNibName:url bundle:nil];
                        else
                            vc = [[NSClassFromString(url) alloc] init];
                        //vc如果需要参数则需放在userinfo里头
                        if (notification.userInfo)
                        {
                            NSDictionary *dic = notification.userInfo;
                            [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                                [vc setValue:obj forKey:key];
                            }];
                        }
                    }
                    else    //也可以直接构造成路由跳转的url
                    {
//                        vc = [[FMRApplication sharedInstance] openURL:[NSURL URLWithString:url]];
                    }
//                    [topViewController fm_push:vc animated:YES];
                }
                else if ([notification.object isKindOfClass:[FMBaseViewController class]])
                {
                    UIViewController *vc = notification.object;
//                    [topViewController fm_push:vc animated:YES];
                }
            };
        }
    }
    
//    [topViewController fm_push:controller animated:NO];
}



-(void)mmApplicationDidBecomeActive:(UIApplication *)app
{
    if([self.selectedViewController isKindOfClass:[UINavigationController class]])
    {
        UIViewController *selectRootVC=  [(UINavigationController*) self.selectedViewController  topViewController];
        if (selectRootVC.view.window) {//判断当前界面是否可见
            if ([selectRootVC isKindOfClass:[FMBaseViewController class]]) {//美莓的触发自动刷新
                //                [(FMBaseViewController *)selectRootVC mmautoRefresh];
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
