//
//  NSString+MMPublic.h
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FMPublic)

/**
 *  @brief 判断字符串为 nil or @"" or null or (null) or <null>
 */
+(BOOL)fm_isEmptyString:(NSString *)string;

/**
 *  @brief 获取去除空格后的字符串
 */
-(NSString*)fm_trimString;

/**
 *  @brief 判断字符串非 nil or @"" or null or (null) or <null>
 */
-(BOOL)fm_isNotEmptyString;

/**
 *  @brief 只判断字符串非 nil or @""
 */
-(BOOL)fm_isNotBlankString;


///**
// *  @brief 从第三方绑定的字符串获取到昵称
// *
// *  @return 昵称
// */
//- (NSString*)fm_thirdBindNickname;
//
///**
// *  @brief 从第三方绑定的字符串获取到uid
// *
// *  @return uid
// */
//- (NSString*)fm_thirdBindOpenID;


/**
 *  @brief 是否为Int字符串
 */
- (BOOL)fm_isPureInt;

/**
 *  @brief params 支持 NSString Format  或者 NSDictionary
 *  不过滤重复的key 如果是mutableString 来调用 返回的还是 mutableString 自己
 *  如果要过滤重复的请使用 -(NSString*)imy_appendingURLParamsFilterRepeat:(id)params, ...;
 */
-(NSString*)fm_appendingURLParams:(id)params, ...;

/**
 *  @brief 添加的时候过滤重复的 params
 params 支持 NSString Format  或者 NSDictionary
 */
-(NSString*)fm_appendingURLParamsFilterRepeat:(id)params, ...;

/**
 *  NSInteger转NSString
 *
 *  @param integer NSInteger
 *
 *  @return NSString
 */
+ (NSString*)stringWithInteger:(NSInteger)integer;

/**
 等级格式

 @param integer integer description
 @return return value description
 */
+ (NSString *)stringWithLevel:(NSInteger)integer;

/**
 钻石格式
 
 @param integer integer description
 @return return value description
 */
+ (NSString *)stringWithDiamonds:(NSInteger)integer;

/**
 钻石格式
 显示钻石余额，
 0≤X<10000，显示具体数值
 10000≤X<1亿，显示1.2w
 X≥1亿，显示1.2亿
 @param integer integer description
 @return return value description
 */
+ (NSString *)stringWithDiamonds:(NSInteger)integer andUnit:(NSString *)unitString;

/**
 *  把string数组转成string，参数必须正确
 *
 *  @param array     string数组
 *  @param separator 分隔字符
 *
 *  @return string
 */
+ (NSString*)stringFromArray:(NSArray*)array withSeparatorString:(NSString*)separator;


- (NSString*)subStringWithLength:(NSInteger)length tail:(BOOL)tail;

//本身json字符串转车object
- (id)objectFromJSONString;

@end

UIKIT_EXTERN NSString* NSStringFromNSIndexPath(NSIndexPath* indexPath);

