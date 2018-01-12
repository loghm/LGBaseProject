//
//  LGRangerReadingViewController.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/9.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGRangerReadingViewController.h"

@interface LGRangerReadingViewController ()

@end

@implementation LGRangerReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"-------LGBorrowViewController");
    [self setUpNavi];
}


- (void)setUpNavi {
//    self.isShowCustomBar = YES;
//    self.naviBarContentView.backgroundColor = [UIColor blackColor];
//    self.statusStyle = UIStatusBarStyleLightContent;
//    [self setLeftButtonImage:[UIImage imageNamed:@"searchbar_search"]];
//    [self setRightButtonImage:[UIImage imageNamed:@"searchbar_search"]];
    //    FM_WEAKSELF;
    //    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(weakSelf.baseLeftButton.mas_right).offset(45);
    //        make.right.equalTo(weakSelf.baseRightButton.mas_left).offset(-45);
    //        make.centerX.equalTo(weakSelf.naviBarContentView);
    //        make.centerY.equalTo(weakSelf.baseLeftButton);
    //        make.height.mas_equalTo(LZBSCREEN__NAVIBAR__HEIGHT);
    //    }];
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
