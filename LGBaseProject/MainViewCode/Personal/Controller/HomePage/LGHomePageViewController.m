//
//  LGHomePageViewController.m
//  LGBaseProject
//
//  Created by loghm on 2018/10/23.
//  Copyright © 2018 loghm. All rights reserved.
//

#import "LGHomePageViewController.h"
#import "LGMainTouchTableView.h"
#import "LGSegmentView.h"
#import "LGFirstViewController.h"
#import "LGSecondViewController.h"
#import "CenterTestCollectionView.h"

static CGFloat const HeaderImageViewHeight = 240;
@interface LGHomePageViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) LGMainTouchTableView *mainTableView;
@property (nonatomic, strong) LGSegmentView *segmentView;
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIView *headerContentView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UIView *footerView;
/**mainTableView是否可以滚动*/
@property (nonatomic, assign) BOOL canScroll;
/**segmentHeaderView到达顶部, mainTableView不能移动*/
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabView;
/**segmentHeaderView离开顶部,childViewController的滚动视图不能移动*/
@property (nonatomic, assign) BOOL isTopIsCanNotMoveTabViewPre;
/**是否正在pop*/
@property (nonatomic, assign) BOOL isBacking;


@end

@implementation LGHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人中心";
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //如果使用自定义的按钮去替换系统默认返回按钮，会出现滑动返回手势失效的情况
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self setupSubViews];
    //注册允许外层tableView滚动通知-解决和分页视图的上下滑动冲突问题
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"leaveTop" object:nil];
    //分页的scrollView左右滑动的时候禁止mainTableView滑动，停止滑动的时候允许mainTableView滑动
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:IsEnablePersonalCenterVCMainTableViewScroll object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    self.naviView.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isBacking = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:PersonalCenterVCBackingStatus object:nil userInfo:@{@"isBacking" : @(self.isBacking)}];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isBacking = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:PersonalCenterVCBackingStatus object:nil userInfo:@{@"isBacking" : @(self.isBacking)}];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    self.naviView.hidden = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 设置界面
- (void)setupSubViews {
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.naviView];
    [self.headerImageView addSubview:self.headerContentView];
    [self.headerContentView addSubview:self.avatarImageView];
    [self.headerContentView addSubview:self.nickNameLabel];
    [self.mainTableView addSubview:self.headerImageView];
    
    [self.headerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.mas_equalTo(self.headerImageView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(HeaderImageViewHeight);
    }];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerContentView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.bottom.mas_equalTo(-70);
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerContentView);
        make.width.mas_lessThanOrEqualTo(200);
        make.bottom.mas_equalTo(-40);
    }];
}

#pragma mark -  Notification
- (void)acceptMsg:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    if ([notification.name isEqualToString:@"leaveTop"]) {
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
        }
    } else if ([notification.name isEqualToString:IsEnablePersonalCenterVCMainTableViewScroll]) {
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.mainTableView.scrollEnabled = YES;
        }else if([canScroll isEqualToString:@"0"]) {
            self.mainTableView.scrollEnabled = NO;
        }
    }
}

#pragma mark - UITableViewDelegate
/**
 * 处理联动
 * 因为要实现下拉头部放大的问题，tableView设置了contentInset，所以试图刚加载的时候会调用一遍这个方法，所以要做一些特殊处理，
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //当前偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    //临界点偏移量(吸顶临界点)
    CGFloat tabyOffset = scrollView.contentSize.height - SCREEN_HEIGHT;
    
    //更改导航栏的背景图的透明度
    CGFloat alpha = 0;
    if (yOffset < HeaderImageViewHeight - STATUS_HEIGHT - NAVIGATION_HEIGHT) {
        alpha = yOffset/(HeaderImageViewHeight - STATUS_HEIGHT - NAVIGATION_HEIGHT);
    }else {
        alpha = 1;
    }
    self.naviView.backgroundColor = FMCOLOR_RGBA(255, 126, 15, alpha);
    
    //利用contentOffset处理内外层scrollView的滑动冲突问题
    if (yOffset >= tabyOffset) {
        scrollView.contentOffset = CGPointMake(0, tabyOffset);
        self.isTopIsCanNotMoveTabView = YES;
    }else{
        self.isTopIsCanNotMoveTabView = NO;
    }
    
    self.isTopIsCanNotMoveTabViewPre = !self.isTopIsCanNotMoveTabView;
    
    if (!self.isTopIsCanNotMoveTabViewPre) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"1"}];
        self.canScroll = NO;
    }else {
        if (!self.canScroll) {
            self.mainTableView.contentOffset = CGPointMake(0, tabyOffset);
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"goTop" object:nil userInfo:@{@"canScroll":@"0"}];
        }
    }
}

#pragma mark - 返回上一界面
- (void)backAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 查看消息
- (void)gotoMessagePage {
//    MessageViewController *myMessageVC = [[MessageViewController alloc]init];
//    [self.navigationController pushViewController:myMessageVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CenterTestCollectionView *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CenterTestCollectionView class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerView.backgroundColor = [UIColor yellowColor];
    UILabel *titleLB = [UILabel new];
    titleLB.font = [UIFont boldSystemFontOfSize:18];
    if (section == 0) {
        titleLB.text = @"第一分区";
    }else {
        titleLB.text = @"第二分区";
    }
    [headerView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(150);
    }];
    return headerView;
}

#pragma mark - Lazy Method

- (UIView *)naviView {
    if (!_naviView) {
        _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, STATUS_HEIGHT + NAVIGATION_HEIGHT)];
        _naviView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        //添加返回按钮
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        backButton.frame = CGRectMake(5, 8 + STATUS_HEIGHT, 28, 25);
        backButton.adjustsImageWhenHighlighted = YES;
        [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:backButton];
        
        //添加消息按钮
        UIButton *messageButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [messageButton setImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
        messageButton.frame = CGRectMake(SCREEN_WIDTH - 35, 8 + STATUS_HEIGHT, 25, 25);
        messageButton.adjustsImageWhenHighlighted = YES;
        [messageButton addTarget:self action:@selector(gotoMessagePage) forControlEvents:(UIControlEventTouchUpInside)];
        [_naviView addSubview:messageButton];
    }
    return _naviView;
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        //⚠️这里的属性初始化一定要放在mainTableView.contentInset的设置滚动之前, 不然首次进来视图就会偏移到临界位置，contentInset会调用scrollViewDidScroll这个方法。
        //初始化变量
        self.canScroll = YES;
        self.isTopIsCanNotMoveTabView = NO;
        
        _mainTableView = [[LGMainTouchTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = self.headerImageView;
        _mainTableView.tableFooterView = self.setPageViewControllers;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.showsVerticalScrollIndicator = NO;
        [_mainTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CenterTestCollectionView class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CenterTestCollectionView class])];
    }
    return _mainTableView;
}

- (UIView *)headerContentView {
    if (!_headerContentView) {
        _headerContentView = [[UIView alloc]init];
        _headerContentView.backgroundColor = [UIColor clearColor];
    }
    return _headerContentView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.image = [UIImage imageNamed:@"center_avatar.jpeg"];
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.borderWidth = 1;
        _avatarImageView.layer.borderColor = FMCOLOR_RGBA(255, 253, 253, 1).CGColor;
        _avatarImageView.layer.cornerRadius = 40;
    }
    return _avatarImageView;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = [UIFont systemFontOfSize:16];
        _nickNameLabel.textColor = [UIColor whiteColor];
        _nickNameLabel.textAlignment = NSTextAlignmentCenter;
        _nickNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _nickNameLabel.numberOfLines = 0;
        _nickNameLabel.text = @"撒哈拉下雪了";
    }
    return _nickNameLabel;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"center_bg.jpg"]];
        _headerImageView.backgroundColor = [UIColor greenColor];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.frame = CGRectMake(0, -HeaderImageViewHeight, SCREEN_WIDTH, HeaderImageViewHeight);
    }
    return _headerImageView;
}

/*
 * 这里可以设置替换你喜欢的segmentView
 */
- (UIView *)setPageViewControllers {
    if (!_segmentView) {
        //设置子控制器
        LGFirstViewController *firstVC  = [[LGFirstViewController alloc] init];
        LGSecondViewController *secondVC = [[LGSecondViewController alloc] init];
        NSArray *controllers = @[firstVC, secondVC];
        NSArray *titleArray = @[@"华盛顿", @"夏威夷"];
        LGSegmentView *segmentView = [[LGSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_HEIGHT - NAVIGATION_HEIGHT) controllers:controllers titleArray:(NSArray *)titleArray parentController:self];
        //注意：不能通过初始化方法传递selectedIndex的初始值，因为内部使用的是Masonry布局的方式, 否则设置selectedIndex不起作用
        segmentView.selectedIndex = self.selectedIndex;
        _segmentView = segmentView;
    }
    return _segmentView;
}

@end
