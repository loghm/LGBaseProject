//
//  LGBaseViewController.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/9.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGBaseViewController.h"

#define BUTTON_DEFAULT_MARGIN  10
#define SCREEN__NAVIBAR__HEIGHT 30

@interface LGBaseViewController ()<UINavigationBarDelegate>


@end

@implementation LGBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];

    //导航条
    FM_WEAKSELF;
    [self.naviBarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.centerX.equalTo(weakSelf.view);
    }];
    [self.baseContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.bottom.centerX.equalTo(weakSelf.view);
    }];
}

- (void)setIsShowCustomBar:(BOOL)isShowCustomBar
{
    _isShowCustomBar = isShowCustomBar;
    if(isShowCustomBar)
    {
//        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController setNavigationBarHidden:YES animated:YES];

        self.naviBarContentView.hidden = NO;
        self.baseContentView.hidden =NO;
        FM_WEAKSELF;
        [self.naviBarContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(NAVIGATION_HEIGHT);
        }];
        [self.baseContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.naviBarContentView.mas_bottom);
        }];
        [self setupNaviBarContentViewChildView];
    }
    else
    {
//        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.naviBarContentView.hidden = YES;
        self.baseContentView.hidden =YES;
        [self.naviBarContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFLOAT_MIN);
        }];
        [self.baseContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(CGFLOAT_MIN);
        }];
    }
}

- (void)setupNaviBarContentViewChildView
{
    FM_WEAKSELF;
    FM_STRONGSELF(weakSelf);
    [self.baseLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN__NAVIBAR__HEIGHT, SCREEN__NAVIBAR__HEIGHT));
        make.left.equalTo(strongSelf.naviBarContentView).offset(BUTTON_DEFAULT_MARGIN);
        make.bottom.equalTo(strongSelf.naviBarContentView).offset(-BUTTON_DEFAULT_MARGIN);
    }];
    [self.baseRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN__NAVIBAR__HEIGHT, SCREEN__NAVIBAR__HEIGHT));
        make.right.equalTo(strongSelf.naviBarContentView).offset(-BUTTON_DEFAULT_MARGIN);
        make.bottom.equalTo(strongSelf.naviBarContentView).offset(-BUTTON_DEFAULT_MARGIN);
    }];
}

#pragma mark - method

/**
 设置标题栏文本
 
 @param title 标题栏文本内容
 */
- (void)setVCTitle:(NSString *)title
{
    UILabel *navLabel = (UILabel *)self.navigationItem.titleView;
    if(navLabel==nil)
    {
        navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        self.navigationItem.titleView = navLabel;
    }
    
    //中间标题
    navLabel.text = title;
    navLabel.textColor = [UIColor blackColor];
    navLabel.font = [UIFont systemFontOfSize:20];
    navLabel.textAlignment = NSTextAlignmentCenter;
}



/**
 页面跳转
 
 @param vcName 目标页面名称
 */
- (void)push:(NSString *)vcName
{
    Class classVC = NSClassFromString(vcName);
    UIViewController *vc = [classVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)push:(NSString *)vcName withAnimated:(NSInteger)type
{
    //动画
    CATransition *animation = [CATransition animation];
    //动画时间
    animation.duration = 1.0f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //过渡效果
    animation.type = @"rippleEffect";
    //过渡方向
    animation.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [self push:vcName];
}


/**
 带参数的页面跳转
 
 @param vcName 目标页面名称
 @param param  传到下个界面的参数
 @param delegate <#delegate description#>
 */
- (void)push:(NSString *)vcName param:(NSMutableDictionary *)param delegate:(id)delegate
{
    Class classVC = NSClassFromString(vcName);
    UIViewController *vc = [classVC new];
    
    if((param!=nil)||(delegate!=nil))
    {
        NSMutableDictionary *nextPara = [[NSMutableDictionary alloc]init];
        //if(param!=nil) [nextPara setObject:param forKey:@"param"];
        if(param!=nil)
        {
            for(NSString *paraName in param) {    // 正确的字典遍历方式
                [nextPara setObject:[param objectForKey:paraName] forKey:paraName];
            }
        }
        if(delegate!=nil) [nextPara setObject:delegate forKey:@"delegate"];
        
        //通过字典类型传输参数到下一个界面上
        [nextPara enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            //存在属性则赋值
            if ([self checkIsExistPropertyWithInstance:vc verifyPropertyName:key]) {
                [vc setValue:obj forKey:key];
            } else {
                //NSLog(@"property [%@] not found in [%@]",key,aVC);
            }
        }];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}



/**
 判断某个类是否存在属性值
 
 @param instance 所要检验的类
 @param verifyPropertyName 所要检验的属性值
 @return  YES - 存在
 NO  - 不存在
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    //获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance class], &outCount);
    
    if(properties) {
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            //属性名转成字符串
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            //判断该属性是否存在
            if ([propertyName isEqualToString:verifyPropertyName]) {
                free(properties);
                return YES;
            }
        }
        free(properties);
    }
    
    return NO;
}


/**
 返回上一界面
 */
-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 返回到某一界面
 
 @param vcName 新界面
 */
- (void)goBackVC:vcName
{
    Class classVC = NSClassFromString(vcName);
    // 返回到任意界面
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:classVC]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}




/**
 返回APP首页
 */
- (void)goMainVC
{
    [self.navigationController popToRootViewControllerAnimated:YES]; //清除所有界面,即返回主页
}



#pragma mark - handle

- (void)addLeftButtonSelector:(SEL)selector
{
    [self.baseLeftButton removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.baseLeftButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRightButtonSelector:(SEL)selector
{
    [self.baseRightButton removeTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.baseRightButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)setLeftButtonImage:(UIImage *)image{
    [self.baseLeftButton setImage:image forState:UIControlStateNormal];
}
- (void)setRightButtonImage:(UIImage *)image{
    [self.baseRightButton setImage:image forState:UIControlStateNormal];
}
- (void)setLeftButtonTitle:(NSString *)title
{
    [self.baseLeftButton setTitle:title forState:UIControlStateNormal];
}
- (void)setRightButtonTitle:(NSString *)title
{
    [self.baseRightButton setTitle:title forState:UIControlStateNormal];
}



#pragma mark - 设置状态条
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusStyle;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - set/get
- (UIView *)naviBarContentView
{
    if(_naviBarContentView == nil)
    {
        _naviBarContentView = [UIView new];
        [self.view addSubview:_naviBarContentView];
    }
    return _naviBarContentView;
}

- (UIView *)baseContentView
{
    if(_baseContentView == nil)
    {
        _baseContentView = [UIView new];
        [self.view addSubview:_baseContentView];
    }
    return _baseContentView;
}

- (UIButton *)baseLeftButton
{
    if(_baseLeftButton == nil)
    {
        _baseLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_baseLeftButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [_baseLeftButton setTitleColor:[FMColor hexStringToColor:@"0xffffff"] forState:UIControlStateNormal];
        [self.naviBarContentView addSubview:_baseLeftButton];
    }
    return _baseLeftButton;
}

- (UIButton *)baseRightButton
{
    if(_baseRightButton == nil)
    {
        _baseRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_baseRightButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [_baseRightButton setTitleColor:[FMColor hexStringToColor:@"0xffffff"] forState:UIControlStateNormal];
        [self.naviBarContentView addSubview:_baseRightButton];
    }
    return _baseRightButton;
}


/** 自动刷新*/
- (void)autoRefresh {
    
}


/**
 *  显示空页面 放置在self.view 上
 *
 *  @param isShow 是否显示
 */
- (void)showEmptyView:(BOOL)isShow{
//    if (isShow) {
//        [self.view bringSubviewToFront:self.emptyView];
//        _emptyView.backgroundColor = [self.view backgroundColor];
//        _emptyView.hidden = NO;
//    } else {
//        _emptyView.hidden = YES;
//    }
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
