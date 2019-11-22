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
#import "LGTabBarClickProtocol.h"


@interface LGMainViewController ()

@property (nonatomic, strong) NSDate *lastClickDate;

@end

@implementation LGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNotifiCation];
    
    [self setAppearance];
    [self setCustomKeyBoard];
    
    [self addAllChildViewController];
}

- (void)setAppearance {
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //    去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //    不让按钮同时点击
    if (IOS8)
        [[UIButton appearance] setExclusiveTouch:YES];
}

- (void)addNotifiCation {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                selector:@selector(mmApplicationDidBecomeActive:)
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
}

- (void)setCustomKeyBoard {
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
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
    [self addChildViewController:rangerVC title:@"主页" imageNamed:@"tabbar_radar" andselectedImageNamed:@"tabbar_radar"];
    
    LGPersonalViewController *presonalVC = [[LGPersonalViewController alloc] init];
    [self addChildViewController:presonalVC title:@"我的" imageNamed:@"tabbar_personal" andselectedImageNamed:@"tabbar_personal_h"];
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

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //获取当前viewController
    UIViewController *vc = viewController;
    if (([vc isKindOfClass:[UINavigationController class]] || [vc isMemberOfClass:[UINavigationController class]]) && vc.childViewControllers.count > 0) {
        vc = vc.childViewControllers.lastObject;
    }
    BOOL isDoubleClick = NO;
    NSDate *date = [NSDate date];
    if (self.lastClickDate) {
        float time = [date timeIntervalSinceDate:self.lastClickDate];
        isDoubleClick = time < 0.5;
    }
    if (isDoubleClick) {
        self.lastClickDate = nil;
        if ([vc respondsToSelector:@selector(tabBarItemDidDoubleClick)]) {
            [(UIViewController<LGTabBarClickProtocol> *)vc tabBarItemDidDoubleClick];
        }
    }else {
        self.lastClickDate = [NSDate date];
    }
    return YES;
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    // 获取tabBar的subViews中的UITabBarButton 并传入当前选择的tabBar编号，进行增加动画
    NSMutableArray *array = [NSMutableArray array];
    for (UIView *tabBarBtn in self.tabBar.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [array addObject:tabBarBtn];
        }
    }
    [self addScaleSizeAnimationInArray:array withIndex:index];
}

// 批量添加动画
- (void)addScaleSizeAnimationInArray:(NSMutableArray *)array withIndex:(NSInteger)index {
    // 使用CABasicAnimation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 速度控制函数
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;
    animation.repeatCount = 1;  // 执行次数
    animation.autoreverses = YES; // 自动恢复到原来的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   // 初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.3];     // 结束伸缩倍数
    [[array[index] layer] addAnimation:animation forKey:nil];
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
