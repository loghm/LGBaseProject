//
//  NSMutableString+FMPublic.h
//  ForMan
//
//  Created by 陈炜来 on 16/6/24.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (FMPublic)
+ (NSMutableAttributedString *)fm_AttrubutedString:(NSString*)string lineSpacing:(CGFloat)lineSpacing characterSpacing:(CGFloat)characterSpacing textColor:(UIColor*)textColor font:(UIFont*)font textAligment:(NSTextAlignment)aligment;
+ (NSMutableAttributedString *)fm_AttrubutedString:(NSString*)string lineSpacing:(CGFloat)lineSpacing characterSpacing:(CGFloat)characterSpacing textColor:(UIColor*)textColor font:(UIFont*)font;
+ (NSMutableAttributedString *)fm_AttrubutedString:(NSString*)string lineSpacing:(CGFloat)lineSpacing characterSpacing:(CGFloat)characterSpacing font:(UIFont*)font;

@end
