//
//  UIImage+MMBlur.h
//  MeiMei
//
//  Created by 陈炜来 on 16/1/26.
//  Copyright © 2016年 MeiMei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MMBlur)
//返回高斯模糊的图
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;

/**
 *  生成圆角的图片
 *
 *  @param originImage 原始图片
 *  @param borderColor 边框原色
 *  @param borderWidth 边框宽度
 *
 *  @return 圆形图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end
