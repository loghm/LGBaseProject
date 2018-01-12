//
//  FMBadgeButton.h
//  ForMan
//
//  Created by chw on 16/6/27.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMRedPointView.h"

@interface FMBadgeButton : UIButton

///标注：-1显示红点，0不显示，1以上显示红底白字
@property (nonatomic, assign) NSInteger badgeValue;

///标注颜色
@property (nonatomic, strong) UIColor *badgeColor;

///标注圆圈颜色
@property (nonatomic, strong) UIColor *badgeBackColor;

@property (nonatomic, assign) CGPoint badgeOrigin;

///默认图片
@property (nonatomic, strong) NSString *placeholderImage;

///网络图片一定要先设置默认图placeholderImage。否则默认图不起作用~
@property (nonatomic, strong) id image;

@property (nonatomic,strong) UIImageView  *backImageView;

@property (nonatomic, strong) FMRedPointView *badgeView;
@end
