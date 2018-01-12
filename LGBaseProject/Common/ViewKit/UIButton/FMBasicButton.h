//
//  FMBasicButton.h
//  ForMan
//
//  Created by chw on 16/6/22.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FMBasicButtonStyle) {
    FMBasicButton_BTN1     = 0,    //normal Y1背景，Disabled line1，  44高度，左右间距16
    FMBasicButton_BTN2     = 2,    //normal FMCOLOR_HEX(0xFBD848)背景，

    FMBasicButton_BTN9     = 9,    //normal Y1背景，Disabled line1，  44高度，左右间距16

};

@interface FMBasicButton : UIButton

@property (nonatomic, assign) FMBasicButtonStyle fmStyle;

- (void)setBorderColor:(UIColor*)borderColor forState:(UIControlState)state;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


+ (FMBasicButton*)buttonWithStyle:(FMBasicButtonStyle)style;    //使用约束时用的
+ (FMBasicButton*)buttonWithFrame:(CGRect)rect style:(FMBasicButtonStyle)style;
+ (FMBasicButton*)buttonWithFrame:(CGRect)rect style:(FMBasicButtonStyle)style target:(id)target selector:(SEL)selector;

@end
