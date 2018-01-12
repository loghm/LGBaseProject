//
//  UIViewController+FMPublic.m
//  MeiMei
//
//  Created by chw on 15/11/23.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "UIViewController+FMPublic.h"
#import "FMNavigationViewController.h"
#import "AppDelegate.h"
//#import "FMRootViewController.h"

@implementation UIViewController (FMPublic)

///判断当前控制器是否可见的
-(BOOL)isVisableViewController
{
    UIViewController *vc = self.navigationController.visibleViewController;
    
    if ([self isEqual:vc])
    {
        return YES;
    }
    return NO;
}

- (UINavigationController*)fm_navigationController
{
    UINavigationController* nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    }
    else {
        if ([self isKindOfClass:[UITabBarController class]]) {
            nav = [((UITabBarController*)self).selectedViewController fm_navigationController];
        }
        else {
            nav = self.navigationController;
        }
    }
    return nav;
}
- (void)fm_push:(UIViewController*)viewController
{
    [self fm_push:viewController animated:YES];
}

- (void)fm_push:(UIViewController*)viewController animated:(BOOL)animated
{
    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }
    if (viewController==nil) {
        return;
    }
    viewController.hidesBottomBarWhenPushed = YES;
    [self.fm_navigationController pushViewController:viewController animated:animated];
}

- (void)fm_push:(UIViewController*)viewController hidesBottomBarWhenPushed:(BOOL)hidden
{
    viewController.hidesBottomBarWhenPushed = hidden;
    [self fm_push:viewController];
}

- (void)fm_present:(UIViewController*)viewController
{
    [self fm_present:viewController animated:YES];
}

- (void)fm_present:(UIViewController*)viewController animated:(BOOL)animated
{
    if (viewController==nil) {
        return;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        //        Class navigationControllerClass = [FMPublicBaseNavigationController class] ?: [UINavigationController class];
        FMNavigationViewController* nav = [[FMNavigationViewController alloc] initWithRootViewController:viewController];
        [self fm_present:nav animated:animated];
    }
    else {
        [self presentViewController:viewController animated:animated completion:nil];
    }
}

- (UIViewController*)fm_pop:(BOOL)animated
{
    [self.view endEditing:YES];//强制收起键盘
    UINavigationController* nav = [self fm_navigationController];
    if (nav && nav.viewControllers.count > 1) {
        return [nav popViewControllerAnimated:animated];
    }
    else {
        [self dismissViewControllerAnimated:animated completion:nil];
        return nil;
    }
}

- (void)fm_popToRootVCWithTab:(FMTabType)tab
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    FMRootViewController *tabVC = [app rootTabBarViewController];
//    tabVC.fm_selectedIndex = tab;
    
//    for (UINavigationController *rootVC in tabVC.fmViewControllers) {
//        [rootVC popToRootViewControllerAnimated:NO];
//    }
}


- (void)fm_removeSelfInNavigationController
{
    UIViewController* vc = self;
    if (vc.parentViewController && [vc.parentViewController isKindOfClass:[UINavigationController class]] == NO) {
        vc = vc.parentViewController;
    }
    
    UINavigationController* nav = vc.navigationController;
    if (nav && vc) {
        NSMutableArray* newStack = [NSMutableArray arrayWithArray:nav.viewControllers];
        NSInteger originalCount = newStack.count;
        [newStack removeObject:vc];
        NSInteger newCount = newStack.count;
        if (originalCount != newCount) {
            [nav setViewControllers:newStack animated:YES];
        }
    }
}

+ (UIViewController*)fm_deepestPresentedViewControllerOf:(UIViewController*)viewController
{
    UIViewController* deepestViewController = viewController;
    
    Class alertVC0 = [UIAlertController class];
    Class alertVC1 = NSClassFromString(@"_UIAlertShimPresentingViewController");
    while (YES) {
        UIViewController* presentedVC = deepestViewController.presentedViewController;
        if (presentedVC && [presentedVC isKindOfClass:alertVC0] == NO && [presentedVC isKindOfClass:alertVC1] == NO) {
            deepestViewController = deepestViewController.presentedViewController;
        }
        else {
            break;
        }
    }
    return deepestViewController;
}
+ (UIViewController*)fm_currentTopViewController
{
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    ;
    UIViewController* topVC = [self fm_deepestPresentedViewControllerOf:rootVC];
    
    if ([topVC isKindOfClass:[FMTabbarController class]]) {
        UIViewController* tabSelectedVC = ((FMTabbarController*)topVC).selectedViewController;
        if (tabSelectedVC) {
            topVC = [self fm_deepestPresentedViewControllerOf:tabSelectedVC];
        }
    }
    
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        UIViewController* navTopVC = ((UINavigationController*)topVC).topViewController;
        if (navTopVC) {
            topVC = [self fm_deepestPresentedViewControllerOf:navTopVC];
        }
    }
    
    return topVC;
}

- (UIViewController*)fm_beforeViewController
{
    UINavigationController* nav = self.navigationController;
    if (nav && nav.viewControllers.count > 0) {
        NSInteger index = [nav.viewControllers indexOfObject:self];
        if (index != NSNotFound && index > 0) {
            UIViewController* beforeVC = nav.viewControllers[index - 1];
            return beforeVC;
        }
        else if (nav.presentingViewController) {
            return nav.presentingViewController;
        }
    }
    return nil;
}
- (UIViewController*)fm_currentShowChildViewController
{
    if (self.childViewControllers.count > 0) {
        UIViewController* findVC = nil;
        for (UIViewController* childVC in self.childViewControllers) {
            if (childVC.isViewLoaded && childVC.view.window) {
                CGPoint windowPoint = [childVC.view convertPoint:childVC.view.center toView:childVC.view.window];
                if (CGRectContainsPoint(childVC.view.window.bounds, windowPoint)) {
                    findVC = childVC;
                    break;
                }
            }
        }
        if (findVC) {
            return findVC;
        }
    }
    return self;
}

- (BOOL)fm_isPop
{
    return ![self.navigationController.viewControllers containsObject:self];
}

- (BOOL)fm_isPush
{
    return [self.navigationController.viewControllers containsObject:self];
}


//检查3Dtouch
- (BOOL)fm3DTouchEnable
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd) ;
    if (number) {
        return number.boolValue;
    }
    BOOL check=[self fm_check3DTouch];
    self.fm3DTouchEnable=check;
    return check;
}

- (void)setFm3DTouchEnable:(BOOL)fm3DTouchEnable
{
    objc_setAssociatedObject(self, @selector(fm3DTouchEnable), @(fm3DTouchEnable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fm_check3DTouch
{
    if (IOS9) {
        BOOL _chek3DTouch;
        if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
        {
            //        [self registerForPreviewingWithDelegate:self sourceView:self.view];
            _chek3DTouch= YES;
        }
        else
        {
            _chek3DTouch=NO;
        }
        return _chek3DTouch;
    }
    return NO;
}

@end
