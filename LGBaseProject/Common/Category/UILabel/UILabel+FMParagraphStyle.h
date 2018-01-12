//
//  UILabel+FMParagraphStyle.h
//  ForMan
//
//  Created by chw on 16/6/21.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FMParagraphStyle)

/**
 *  设置UILabel的字间距时使用(设置字色和字体必须在这之前)
 *
 *  @param string           文字
 *  @param characterSpacing 字间距
 */
- (void)fmSetText:(NSString*)string withCharacterSpacing:(CGFloat)characterSpacing;

/**
 *  设置UILabel的行间距和字间距时使用(设置字色和字体必须在这之前)
 *
 *  @param string           文字
 *  @param lineSpacing      行间距
 *  @param characterSpacing 字间距
 */
- (void)fmSetText:(NSString*)string withLineSpacing:(CGFloat)lineSpacing withCharacterSpacing:(CGFloat)characterSpacing;

/**
 *  设置UILabel的行间距、字间距、颜色、字体
 *
 *  @param string           文字
 *  @param lineSpacing      行间距
 *  @param characterSpacing 字间距
 *  @param textColor        文字颜色
 *  @param font             字体
 */
- (void)fmSetText:(NSString*)string withLineSpacing:(CGFloat)lineSpacing withCharacterSpacing:(CGFloat)characterSpacing withTextColor:(UIColor*)textColor withFont:(UIFont*)font;

/**
 *  设置UILabel的行间距、字间距、颜色、字体、对齐方式
 *
 *  @param string           文字
 *  @param lineSpacing      行间距
 *  @param characterSpacing 字间距
 *  @param textColor        文字颜色
 *  @param font             字体
 *  @param aligment         对齐方式
 */
- (void)fmSetText:(NSString*)string withLineSpacing:(CGFloat)lineSpacing withCharacterSpacing:(CGFloat)characterSpacing withTextColor:(UIColor*)textColor withFont:(UIFont*)font textAligment:(NSTextAlignment)aligment;

@end
