//
//  LGPersonalViewController.m
//  LGBaseProject
//
//  Created by loghm on 2018/1/7.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import "LGPersonalViewController.h"

@interface LGPersonalViewController ()

@end

@implementation LGPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"-------LGPersonalViewController");
    
    [self recordNote];
    
    
}


- (void)recordNote {
    //直接调用方法的方式 performSelector、NSInvocation
    //最多可以
    //    [self performSelector:<#(SEL)#> withObject:<#(id)#> withObject:<#(id)#>]
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
