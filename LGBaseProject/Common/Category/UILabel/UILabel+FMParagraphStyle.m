//
//  UILabel+FMParagraphStyle.m
//  ForMan
//
//  Created by chw on 16/6/21.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "UILabel+FMParagraphStyle.h"
#import "NSMutableAttributedString+FMPublic.h"
@implementation UILabel (FMParagraphStyle)

- (void)fmSetText:(NSString *)string withCharacterSpacing:(CGFloat)characterSpacing
{
   
    [self fmSetText:string withLineSpacing:0 withCharacterSpacing:characterSpacing withTextColor:self.textColor withFont:self.font];
}

- (void)fmSetText:(NSString *)string withLineSpacing:(CGFloat)lineSpacing withCharacterSpacing:(CGFloat)characterSpacing
{
    [self fmSetText:string withLineSpacing:lineSpacing withCharacterSpacing:characterSpacing withTextColor:self.textColor withFont:self.font];
}

- (void)fmSetText:(NSString*)string withLineSpacing:(CGFloat)lineSpacing withCharacterSpacing:(CGFloat)characterSpacing withTextColor:(UIColor*)textColor withFont:(UIFont*)font
{
    [self fmSetText:string withLineSpacing:lineSpacing withCharacterSpacing:characterSpacing withTextColor:textColor withFont:font textAligment:NSTextAlignmentLeft];
}
- (void)fmSetText:(NSString*)string withLineSpacing:(CGFloat)lineSpacing withCharacterSpacing:(CGFloat)characterSpacing withTextColor:(UIColor*)textColor withFont:(UIFont*)font textAligment:(NSTextAlignment)aligment
{
    if (!string || string.length < 1)
        return;
    if (textColor)
        self.textColor = textColor;
    if (self.font)
        self.font = font;
    NSMutableAttributedString *attributedString = [NSMutableAttributedString fm_AttrubutedString:string lineSpacing:lineSpacing characterSpacing:characterSpacing textColor:textColor font:font textAligment:aligment];
    self.attributedText = attributedString;

}
@end
