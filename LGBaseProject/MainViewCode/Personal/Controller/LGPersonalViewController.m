//
//  LGPersonalViewController.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/7.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGPersonalViewController.h"
#import "LGHomePageViewController.h"
#import "LGTabBarClickProtocol.h"

@interface LGPersonalViewController ()<LGTabBarClickProtocol>

@end

@implementation LGPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"-------LGPersonalViewController");
    [self createUI];
}

- (void)createUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"点击跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 12;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.borderWidth = 1;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(btn.mas_width).multipliedBy(1.0);
    }];
}

- (void)click:(UIButton *)btn {
    LGHomePageViewController *homeP = [[LGHomePageViewController alloc] init];
    [self.navigationController pushViewController:homeP animated:YES];
}

- (void)tabBarItemDidDoubleClick {
    NSLog(@"double click click click mine");
    [self.view fm_showTextHUD:@"double click click click mine"];
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
