//
//  FMBaseViewController.m
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMBaseViewController.h"
//#import "FMVisualEffectView.h"

@interface FMBaseViewController ()
{
    BOOL firstWillAppear;
    BOOL firstDidAppear;
    UIView *view;
}
@end

@implementation FMBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCaptionView];
    firstWillAppear = YES;
    firstDidAppear = YES;
    _needShowNavBarBackGround = YES;
    // Do any additional setup after loading the view.
    self.hidesBottomBarWhenPushed = YES;

    self.view.backgroundColor = [FMColor fmColor_Controller_View_Background];
    NSLog(@"naviHeight:...%fd", NAVIGATION_HEIGHT);
    CGFloat naviHeight = 0;
    if (IOS11) {
        naviHeight = NAVIGATION_HEIGHT;
    }else {
        naviHeight = 64;
    }
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, naviHeight)];
    view1.backgroundColor = [FMColor fmColor_Navigation_Back];
    
//    FMVisualEffectView *view2 = [[FMVisualEffectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    [view2 addSubview:view1];
    [self.view addSubview:view1];
    view = view1;
    view.tag = FMBaseNavigationBarTag;
    
    UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, view1.height - 0.5, SCREEN_WIDTH, 0.5)];
    splitView.backgroundColor = [FMColor fmColor_Line2];
    [view1 addSubview:splitView];

    self.needShowLoginViewType = 0;
   
    if (self.navigationController.viewControllers.count > 1)
    {
        self.leftNavButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 30)];
        [self.leftNavButton setBackgroundColor:[UIColor clearColor]];
        //        [self.leftNavButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [self.leftNavButton setImage:[UIImage imageNamed:@"tob_nav_big_back"] forState:UIControlStateNormal];
        self.leftNavButton.contentMode = UIViewContentModeLeft;
        [self.leftNavButton addTarget:self action:@selector(baseViewNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftNavButton];
        [self.navigationItem setLeftBarButtonItem:leftItem];
    }

//    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:[UIColor redColor]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    NSLog(@"进入======%@", [self class]);

    [super viewWillAppear:animated];
    [self.view addSubview:_captionView];//_captionView太早添加会引起automaticallyAdjustsScrollViewInsets失效，所以放在这里
    if (firstWillAppear)
    {
        firstWillAppear = NO;
        [self fmViewWillAppear:animated];
    }
    if (_needShowNavBarBackGround)
    {
        [self.view bringSubviewToFront:view];
    }

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (firstDidAppear)
    {
        firstDidAppear = NO;
        [self fmViewDidAppear:animated];
    }
    if (_needShowNavBarBackGround)
    {
        [self.view bringSubviewToFront:view];
    }
    [self fmautoRefresh];//还需要监听应用从后台返回的状态
}

#pragma mark - NavigationBar Setting
///没有导航栏时的返回按钮
- (void)setSuspensionBackButton
{
    if (self.leftNavButton)
        self.leftNavButton = nil;
    self.leftNavButton = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0, 27, 30)];
    [self.leftNavButton setBackgroundColor:[UIColor clearColor]];
//    [self.leftNavButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.leftNavButton setImage:[UIImage imageNamed:@"tob_nav_big_back"] forState:UIControlStateNormal];
    self.leftNavButton.contentMode = UIViewContentModeLeft;
    [self.leftNavButton addTarget:self action:@selector(baseViewNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.leftNavButton];
    
}

-(void)setLeftNavButtonImage:(UIImage *)normalimage hlighted:(UIImage *)hlightedimage
{
    if(!self.leftNavButton || ![self.leftNavButton isKindOfClass:UIButton.class])
    {
        self.leftNavButton = nil;
        self.leftNavButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 27, 30)];
//        [self.leftNavButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        [self.leftNavButton setBackgroundColor:[UIColor clearColor]];
        [self.leftNavButton setContentMode:UIViewContentModeLeft];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftNavButton];
        [self.navigationItem setLeftBarButtonItem:rightItem];
        [self.leftNavButton addTarget:self action:@selector(baseViewNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(normalimage)
    {
        //        self.leftNavButton.contentMode = UIViewContentModeCenter;
        [self.leftNavButton setImage:[normalimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    if (hlightedimage)
    {
        [self.leftNavButton setImage:[hlightedimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    }
}


- (void)setLeftNavButton:(UIButton *)leftNavButton
{
    _leftNavButton = leftNavButton;
    if (leftNavButton)
    {
        [self.leftNavButton addTarget:self action:@selector(baseViewNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftNavButton];
        [self.navigationItem setLeftBarButtonItem:leftItem];
    }
    else
        [self.navigationItem setLeftBarButtonItem:nil];
}

- (void)setRightNavButton:(UIButton *)rightNavButton
{
    _rightNavButton = rightNavButton;
    if (rightNavButton)
    {
        [self.rightNavButton addTarget:self action:@selector(baseViewNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightNavButton];
        [self.navigationItem setRightBarButtonItem:rightItem];
    }
    else
        [self.navigationItem setRightBarButtonItem:nil];
}

-(void)setRightNavButtonImage:(UIImage *)normalimage hlighted:(UIImage *)hlightedimage
{
    if (self.rightNavButton)
    {
        [self.rightNavButton removeFromSuperview];
        self.rightNavButton = nil;
    }
    if(!self.rightNavButton || ![self.rightNavButton isKindOfClass:UIButton.class])
    {
        self.rightNavButton             = nil;
        self.rightNavButton             = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 27 , 30)];
        [self.rightNavButton setImageEdgeInsets:UIEdgeInsetsMake(0, -1, 0, 1)];
        [self.rightNavButton setBackgroundColor:[UIColor clearColor]];
        self.rightNavButton.contentMode = UIViewContentModeRight;
        UIBarButtonItem *rightItem      = [[UIBarButtonItem alloc]initWithCustomView:self.rightNavButton];
        [self.navigationItem setRightBarButtonItem:rightItem];
    }
    if([normalimage isKindOfClass:UIImage.class])
    {
        [self.rightNavButton setImage:[normalimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    else
    {
        [self.rightNavButton setImage:[[UIImage imageNamed:@"MQButton_complete"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    if([hlightedimage isKindOfClass:UIImage.class])
    {
        [self.rightNavButton setImage:[hlightedimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    }
    else
    {
        [self.rightNavButton setImage:[[UIImage imageNamed:@"MQButton_complete_touch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    }
    [self.rightNavButton addTarget:self action:@selector(baseViewNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setRightNavButtonWithString:(NSString *)buttonNage
{
    if (self.rightNavButton)
    {
        [self.rightNavButton removeFromSuperview];
        self.rightNavButton = nil;
    }
    
    self.rightNavButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [self.rightNavButton setBackgroundColor:[UIColor clearColor]];
    [self.rightNavButton setTitle:buttonNage forState:UIControlStateNormal];
    [self.rightNavButton setTitleColor:[FMColor fmColor_B1] forState:UIControlStateNormal];
    [self.rightNavButton addTarget:self action:@selector(baseViewNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightNavButton.titleLabel setFont:[FMLayoutManager shareInstance].fmDefaultFont_14];
    [self.rightNavButton sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightNavButton];
    [self.navigationItem setRightBarButtonItem:rightItem];
}

///设置标题
-(void)setNavTitle:(NSString *)title
{
    if(!self.navTitleLabel)
    {
        self.navTitleLabel                 = [[UILabel alloc] init];
        self.navTitleLabel.backgroundColor = [UIColor clearColor];//设置Label背景透明
        self.navTitleLabel.font            = FMLayoutManagerInstance.fmNavTitleFont;//设置文本字体与大小
        self.navTitleLabel.textColor       = [FMColor fmColor_Navigation_Title];//设置文本颜色
        self.navTitleLabel.textAlignment   = NSTextAlignmentCenter;
        self.navTitleLabel.layer.masksToBounds=YES;
        self.navigationItem.titleView      = self.navTitleLabel;
    }
    
    self.navTitleLabel.text = title;
    [self.navTitleLabel sizeToFit];
}

//导航栏按钮响应
-(void)baseViewNavButtonAction:(id)sender
{
    
    if(![sender isKindOfClass:UIButton.class])
    {
        return;
    }
    if([sender isEqual:self.leftNavButton])
    {
        if(_leftNavButtonBlock)
        {
            _leftNavButtonBlock();
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    else if ([sender isEqual:self.rightNavButton])
    {
        if(_rightNavButtonBlock)
        {
            _rightNavButtonBlock();
        }
    }
}

- (void)setNavigationBarClear
{
    
    self.hidesBottomBarWhenPushed = NO; //因为首页的viewcontroller要调用，所以写到这里，免得忘记了
    //适配iOS 11
    NSArray *list=self.navigationController.navigationBar.subviews;
    if (IOS11) {
        for (UIView *subView in list) {
            if ([NSStringFromClass(subView.class) containsString:@"ContentView"]) {
                subView.layoutMargins = UIEdgeInsetsZero;//可修正iOS11之后的偏移
            }
            if ([NSStringFromClass(subView.class) containsString:@"UIBarBackground"]) {
                for (UIView *subViews in subView.subviews) {
                    subViews.hidden = YES;
                }
            }
        }
    }else {
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (UIView *subView in list) {
            subView.hidden = YES;
        }
    }
    UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 420, 64)];
    imageView.image=[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(SCREEN_WIDTH, 64)];
    imageView.tag = 100;
    [self.navigationController.navigationBar addSubview:imageView];
    [self.navigationController.navigationBar sendSubviewToBack:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"----------------%@ dealloc", [self class]);
}

- (void)fmViewWillAppear:(BOOL)animated
{
    
}

- (void)fmViewDidAppear:(BOOL)animated
{
    
}

//移除导航栏的背景View
- (void)fmRemoveNavView
{
    [view removeFromSuperview];
}

- (void)setNeedShowNavBarBackGround:(BOOL)needShowNavBarBackGround
{
    _needShowNavBarBackGround = needShowNavBarBackGround;
}


#pragma mark catption View

- (void)setupCaptionView
{
    self.captionView = [FMCaptionView addToView:self.view show:NO];
    //    @weakify(self);
    //    [_captionView setRetryBlock:^{
    //        @strongify(self);
    //        DMLog(@"重刷");
    //    }];
}

-(UIView*)navBarView
{
    return view;
}

#pragma mark - empty View

- (FMEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[FMEmptyView alloc] initWithFrame:self.view.bounds];
        [_emptyView setHidden:YES];
        _emptyView.baseYPadding = 65;
        _emptyView.label.font = FMLayoutManagerInstance.fmDefaultFont_16;
        _emptyView.label.textColor = [FMColor fmColor_B4];
        [_emptyView setImage:[UIImage imageNamed:@"personal_myProfix_empty"]
                   labelText:@"什么都没有哦~"
               labelYPadding:16
                subLabelText:nil
             subLabelPadding:0
                  buttonText:@""
                buttonTarget:self
                buttonAction:nil btnYPadding:80];
    }
    
    return _emptyView;
}


/**
 *  显示空页面 放置在self.view 上
 *
 *  @param isShow 是否显示
 */
- (void)showEmptyView:(BOOL)isShow{
    if (isShow) {
        [self.view bringSubviewToFront:self.emptyView];
        _emptyView.backgroundColor = [self.view backgroundColor];
        _emptyView.hidden = NO;
    } else {
        _emptyView.hidden = YES;
    }
}

/**
 *  显示空页面 放置在tableFooterView 上
 *
 *  @param isShow    是否显示
 *  @param tableView 相关联的Tableview，
 */
- (void)showEmptyView:(BOOL)isShow andTableView:(UITableView *)tableView
{
    if (isShow) {
        tableView.tableFooterView = self.emptyView;
        _emptyView.hidden = NO;
    } else {
        tableView.tableFooterView = nil;
        _emptyView.hidden = YES;
    }
}

/**
 *  路由跳转
 *
 *  @param model 对应的Model
 */
//- (void)pushRouter:(NSString *)url href:(NSString *)href style2:(FMHomeStyle2)style2
//{
//    NSString *paramerUrl = [FMRouterHelper jumpLinkComponentsWithPrefix:url herfString:href FMStyle2:style2];
//    UIViewController *vc = [[FMRApplication sharedInstance] openURL:[NSURL URLWithString:paramerUrl]];
//    [self fm_push:vc animated:YES];
    
    
//}

#pragma mark -
-(void)fmautoRefresh
{
    NSDate *lastTime=  [self fmGetLastRefreshTime];
    if(lastTime && self.captionView.state != FMCaptionViewStateLoading) //当前界面不处于刷新状态
    {
        NSDate *nowTime=[NSDate date];
        NSTimeInterval through= [nowTime timeIntervalSinceDate:lastTime];
        if (through>self.updataTimeInterval) {
            if (self.captionView.retryBlock) {
                self.captionView.retryBlock();
            }
        }
    }
}
//如果需要自动刷新界面，override实现这个方法
-(NSDate *)fmGetLastRefreshTime
{
    return nil;
}
-(NSTimeInterval)updataTimeInterval
{
    if (!_updataTimeInterval) {
        _updataTimeInterval=HUGE;
    }
    return _updataTimeInterval;
}

@end
