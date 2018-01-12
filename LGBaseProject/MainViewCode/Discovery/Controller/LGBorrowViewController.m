//
//  LGBorrowViewController.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/7.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGBorrowViewController.h"
#import "UIButton+Badge.h"

@interface LGBorrowViewController ()

@end

@implementation LGBorrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"-------LGBorrowViewController");
    [self setUpNavi];
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //隐藏
    self.isShowCustomBar = YES;
}

- (void)setUpNavi {
    //两种模式--隐藏导航栏自定义view，或者不隐藏导航栏扩展导航栏属性。
    self.naviBarContentView.backgroundColor = [FMColor hexStringToColor:@"#DBDADB"];
    self.statusStyle = UIStatusBarStyleLightContent;
    [self setLeftButtonImage:[UIImage imageNamed:@"search"]];
    [self setRightButtonImage:[UIImage imageNamed:@"search"]];
    self.baseLeftButton.badgeValue = @"1";
    self.baseLeftButton.badgeBGColor = [UIColor redColor];
    self.baseLeftButton.badgeTextColor = [UIColor whiteColor];
    [self setCenterSearchButton];
}

- (void)setCenterSearchButton {
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.naviBarContentView addSubview:searchButton];
    FM_WEAKSELF
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.left.mas_equalTo(weakSelf.baseLeftButton.mas_right).offset(15);
        make.right.mas_equalTo(weakSelf.baseRightButton.mas_left).offset(-15);
        make.bottom.mas_equalTo(weakSelf.naviBarContentView).offset(-10);
    }];
    [searchButton setImage:LGImageName(@"navbar_icon_search") forState:UIControlStateNormal];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
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
