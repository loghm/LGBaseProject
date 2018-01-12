//
//  FMViewConstructUtil.h
//  ForMan
//
//  Created by slj on 16/6/21.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FMBtnType) {
    FMBtnType_btn1,
    FMBtnType_btn2,
    FMBtnType_btn3,
    FMBtnType_btn4,
    FMBtnType_btn5,
    FMBtnType_btn6,
    FMBtnType_btn8,
    FMBtnType_btn9,

};


@interface FMViewConstructUtil : NSObject

/*
 *  基本创建UIButton
 *  按钮的颜色
 */
+(UIButton *)constructButton:(CGRect)frame
                        type:(FMBtnType)type;

/*
 *  基本创建UIButton
 *  按钮的颜色
 */
+(UIButton *)constructButton:(CGRect)frame
                      target:(id)target
                      action:(SEL)action
                        type:(FMBtnType)type;


+(void )constructButtonStyle:(UIButton *)btn  type:(FMBtnType)type;

/**
 *  创建CheckBox 按钮，只设置背景图片
 *
 *  @return UIButton
 */
+ (UIButton *)constructSelectButton;

/*
 * 创建基本Label，并且是居中
 */
+ (UILabel *)constructLabel:(CGRect)frame
                       text:(NSString *)text
                       font:(UIFont *)font
                  textColor:(UIColor *)color;

/*
 * 创建Label，大小自适应
 */
+ (UILabel *)constructLabelSizeToFitWithText:(NSString *)text
                                        font:(UIFont *)font
                                   textColor:(UIColor *)color;
@end
