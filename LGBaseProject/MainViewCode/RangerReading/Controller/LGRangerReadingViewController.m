//
//  LGRangerReadingViewController.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/9.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGRangerReadingViewController.h"
#import "LGGradientXibView.h"
#import "LGTabBarClickProtocol.h"

@interface LGRangerReadingViewController ()<LGTabBarClickProtocol>



@end

@implementation LGRangerReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"-------LGBorrowViewController");
    [self setUpNavi];
   
    UIView *takeupView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, 100, 100)];
    takeupView.backgroundColor = [UIColor redColor];
    [self.view addSubview:takeupView];
    LGGradientXibView *gradientView = [[LGGradientXibView alloc] initWithFrame:CGRectMake(30, 100, 200, 200)];
    [self.view insertSubview:gradientView atIndex:0];
    
    [self createTestView];
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

- (void)createTestView {
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.center = CGPointMake(0.5*SCREEN_WIDTH, 0.5*SCREEN_HEIGHT);
    [self.view addSubview:testView];
    
    //设置渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = testView.bounds;
    gradientLayer.borderWidth = 0;
    gradientLayer.frame = testView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects: (id)[[UIColor colorWithHexString:@"#A1CBFF"] CGColor],
                            (id)[[UIColor colorWithHexString:@"#8FA7FF"] CGColor], nil, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    [testView.layer insertSublayer:gradientLayer atIndex:0];
    
}

- (void)tabBarItemDidDoubleClick {
    [self.view fm_showTextHUD:@"double click click"];
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
