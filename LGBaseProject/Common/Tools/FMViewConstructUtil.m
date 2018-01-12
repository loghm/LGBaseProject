//
//  FMViewConstructUtil.m
//  ForMan
//
//  Created by slj on 16/6/21.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMViewConstructUtil.h"
#import "UIImage+YYAdd.h"


@implementation FMViewConstructUtil

/*
 *  基本创建UIButton
 *  按钮的颜色
 */
+(UIButton *)constructButton:(CGRect)frame
                        type:(FMBtnType)type
{
    return [[self class] constructButton:frame target:nil action:nil type:type];
}
/*
 *  基本创建UIButton
 *  按钮的颜色
 */
+(UIButton *)constructButton:(CGRect)frame
                      target:(id)target
                      action:(SEL)action
                        type:(FMBtnType)type{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.frame = frame;
    [[self class]constructButtonStyle:btn type:type];
    return btn;
}

+(void )constructButtonStyle:(UIButton *)btn  type:(FMBtnType)type
{
    switch (type) {
        case FMBtnType_btn1:
        case FMBtnType_btn2:
        {
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn1_fill_normal]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn1_fill_press]] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn1_fill_disable]] forState:UIControlStateDisabled];
            [btn setTitleColor:[FMColor fmColor_btn1_text_normal] forState:UIControlStateNormal];
            [btn setTitleColor:[FMColor fmColor_btn1_text_press] forState:UIControlStateHighlighted];
            [btn setTitleColor:[FMColor fmColor_btn1_text_disable] forState:UIControlStateDisabled];
            
            if (type == FMBtnType_btn2) {
                btn.layer.cornerRadius = 2.0f;
                btn.layer.masksToBounds = YES;
            }
            
        }
            break;
        case FMBtnType_btn3:
        case FMBtnType_btn4:
        {
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn3_fill_normal]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn3_fill_press]] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn3_fill_disable]] forState:UIControlStateDisabled];
            [btn setTitleColor:[FMColor fmColor_btn3_text_normal] forState:UIControlStateNormal];
            [btn setTitleColor:[FMColor fmColor_btn3_text_press] forState:UIControlStateHighlighted];
            [btn setTitleColor:[FMColor fmColor_btn3_text_disable] forState:UIControlStateDisabled];
            
            if (type == FMBtnType_btn4) {
                btn.layer.cornerRadius = 2.0f;
                btn.layer.masksToBounds = YES;
            }
        }
            break;
        case FMBtnType_btn5:
        {
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn5_fill_normal]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn5_fill_press]] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn5_fill_disable]] forState:UIControlStateDisabled];
            [btn setTitleColor:[FMColor fmColor_btn5_text_normal] forState:UIControlStateNormal];
            [btn setTitleColor:[FMColor fmColor_btn5_text_press] forState:UIControlStateHighlighted];
            [btn setTitleColor:[FMColor fmColor_btn5_text_disable] forState:UIControlStateDisabled];
            
            btn.layer.borderColor = [FMColor fmColor_g2].CGColor;
            btn.layer.borderWidth = 1;
            btn.layer.cornerRadius = 2.0f;
            btn.layer.masksToBounds = YES;
            
        }
            break;
        case FMBtnType_btn8:
        {
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_c4]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn8_fill_press]] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn8_fill_disable]] forState:UIControlStateDisabled];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitleColor:[FMColor fmColor_btn8_fill_press] forState:UIControlStateHighlighted];
            [btn setTitleColor:[FMColor fmColor_btn8_text_disable] forState:UIControlStateDisabled];
            
//            btn.layer.borderColor = [FMColor fmColor_g2].CGColor;
//            btn.layer.borderWidth = 1;
//            btn.layer.cornerRadius = 2.0f;
//            btn.layer.masksToBounds = YES;
            break;
        }
        case FMBtnType_btn9:
        {
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn9_fill_normal]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn9_fill_press]] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn9_fill_disable]] forState:UIControlStateDisabled];
            [btn setTitleColor:[FMColor fmColor_btn9_text_normal] forState:UIControlStateNormal];
            [btn setTitleColor:[FMColor fmColor_btn9_text_press] forState:UIControlStateHighlighted];
            [btn setTitleColor:[FMColor fmColor_btn9_text_disable] forState:UIControlStateDisabled];
            
//            btn.layer.borderColor = [FMColor fmColor_g2].CGColor;
//            btn.layer.borderWidth = 1;
//            btn.layer.cornerRadius = 2.0f;
//            btn.layer.masksToBounds = YES;
            
        }
            break;
        case FMBtnType_btn6:
        {
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_red]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_btn6_fill_press]] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[UIImage imageWithColor:[FMColor fmColor_red]] forState:UIControlStateDisabled];
            [btn setTitleColor:[FMColor fmColor_btn9_text_normal] forState:UIControlStateNormal];
            [btn setTitleColor:[FMColor fmColor_btn9_text_press] forState:UIControlStateHighlighted];
            [btn setTitleColor:[FMColor fmColor_btn9_text_disable] forState:UIControlStateDisabled];
        }
            break;
        default:
            break;
    }
    
}

/**
 *  创建CheckBox 按钮，只设置背景图片
 *
 *  @return UIButton
 */
+ (UIButton *)constructSelectButton
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"cart_check_un"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"cart_check"] forState:UIControlStateSelected];
    
    return button;
}


/*
 * 创建基本Label，并且是居中
 */
+ (UILabel *)constructLabel:(CGRect)frame
                       text:(NSString *)text
                       font:(UIFont *)font
                  textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    if (font) {
        label.font = font;
    }
    if (color) {
        label.textColor = color;
    }
    if (text) {
        label.text = text;
    }
    label.userInteractionEnabled = NO;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

/*
 * 创建Label，大小自适应
 */
+ (UILabel *)constructLabelSizeToFitWithText:(NSString *)text
                                        font:(UIFont *)font
                                   textColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    if (font) {
        label.font = font;
    }
    if (color) {
        label.textColor = color;
    }
    
    if (text) {
        label.text = text;
    }
    [label sizeToFit];
    label.frame = CGRectMake(0, 0, label.width, label.height);
    
    
    return label;
}
@end
