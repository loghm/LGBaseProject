//
//  LGNavigationViewController.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/10.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGNavigationViewController.h"

@interface LGNavigationViewController ()

@end

@implementation LGNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景颜色
    [self.navigationBar setBarTintColor:[FMColor hexStringToColor:@"#282B35"]];
    //字体颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldItalicMT" size:17.0f],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.view endEditing:YES];//强制收起键盘
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    //判断第二级界面是否显示下边标签栏
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}


#pragma makr --- 改变返回按钮
+(void)initialize
{
    // 获取特定类的所有导航条
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    // 使用自己的图片替换原来的返回图片
    navigationBar.backIndicatorImage = [UIImage imageNamed:@"icon-Returnby"];
    navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"icon-Returnby"];
    
    // 设置返回图片颜色
    navigationBar.tintColor = [FMColor hexStringToColor:@"513622"];
    
    //F3D120
    [navigationBar setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0xFFFFFF)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
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
