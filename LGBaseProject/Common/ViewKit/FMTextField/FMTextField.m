//
//  FMTextField.m
//  ForMan
//
//  Created by chw on 16/6/27.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMTextField.h"

@implementation FMTextField

- (void)setLeftString:(NSString*)string color:(UIColor*)color font:(UIFont*)font width:(NSInteger)width textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, self.bounds.size.height)];
    label.textAlignment = textAlignment;
    label.text = string;
    if (font)
        label.font = font;
    if (color)
        label.textColor = color;
    if (width == 0)
    {
        [label sizeToFit];
    }
    self.leftView = label;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end
