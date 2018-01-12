//
//  FMNavigationViewController
//  ForMan
//
//  Created by slj on 16-06-17.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMNavigationViewController.h"

@interface FMNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation FMNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景颜色
    [self.navigationBar setBarTintColor:[FMColor hexStringToColor:@"#F7F7F9"]];
    //字体颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0f],NSForegroundColorAttributeName:[FMColor hexStringToColor:@"#A4A4A4"]}];
}


// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.view endEditing:YES];//强制收起键盘
    //设置导航控制器上返回按钮字体大小
    [viewController.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    //从首页的某一个tab页面跳转到二级页面，需要把底部的tab栏隐藏掉
    if (self.childViewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}


//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.enabled = YES;
//    }
//    NSLog(@"%@ did show", [viewController.class description]);
//}



@end
