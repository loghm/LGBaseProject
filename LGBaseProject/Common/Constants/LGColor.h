//
//  LGColor.h
//  LGBaseProject
//
//  Created by loghm on 2018/10/22.
//  Copyright © 2018 loghm. All rights reserved.
//

#import <Foundation/Foundation.h>

//转换十六进制值到rgb
#define LGCOLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define LGCOLOR_HEXAndAlpha(rgbValue,alfa) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alfa]

#define LGCOLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define LGCOLOR_RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


NS_ASSUME_NONNULL_BEGIN

@interface LGColor : NSObject

//顶部导航条颜色
+ (UIColor*)lgColor_Navigation_Back;
+ (UIColor*)lgColor_Navigation_Title;

@end

NS_ASSUME_NONNULL_END
