//
//  UIButton+CustomImageLayout.h
//  LGBaseProject
//
//  Created by loghm on 2018/3/14.
//  Copyright © 2018年 loghm. All rights reserved.
//

/**
 *  利用runtime实现Button图片和文字的任意布局。
 */

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ButtonImgViewStyleTop,
    ButtonImgViewStyleLeft,
    ButtonImgViewStyleBottom,
    ButtonImgViewStyleRight,
} ButtonImgViewStyle;

@interface UIButton (CustomImageLayout)

/**
 设置 按钮 图片所在的位置
 
 @param style   图片位置类型（上、左、下、右）
 @param size    图片的大小
 @param space 图片跟文字间的间距
 */
- (void)setImgViewStyle:(ButtonImgViewStyle)style imageSize:(CGSize)size space:(CGFloat)space;


@end
