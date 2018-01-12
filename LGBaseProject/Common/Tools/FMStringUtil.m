//
//  FMStringUtil.m
//  ForMan
//
//  Created by slj on 16/7/2.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMStringUtil.h"

@implementation FMStringUtil


/**
 *  传人数组，分解用逗号（，）隔开，返回字符串
 *
 *  @param array NSArray<NSString *>类型的数组
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)bulidStringByArray:(NSArray *)array;
{
    NSMutableString *idString = [NSMutableString string];
    for (int i = 0; i < array.count; i++) {
        [idString appendString:[NSString stringWithFormat:@"%@",array[i]]];
        if (i < (array.count -1)) {
            [idString appendString:@","];
        }
    }
    return idString;
}




/**
 *  格式化人民币
 *
 *  @param money 人民币
 *
 *  @return 格式化后字符串
 */
+ (NSString *)formatMoneyString:(CGFloat)money
{
    return [[self class] formatMoneyString:money isNegative:NO];
}

/**
 *  格式化人民币
 *
 *  @param money      人民币
 *  @param isNegative 是否前面加 -
 *
 *  @return 格式化后字符串
 */
+ (NSString *)formatMoneyString:(CGFloat)money isNegative:(BOOL)isNegative
{
    NSString *string = [NSString stringWithFormat:@"￥%0.0f",money];
    if (isNegative && money > 0) {
        string = [NSString stringWithFormat:@"-￥%0.0f",money];
    }
    
    return string;
}

/**
 *  格式化人民币 精确到小数点后2为
 *
 *  @param money      人民币
 *  @param isNegative 是否前面加 -
 *
 *  @return 格式化后字符串
 */
+ (NSString *)formatMoneyStringFor2Point:(CGFloat)money isNegative:(BOOL)isNegative
{
    NSString *string = [NSString stringWithFormat:@"￥%0.2f",money];
    if (isNegative && money > 0) {
        string = [NSString stringWithFormat:@"-￥%0.2f",money];
    }
    
    return string;
}

+ (BOOL)isEmpty:(NSString *)str {
    NSString *trim = [FMStringUtil trimWhitespace:str];
    return ![FMStringUtil isStringWithAnyText:trim];
}
+ (NSString *)trimWhitespace:(NSString *)str {
    if (str != nil && (NSNull *) str != [NSNull null] && [str isKindOfClass:[NSString class]]) {
        return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    return nil;
}
+ (BOOL)isStringWithAnyText:(id)object {
    return [object isKindOfClass:[NSString class]] && [(NSString *) object length] > 0;
}

@end
