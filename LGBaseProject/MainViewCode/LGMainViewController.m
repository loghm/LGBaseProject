//
//  LGMainViewController.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/9.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGMainViewController.h"
#import "LGBorrowViewController.h"
#import "LGRangerReadingViewController.h"
#import "LGPersonalViewController.h"
#import "FMTabBar.h"
#import "LGNavigationViewController.h"


@interface LGMainViewController ()

@end

@implementation LGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mmApplicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
//     Do any additional setup after loading the view.
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

//    不让按钮同时点击
    if (IOS8)
        [[UIButton appearance] setExclusiveTouch:YES];
   
    [self addAllChildViewController];
}

#pragma mark - Private Methods

// 添加全部的 childViewcontroller
- (void)addAllChildViewController
{
    LGBorrowViewController *discoveryVC = [[LGBorrowViewController alloc] init];
    discoveryVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:discoveryVC title:@"发现" imageNamed:@"tabbar_hall" andselectedImageNamed:@"tabbar_hall_h"];
    
    LGRangerReadingViewController *rangerVC = [[LGRangerReadingViewController alloc] init];
    rangerVC.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:rangerVC title:@"漂读圈" imageNamed:@"tabbar_radar" andselectedImageNamed:@"tabbar_radar"];
    
    LGPersonalViewController *presonalVC = [[LGPersonalViewController alloc] init];
    presonalVC.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:presonalVC title:@"个人中心" imageNamed:@"tabbar_personal" andselectedImageNamed:@"tabbar_personal_h"];
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed andselectedImageNamed:(NSString *)selectImageName;
{
    LGNavigationViewController *nav = [[LGNavigationViewController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
//    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    //正常的字体颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [nav.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    //选中的字体颜色
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSForegroundColorAttributeName] =  [UIColor redColor];
    [nav.tabBarItem setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
    
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.image = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}



-(void)mmApplicationDidBecomeActive:(UIApplication *)app
{
    if([self.selectedViewController isKindOfClass:[UINavigationController class]])
    {
        UIViewController *selectRootVC=  [(UINavigationController*) self.selectedViewController  topViewController];
        if (selectRootVC.view.window) {//判断当前界面是否可见
            if ([selectRootVC isKindOfClass:[LGBaseViewController class]]) {//美莓的触发自动刷新
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
