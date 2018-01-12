//
//  FMColor.m
//  ForMan
//
//  Created by chw on 16/6/12.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMColor.h"

@implementation FMColor

//导航条颜色
+ (UIColor*)fmColor_Navigation_Back
{
    return [FMColor fmColor_white];
//    return [FMColor fmColor_Y1];
}

+ (UIColor*)fmColor_Navigation_Title
{
    return [FMColor fmColor_B1];
}

//底部tabbar颜色
+ (UIColor*)fmColor_TabBar_Back
{
//    if (IOS8)
//    {
        return [FMColor fmColor_white];;
//    }
//    else
//    {
//        return FMCOLOR_HEX(0x1c232c);
//    }
}

+ (UIColor*)fmColor_TabBar_Title
{
    return [UIColor whiteColor];
}

 + (UIColor*)fmColor_BottomView_Back
{
    return FMCOLOR_HEX(0x474d55);
}

//controller.view默认背景色s
+ (UIColor*)fmColor_Controller_View_Background
{
    return [[self class] fmColor_BGC];
}

//分割线颜色，如tableview的cell之间
+ (UIColor*)fmColor_Seperate_Line
{
    return FMCOLOR_HEX(0xdddddd);
}

//边界线颜色，如view的borderColor
+ (UIColor*)fmColor_Border_Line
{
    return FMCOLOR_HEX(0xdddddd);
}

//cell被选中时的高亮颜色
+ (UIColor*)fmColor_Cell_Hightlight_Color
{
    return FMCOLOR_HEX(0xf6f8fb);
}

+ (UIColor *)fmColor_Line1
{
    return FMCOLOR_HEX(0xf3f4fa);
}

+ (UIColor *)fmColor_Line2
{
    return FMCOLOR_HEX(0xdadce3);
}

#pragma mark - 直播色值

+ (UIColor *)fmColor_white
{
    return [UIColor whiteColor];
}
+ (UIColor *)fmColor_B1
{
    return [[self class] fmColor_343434];
}

+ (UIColor *)fmColor_B2
{
    return FMCOLOR_HEX(0x353534);

}
+ (UIColor *)fmColor_B3
{
    return [[self class] fmColor_666666];

}
+ (UIColor *)fmColor_B4
{
    return FMCOLOR_HEX(0xCCCCCC);
}
+ (UIColor *)fmColor_B5
{
    return FMCOLOR_HEX(0x9f9f9f);
}


+ (UIColor *)fmColor_sd1
{
    return [[self fmColor_g1] colorWithAlphaComponent:0.3];
}

+ (UIColor *)fmColor_Y1
{
    return FMCOLOR_HEX(0xf71ca3);

}
+ (UIColor *)fmColor_Y2
{
    return FMCOLOR_HEX(0xfe51cb);

}
+ (UIColor *)fmColor_Y3
{
    return FMCOLOR_HEX(0xf12ccf);
    
}

+ (UIColor *)fmColor_ZB3
{
    return FMCOLOR_HEX(0x9c7231);

}
+ (UIColor *)fmColor_ZB4
{
    return FMCOLOR_HEX(0x6760bd);
    
}

+ (UIColor *)fmColor_RED
{
    return FMCOLOR_HEX(0xed3d3d);

}
+ (UIColor *)fmColor_BGC
{
    return FMCOLOR_HEX(0xf0f0f0);

}
+ (UIColor *)fmColor_BG2
{
    return [FMColor fmColor_B2];
}

+ (UIColor *)fmColor_blue
{
    return FMCOLOR_HEX(0x2db6fd);
}

+ (UIColor *)fmColor_343434
{
    return FMCOLOR_HEX(0x343434);
}
+ (UIColor *)fmColor_fed934
{
//    return FMCOLOR_HEX(0xfcd934);

    return FMCOLOR_HEX(0xFF1493);
}
+ (UIColor *)fmColor_fe9a42
{
    return FMCOLOR_HEX(0xfe429a);
}
+ (UIColor *)fmColor_666666
{
    return FMCOLOR_HEX(0x666666);
}

+ (UIColor *)fmColor_999999
{
    return FMCOLOR_HEX(0x999999);
}
+ (UIColor *)fmColor_cfcfcf
{
    return FMCOLOR_HEX(0xcfcfcf);
}

+ (UIColor *)fmColor_f7f7f7
{
    return FMCOLOR_HEX(0xf7f7f7);
}
+ (UIColor *)fmColor_e8e8e8
{
    return FMCOLOR_HEX(0xe8e8e8);
}

+ (UIColor*)fmColor_e40046
{
    return FMCOLOR_HEX(0xe40046);
}


#pragma mark - 男人帮过期色值

+ (UIColor *)fmColor_c1
{
    return FMCOLOR_HEX(0x1c232c);
}

+ (UIColor *)fmColor_c2
{
    return FMCOLOR_HEX(0xa4925a);
}
+ (UIColor *)fmColor_c3
{
    return FMCOLOR_HEX(0x29738f);
}

+ (UIColor *)fmColor_c4
{
    return FMCOLOR_HEX(0x3c424a);
}

+ (UIColor *)fmColor_g1
{
    return FMCOLOR_HEX(0x030303);
}

+ (UIColor *)fmColor_g2
{
    return FMCOLOR_HEX(0x6d6f74);
}

+ (UIColor *)fmColor_g3
{
    return FMCOLOR_HEX(0xaeb0b7);
}

+ (UIColor *)fmColor_g4
{
    return FMCOLOR_HEX(0xdadce3);
}

+ (UIColor *)fmColor_g5
{
    return FMCOLOR_HEX(0xf3f4fa);
}

+ (UIColor *)fmColor_g6
{
    return FMCOLOR_HEX(0xf1f4f8);
}

+ (UIColor *)fmColor_red
{
    return FMCOLOR_HEX(0xcc3333);
}

+ (UIColor *)fmColor_picLoadingBg
{
//    FMCOLOR_HEX(0xeaebf1)
    return [UIColor whiteColor];
}

+ (UIColor *)fmColor_btn1_text_disable
{
    return FMCOLOR_RGBA(255,255,255,0.4);
}
+ (UIColor *)fmColor_btn1_text_normal
{
    return [UIColor whiteColor];
}
+ (UIColor *)fmColor_btn1_text_press
{
    return FMCOLOR_RGBA(255,255,255,0.8);
}

+ (UIColor *)fmColor_btn1_fill_disable
{
    return [FMColor fmColor_c2];
}
+ (UIColor *)fmColor_btn1_fill_normal
{
    return [FMColor fmColor_c2];
}
+ (UIColor *)fmColor_btn1_fill_press
{
    return FMCOLOR_HEX(0x8a7535);
}


+ (UIColor *)fmColor_btn3_text_disable
{
    return FMCOLOR_RGBA(255,255,255,0.4);
}
+ (UIColor *)fmColor_btn3_text_normal
{
    return [UIColor whiteColor];
}
+ (UIColor *)fmColor_btn3_text_press
{
    return FMCOLOR_RGBA(255,255,255,0.8);
}

+ (UIColor *)fmColor_btn3_fill_disable
{
    return [FMColor fmColor_c1];
}
+ (UIColor *)fmColor_btn3_fill_normal
{
    return [FMColor fmColor_c1];
}
+ (UIColor *)fmColor_btn3_fill_press
{
    return FMCOLOR_HEX(0x3e444b);
}


+ (UIColor *)fmColor_btn5_text_disable
{
    return FMCOLOR_HEXAndAlpha(0x6d6f74, 0.4);
}
+ (UIColor *)fmColor_btn5_text_normal
{
    return [FMColor fmColor_g2];
}
+ (UIColor *)fmColor_btn5_text_press
{
    return [UIColor whiteColor];
}

+ (UIColor *)fmColor_btn5_fill_disable
{
    return [UIColor whiteColor];
}
+ (UIColor *)fmColor_btn5_fill_normal
{
    return [UIColor whiteColor];
}
+ (UIColor *)fmColor_btn5_fill_press
{
    return [FMColor fmColor_g2];
}

+ (UIColor *)fmColor_btn6_fill_press
{
    return FMCOLOR_HEXAndAlpha(0xaf3434, 1);
}

+ (UIColor *)fmColor_btn8_fill_disable
{
     return FMCOLOR_HEXAndAlpha(0x595e65, 0.28);
}
+ (UIColor *)fmColor_btn8_text_disable
{
    return FMCOLOR_HEX(0xffffff);
}
+ (UIColor *)fmColor_btn8_fill_press
{
    return FMCOLOR_HEXAndAlpha(0x595e65, 1);
}
+ (UIColor *)fmColor_btn8_text_press
{
    return FMCOLOR_HEXAndAlpha(0xffffff,0.5) ;
}


+ (UIColor *)fmColor_btn9_fill_disable
{
    return [self fmColor_c3];
}
+ (UIColor *)fmColor_btn9_text_disable
{
    return FMCOLOR_HEXAndAlpha(0xffffff,0.28);
}
+ (UIColor *)fmColor_btn9_fill_normal
{
    return [self fmColor_c3];
}
+ (UIColor *)fmColor_btn9_text_normal
{
    return [UIColor whiteColor];
}
+ (UIColor *)fmColor_btn9_fill_press
{
    return FMCOLOR_HEXAndAlpha(0x1b627b, 1);
}
+ (UIColor *)fmColor_btn9_text_press
{
    return FMCOLOR_HEXAndAlpha(0xffffff,0.5) ;
}

//转换带#的颜色值
+ (UIColor *)fmColorFromString:(NSString*)strColor
{
    if (!strColor)
        return nil;
    NSMutableString *color = [NSMutableString stringWithString:strColor];
    // 转换成标准16进制数
    [color replaceCharactersInRange:[strColor rangeOfString:@"#"] withString:@"0x"];
    
    // 十六进制字符串转成整形。
    long colorLong = strtoul([color cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    return FMCOLOR_HEX(colorLong);
}


+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 charactersif ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appearsif ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}





@end

