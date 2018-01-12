//
//  LGTabBarController.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/9.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGTabBarController.h"
#import "FMTabBar.h"

@interface LGTabBarController ()


@end

@implementation LGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTabBar];
}


- (void)addTabBar {
    // 利用KVO来使用自定义的tabBar
    self.myTabBar = [[FMTabBar alloc] init];
    [self setValue:self.myTabBar forKey:@"tabBar"];
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
