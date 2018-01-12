//
//  FMBaseViewController.h
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMCaptionView.h"
#import "FMEmptyView.h"
#define FMBaseNavigationBarTag 123122

@interface FMBaseViewController : UIViewController
{
    FMEmptyView *_emptyView;

}
@property (nonatomic, strong, readonly) UIView *navBarView;

@property (nonatomic, strong) UILabel *navTitleLabel;

///导航栏左键，默认自动添加
@property (nonatomic, strong) UIButton *leftNavButton;

///导航栏栏左边按钮事件
@property (nonatomic, copy) void (^leftNavButtonBlock ) (void);

///没有导航栏时的返回按钮
- (void)setSuspensionBackButton;
/**
 *  设置导航栏图片左键
 *
 *  @param normalimage   常态图
 *  @param hlightedimage 高亮图
 */
-(void)setLeftNavButtonImage:(UIImage *)normalimage hlighted:(UIImage *)hlightedimage;

///导航栏右键
@property (nonatomic, strong) UIButton *rightNavButton;

///导航栏右边按钮事件
@property (nonatomic, copy) void (^rightNavButtonBlock) (void);

/**
 *  设置导航栏图片右键
 *
 *  @param normalimage   常态图
 *  @param hlightedimage 高亮图
 */
-(void)setRightNavButtonImage:(UIImage *)normalimage hlighted:(UIImage *)hlightedimage;

/**
 *  设置导航栏文字右键
 *
 *  @param buttonNage 右键标题
 */
-(void)setRightNavButtonWithString:(NSString *)buttonNage;

///设置标题
-(void)setNavTitle:(NSString *)title;


@property (nonatomic, assign) NSInteger needShowLoginViewType;
@property (nonatomic, assign) BOOL needLogin;

//设置导航栏透明的，首页的4个页面需要调用
- (void)setNavigationBarClear;

///默认为YES，如果不需要NavigationBar背景时，需要在ViewDidLoad设置为NO
@property (nonatomic, assign) BOOL needShowNavBarBackGround;

//某些东西不想放在viewDidLoad却又只需要执行一次的，可以调用这两个
- (void)fmViewDidAppear:(BOOL)animated;
- (void)fmViewWillAppear:(BOOL)animated;

//移除导航栏的背景View
- (void)fmRemoveNavView;

@property (strong, nonatomic) FMCaptionView* captionView;

#pragma mark - 空页面相关
@property (strong, nonatomic) FMEmptyView *emptyView;//空页面
/**
 *  显示空页面 放置在self.view 上
 *
 *  @param isShow 是否显示
 */
- (void)showEmptyView:(BOOL)isShow;
/**
 *  显示空页面 放置在tableFooterView 上
 *
 *  @param isShow    是否显示
 *  @param tableView 相关联的Tableview，
 */
- (void)showEmptyView:(BOOL)isShow andTableView:(UITableView *)tableView;


#pragma mark -
///实现自动刷新界面功能，需要实现 self.captionView.retryBlock 、updataTimeInterval、mmGetLastRefreshTime
-(void)fmautoRefresh;
@property(nonatomic,assign)NSTimeInterval updataTimeInterval;//need refresh interval
///need override to get last refresh time
-(NSDate *)fmGetLastRefreshTime;

/**
 *  路由跳转
 *
 */
//- (void)pushRouter:(NSString *)url href:(NSString *)href style2:(FMHomeStyle2)style2;
@end
