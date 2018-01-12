//
//  FMColor.h
//  ForMan
//
//  Created by chw on 16/6/12.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>

//转换十六进制值到rgb
#define FMCOLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define FMCOLOR_HEXAndAlpha(rgbValue,alfa) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alfa]

#define FMCOLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define FMCOLOR_RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

@interface FMColor : NSObject

//顶部导航条颜色
+ (UIColor*)fmColor_Navigation_Back;
+ (UIColor*)fmColor_Navigation_Title;

//底部tabbar颜色
+ (UIColor*)fmColor_TabBar_Back;
+ (UIColor*)fmColor_TabBar_Title;

//例如商品详情底部那一行的颜色
+ (UIColor*)fmColor_BottomView_Back;

//controller.view默认背景色s
+ (UIColor*)fmColor_Controller_View_Background;

//分割线颜色，如tableview的cell之间
+ (UIColor*)fmColor_Seperate_Line;

//边界线颜色，如view的borderColor
+ (UIColor*)fmColor_Border_Line;

//cell被选中时的高亮颜色
+ (UIColor*)fmColor_Cell_Hightlight_Color;

#pragma mark - 直播色值

+ (UIColor *)fmColor_white;


+ (UIColor *)fmColor_B1;
+ (UIColor *)fmColor_B2;
+ (UIColor *)fmColor_B3;
+ (UIColor *)fmColor_B4;
+ (UIColor *)fmColor_B5;

+ (UIColor *)fmColor_sd1;//字体阴影的颜色

+ (UIColor *)fmColor_Y1;
+ (UIColor *)fmColor_Y2;
+ (UIColor *)fmColor_Y3;


+ (UIColor *)fmColor_RED;
+ (UIColor *)fmColor_BGC;
+ (UIColor *)fmColor_BG2;

+ (UIColor *)fmColor_ZB3;
+ (UIColor *)fmColor_ZB4;

+ (UIColor *)fmColor_Line1;
+ (UIColor *)fmColor_Line2;

+ (UIColor *)fmColor_blue;

+ (UIColor *)fmColor_343434;
+ (UIColor *)fmColor_666666;
+ (UIColor *)fmColor_999999;
+ (UIColor *)fmColor_e8e8e8;
+ (UIColor *)fmColor_cfcfcf;
+ (UIColor *)fmColor_f7f7f7;
+ (UIColor *)fmColor_fed934;
+ (UIColor *)fmColor_fe9a42;
+ (UIColor *)fmColor_e40046;

#pragma mark - 男人帮过期色值

+ (UIColor *)fmColor_c1;
+ (UIColor *)fmColor_c2;
+ (UIColor *)fmColor_c3;
+ (UIColor *)fmColor_c4;

+ (UIColor *)fmColor_g1;
+ (UIColor *)fmColor_g2;
+ (UIColor *)fmColor_g3;
+ (UIColor *)fmColor_g4;
+ (UIColor *)fmColor_g5;
+ (UIColor *)fmColor_g6;

+ (UIColor *)fmColor_red;



+ (UIColor *)fmColor_picLoadingBg;

+ (UIColor *)fmColor_btn1_text_disable;
+ (UIColor *)fmColor_btn1_text_normal;
+ (UIColor *)fmColor_btn1_text_press;

+ (UIColor *)fmColor_btn1_fill_disable;
+ (UIColor *)fmColor_btn1_fill_normal;
+ (UIColor *)fmColor_btn1_fill_press;


+ (UIColor *)fmColor_btn3_text_disable;
+ (UIColor *)fmColor_btn3_text_normal;
+ (UIColor *)fmColor_btn3_text_press;

+ (UIColor *)fmColor_btn3_fill_disable;
+ (UIColor *)fmColor_btn3_fill_normal;
+ (UIColor *)fmColor_btn3_fill_press;


+ (UIColor *)fmColor_btn5_text_disable;
+ (UIColor *)fmColor_btn5_text_normal;
+ (UIColor *)fmColor_btn5_text_press;

+ (UIColor *)fmColor_btn5_fill_disable;
+ (UIColor *)fmColor_btn5_fill_normal;
+ (UIColor *)fmColor_btn5_fill_press;

+ (UIColor *)fmColor_btn6_fill_press;

+ (UIColor *)fmColor_btn8_fill_disable;
+ (UIColor *)fmColor_btn8_text_disable;
+ (UIColor *)fmColor_btn8_fill_press;
+ (UIColor *)fmColor_btn8_text_press;

+ (UIColor *)fmColor_btn9_fill_disable;
+ (UIColor *)fmColor_btn9_text_disable;
+ (UIColor *)fmColor_btn9_fill_normal;
+ (UIColor *)fmColor_btn9_text_normal;
+ (UIColor *)fmColor_btn9_fill_press;
+ (UIColor *)fmColor_btn9_text_press;


//转换带#的颜色值
+ (UIColor *)fmColorFromString:(NSString*)strColor;

//转换颜色值
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

@end
