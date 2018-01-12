//
//  LGBaseViewController.h
//  LGBaseProject
//
//  Created by loghm on 2018/1/9.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGBaseViewController : UIViewController

@property (nonatomic, strong) UIView *naviBarContentView;

@property (nonatomic, strong) UIView *baseContentView;

@property (nonatomic, strong) UIButton *baseLeftButton;

@property (nonatomic, strong) UIButton *baseRightButton;

/**
 *  设置状态栏风格
 */
@property (nonatomic, assign) UIStatusBarStyle statusStyle;

/**
 *  是否显示自定义导航条,操作自定义导航条就必须设置yes
 */
@property (nonatomic, assign) BOOL isShowCustomBar;


#pragma mark - navigation method

- (void)setVCTitle:(NSString *)title;
- (void)push:(NSString *)vcName;
- (void)push:(NSString *)vcName withAnimated:(NSInteger)type;
- (void)push:(NSString *)vcName param:(NSMutableDictionary *)param delegate:(id)delegate;
- (void)goBack;
- (void)goBackVC:vcName;
- (void)goMainVC;

#pragma mark - 自定义导航栏view

/**
 *  添加左按钮事件响应
 *
 *  @param selector
 */
- (void)addLeftButtonSelector:(SEL)selector;
/**
 *  添加右按钮事件响应
 *
 *  @param selector
 */
- (void)addRightButtonSelector:(SEL)selector;

/**
 *  设置左按钮图片
 *
 *  @param image
 */
- (void)setLeftButtonImage:(UIImage *)image;
/**
 *  设置右按钮图片
 *
 *  @param image
 */
- (void)setRightButtonImage:(UIImage *)image;
/**
 *  设置左按钮文字
 *
 *  @param title
 */
- (void)setLeftButtonTitle:(NSString *)title;

/**
 *  设置右按钮文字
 *
 *  @param title
 */
- (void)setRightButtonTitle:(NSString *)title;


#pragma mark - 自动刷新、无网络状态

/**
 *  添加自动刷新功能
 *
 */
- (void)autoRefresh;


/**
 *  显示空页面 放置在self.view 上
 *
 *  @param isShow 是否显示
 */
- (void)showEmptyView:(BOOL)isShow;

@end
