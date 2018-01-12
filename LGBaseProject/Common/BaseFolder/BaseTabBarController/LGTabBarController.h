//
//  LGTabBarController.h
//  LGBaseProject
//
//  Created by loghm on 2018/1/9.
//  Copyright © 2018年 loghm. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FMTabBar.h"

@protocol LGTabBarControllerProtocol <NSObject>

- (void)setBadgeValue:(NSString *)badgeValue;



@end

@interface LGTabBarController : UITabBarController

@property (nonatomic, strong) FMTabBar *myTabBar;

@end
