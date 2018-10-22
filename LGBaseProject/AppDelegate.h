//
//  AppDelegate.h
//  LGBaseProject
//
//  Created by loghm on 2017/12/13.
//  Copyright © 2017年 loghm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGMainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) LGMainViewController *rootTabBarViewController;

@end

