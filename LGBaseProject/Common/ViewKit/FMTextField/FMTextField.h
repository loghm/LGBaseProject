//
//  FMTextField.h
//  ForMan
//
//  Created by chw on 16/6/27.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMTextField : UITextField

/**
 *  设置UITextField左边提示语
 *
 *  @param string        左边提示文字
 *  @param color         颜色
 *  @param font          字体
 *  @param width         是否固定宽度
 *  @param textAlignment 对齐方式
 */
- (void)setLeftString:(NSString*)string color:(UIColor*)color font:(UIFont*)font width:(NSInteger)width textAlignment:(NSTextAlignment)textAlignment;

@end
