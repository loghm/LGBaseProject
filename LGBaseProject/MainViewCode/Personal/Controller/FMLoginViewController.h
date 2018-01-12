//
//  FMLoginViewController.h
//  ForMan
//
//  Created by chw on 16/6/27.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMBaseViewController.h"

typedef NS_ENUM(NSInteger,FMLoginViewControllerType) {
    FMLoginViewControllerTypeLogin  = 0,    //普通登录界面
    FMLoginViewControllerTypeBindMobile,    //绑定手机号界面
    FMLoginViewControllerTypeLoginForOrder, //登录后才能下订单，没有第三方登录按钮
    FMLoginViewControllerTypeBindForOrder,  //绑定手机号以下订单，已绑定则提示是否切换账号
};

@interface FMLoginViewController : FMBaseViewController

@property (nonatomic, assign) NSInteger viewType;

@property (nonatomic, strong) UIImage *lastViewImage;

@property (nonatomic, copy) FMBlock onComplete;

@property (nonatomic, assign) BOOL isUserAnimate;//是否启用动画效果  默认Yes
@end
