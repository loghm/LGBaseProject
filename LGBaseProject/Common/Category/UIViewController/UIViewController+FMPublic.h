//
//  UIViewController+FMPublic.h
//  MeiMei
//
//  Created by chw on 15/11/23.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, FMTabType) {
    FMTabTypeHome           = 0,
    FMTabTypeStore          = 1,
    FMTabTypePersonal       = 2,
    
};

@interface UIViewController (FMTools)

/**
 *  判断当前控制器是否可见的
 *
 *  @return YES \ NO
 */
-(BOOL)isVisableViewController;

- (void)fm_push:(UIViewController *)viewController;

- (void)fm_push:(UIViewController *)viewController animated:(BOOL)animated;

- (void)fm_push:(UIViewController *)viewController hidesBottomBarWhenPushed:(BOOL)hidden;

- (void)fm_present:(UIViewController *)viewController;

- (void)fm_present:(UIViewController *)viewController animated:(BOOL)animated;

- (UIViewController*)fm_pop:(BOOL)animated;

/**
 *  跳转到主页中的页面
 *
 *  @param tab 主页枚举
 */
- (void)fm_popToRootVCWithTab:(FMTabType)tab;

///移除navigation.viewcontrollers 中的 自己
- (void)fm_removeSelfInNavigationController;

///目前 rootViewController 里面最顶层的 vc
+ (UIViewController*)fm_currentTopViewController;

///找到最顶层的viewController
+ (UIViewController*)fm_deepestPresentedViewControllerOf:(UIViewController*)viewController;

///该vc的navigationController
- (UINavigationController*)fm_navigationController;

///自己之前的vc
- (UIViewController*)fm_beforeViewController;

///显示的子vc
- (UIViewController*)fm_currentShowChildViewController;

- (BOOL)fm_isPop;

- (BOOL)fm_isPush;

//- (BOOL)fm_check3DTouch;
@property(nonatomic,assign)BOOL fm3DTouchEnable;
@end
