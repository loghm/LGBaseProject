//
//  FMTabbarController.m
//  MeiMei
//
//  Created by 陈炜来 on 16/1/3.
//  Copyright © 2016年 MeiMei. All rights reserved.
//

#import "FMTabbarController.h"
#import "FMTabbar.h"

@interface FMTabbarController ()<UITabBarDelegate>
{
    NSUInteger _fm_selectedIndex;
    UITabBarItem *_lastItem;
}
@property (nonatomic, readwrite) BOOL visible;
@end

@implementation FMTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTabBar];
    [self lg_init];
}

- (void)addTabBar {
    CGRect tempRect= [UIScreen mainScreen].bounds;
    self.fm_Tabbar=[[FMTabBar alloc]initWithFrame:CGRectMake(0, tempRect.size.height-kTabBarHeight,  tempRect.size.width, kTabBarHeight)];
    self.fm_Tabbar.delegate=self;
    //定义界面都是不包含tabbar高度 的高度
    self.MainView=[[UIView alloc]initWithFrame:tempRect];
    [self.view addSubview:self.MainView];
    [self.view addSubview:self.fm_Tabbar];
}

-(void)lg_init
{    //把childcontroller的tabbarItem添加到 _myTabBar
    self.fm_Tabbar.items = [self setItems];
    
    //默认选中的tabbar的index
    if (_defaultSelectedIndex < 0 ||( _defaultSelectedIndex > [_fmViewControllers count] - 1)) {
        _fm_selectedIndex = 0;
    }else {
        _fm_selectedIndex = _defaultSelectedIndex;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    //    self.fm_selectedIndex = _fm_selectedIndex;
    if (!self.childViewControllers)
        [self.selectedViewController viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!self.childViewControllers)
        [self.selectedViewController viewDidAppear:animated];
    
    _visible = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (!self.childViewControllers)
        [self.selectedViewController viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (![self respondsToSelector:@selector(addChildViewController:)])
        [self.selectedViewController viewDidDisappear:animated];
    _visible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- TabBar Delegate
#pragma mark ---------- delegate ---------
#pragma mark ---------- event respone ----------
- (NSArray *)setItems {
    NSMutableArray *items = [NSMutableArray array];
    NSInteger tag = 0;
    for (UIViewController *VC in _fmViewControllers) {
        if (VC.tabBarItem != nil) {
            VC.tabBarItem.tag = tag++;
            [VC.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
            [items addObject:VC.tabBarItem];
        }else {
            UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:nil image:nil tag:0];
            [items addObject:tabbarItem];
        }
    }
    return items;
}

//设置  tabbarcontroller中要加载的子视图
- (void)setFmViewControllers:(NSArray *)viewControllers {
    for (UIViewController *VC in _fmViewControllers) {
         [VC willMoveToParentViewController:nil];
        [self removeFromParentViewController];
    }
    _fmViewControllers = viewControllers;
    for (UIViewController *VC in viewControllers) {
        [self addChildViewController:VC];
    }
    
    FMTabbarItemsCount = [viewControllers count];
    FMTabBarItemWidth = [UIScreen mainScreen].bounds.size.width / (FMTabbarItemsCount);
    [self lg_init];
    [self setFm_selectedIndex:0];
}


//选择TabBarItem 执行的事件
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    _lastItem = item;
    _fm_selectedIndex = item.tag;
    
    for (UIViewController *VC in _fmViewControllers) {
        if (VC.tabBarItem.tag == item.tag) {
            VC.view.frame = self.MainView.frame;
            [self.MainView insertSubview:VC.view belowSubview:self.fm_Tabbar];
        }else {
            [VC.view removeFromSuperview];
        }
    }
    self.selectedViewController = [self.fmViewControllers objectAtIndex:item.tag];
    if (self.fmTabDelegate&& [self.fmTabDelegate respondsToSelector:@selector(fmTabBarController:didSelectViewController:)]) {
        [self.fmTabDelegate fmTabBarController:self didSelectViewController:self.selectedViewController];
    }
    

}

//设置  选中第几个TabBarItem
- (void)setFm_selectedIndex:(NSUInteger)selectedIndex {
    if (self.fmViewControllers.count > selectedIndex)
    {
        self.selectedViewController = [self.fmViewControllers objectAtIndex:selectedIndex];
    }
    else
    {
        return;
    }
    _fm_selectedIndex = selectedIndex;
    UIViewController *VC = [_fmViewControllers objectAtIndex:_fm_selectedIndex];
    self.fm_Tabbar.selectedItem = VC.tabBarItem;
    [self.fm_Tabbar viewForBaselineLayout];
    [self tabBar: self.fm_Tabbar didSelectItem:VC.tabBarItem];
}


@end
