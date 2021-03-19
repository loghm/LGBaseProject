//
//  UIButton+ImageTitleSpaceCentering.h
//  LGButtonTitleImageInset
//
//  Created by 黄明族 on 2020/7/6.
//  Copyright © 2020 loghm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ImageTitleSpaceCentering)

- (void)centerButtonAndImageWithSpacing:(CGFloat)spacing;

/**
 精细
 计算title image的间距，其余分配给content距离左右的边距。如果想要设置content距离button左右的边距，可以改变button的大小来适应
 */
- (void)fineCenterButtonAndImageWithSpacing:(CGFloat)spacing;

/** 图片居右 */
- (void)buttonImageInRightPosition;

@end
