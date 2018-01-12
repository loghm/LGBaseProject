//
//  FMRedPointView.h
//  ForMan
//
//  Created by chw on 16/6/27.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMRedPointView : UIView

///标注：-1显示红点，0不显示，1以上显示红底白字
@property (nonatomic, assign) NSInteger  badgeValue;

///标注的底色
@property (nonatomic, assign) UIColor *backGroundColor;

///标注颜色
@property (nonatomic, strong) UIColor *badgeColor;

///数字字体
@property (nonatomic, assign) CGFloat badgeFont;


@property (nonatomic, strong) UILabel *badgeLabel;
@end
