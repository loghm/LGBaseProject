//
//  FMStringUtil.h
//  ForMan
//
//  Created by slj on 16/7/2.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMStringUtil : NSObject

/**
 *  传人数组，分解用逗号（，）隔开，返回字符串
 *
 *  @param array NSArray<NSString *>类型的数组
 *
 *  @return 格式化后的字符串
 */
+ (NSString *)bulidStringByArray:(NSArray *)array;



/**
 *  格式化人民币
 *
 *  @param money 人民币
 *
 *  @return 格式化后字符串
 */
+ (NSString *)formatMoneyString:(CGFloat)money;

/**
 *  格式化人民币
 *
 *  @param money      人民币
 *  @param isNegative 是否前面加 -
 *
 *  @return 格式化后字符串
 */
+ (NSString *)formatMoneyString:(CGFloat)money isNegative:(BOOL)isNegative;

/**
 *  格式化人民币 精确到小数点后2为
 *
 *  @param money      人民币
 *  @param isNegative 是否前面加 -
 *
 *  @return 格式化后字符串
 */
+ (NSString *)formatMoneyStringFor2Point:(CGFloat)money isNegative:(BOOL)isNegative;

+ (BOOL)isEmpty:(NSString *)str;
+ (NSString *)trimWhitespace:(NSString *)str ;
+ (BOOL)isStringWithAnyText:(id)object;

@end
