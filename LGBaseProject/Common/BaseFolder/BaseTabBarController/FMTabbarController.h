//
//  FMTabbarController.h
//  MeiMei
//
//  Created by 陈炜来 on 16/1/3.
//  Copyright © 2016年 MeiMei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMTabBar;
@class FMTabbarController;


@protocol FMTabbarControllerProtocol <NSObject>

@optional

- (void)setBadgeValue:(NSString *)badgeValue;
- (void)fmTabBarController:(FMTabbarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

@end



@interface FMTabbarController : UIViewController

@property (strong, nonatomic)  UIView *MainView;
@property (strong, nonatomic)  FMTabBar *fm_Tabbar;
@property (nonatomic) NSUInteger fm_selectedIndex;   //selected ViewController's OR TabBarItem's Index.
@property (nonatomic) NSInteger defaultSelectedIndex; // defualt selectedIndex;

@property (copy, nonatomic) NSArray *fmViewControllers;
@property (assign, nonatomic) UIViewController *selectedViewController;


@property (nonatomic,assign)BOOL fm_hiddentBottomBar;

@property (nonatomic, assign) id<FMTabbarControllerProtocol>fmTabDelegate;

@end

