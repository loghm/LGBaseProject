//
//  NSString+MMPublic.m
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "NSString+FMPublic.h"
#import "NSString+FM_URL.h"
@implementation NSString (MMPublic)

+ (BOOL)fm_isEmptyString:(NSString*)string
{
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if (string.length == 0) {
        return YES;
    }
    NSString* trimString = string.fm_trimString;
    if (trimString.length == 0) {
        return YES;
    }
    NSString* lowercaseString = trimString.lowercaseString;
    if ([lowercaseString isEqualToString:@"(null)"] || [lowercaseString isEqualToString:@"null"] || [lowercaseString isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

- (NSString*)fm_trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)fm_isNotEmptyString
{
    return ![NSString fm_isEmptyString:(id)self];
}

- (BOOL)fm_isNotBlankString
{
    if ([self isKindOfClass:[NSString class]]) {
        NSString* string = (id)self;
        if (string.length == 0) {
            return NO;
        }
        if (string.fm_trimString.length == 0) {
            return NO;
        }
        return YES;
    }
    return NO;
}

- (NSString*)fm_thirdBindNickname
{
    NSArray *array = [self componentsSeparatedByString:@"|"];
    if (array.count == 2)
        return [array lastObject];
    else
        return @"";
}

- (NSString*)fm_thirdBindOpenID
{
    NSArray *array = [self componentsSeparatedByString:@"|"];
    if (array.count == 2)
        return [array firstObject];
    else
        return @"";
}

- (BOOL)fm_isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString*)fm_appendingURLParams:(id)params, ...
{
    NSString* urlParamsString = nil;
    if ([params isKindOfClass:[NSDictionary class]]) {
        NSMutableString* mutableString = [NSMutableString string];
        [(NSDictionary*)params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
            
            if ([key isKindOfClass:[NSString class]] == NO) {
                key = [key description];
            }
            if ([obj isKindOfClass:[NSString class]] == NO) {
                obj = [obj description];
            }
            
            if (mutableString.length > 0) {
                [mutableString appendString:@"&"];
            }
            [mutableString appendFormat:@"%@=%@", key, [obj fm_URLEncodedString]];
        }];
        urlParamsString = mutableString;
    }
    else if ([params isKindOfClass:[NSString class]]) {
        va_list list;
        va_start(list, params);
        urlParamsString = [[NSString alloc] initWithFormat:params arguments:list];
        va_end(list);
    }
    
    if (urlParamsString.length == 0) {
        return self;
    }
    
    if ([urlParamsString hasPrefix:@"&"]) {
        urlParamsString = [urlParamsString substringFromIndex:1];
    }
    
    NSString* resultURLString = nil;
    if ([self containsString:@"?"]) {
        if ([self hasSuffix:@"&"] == NO) {
            resultURLString = [self stringByAppendingFormat:@"&%@", urlParamsString];
        }
        else {
            resultURLString = [self stringByAppendingString:urlParamsString];
        }
    }
    else {
        resultURLString = [self stringByAppendingFormat:@"?%@", urlParamsString];
    }
    return resultURLString;
}
- (NSString*)fm_appendingURLParamsFilterRepeat:(id)params, ...
{
    NSDictionary* parmasDicionary = nil;
    
    if ([params isKindOfClass:[NSString class]]) {
        va_list list;
        va_start(list, params);
        NSString* urlParamsString = [[NSString alloc] initWithFormat:params arguments:list];
        va_end(list);
        
        parmasDicionary = [urlParamsString fm_queryDictionary];
    }
    else if ([params isKindOfClass:[NSDictionary class]]) {
        parmasDicionary = params;
    }
    
    if ([self containsString:@"?"] && parmasDicionary.count > 0) {
        NSMutableDictionary* mutableParams = [NSMutableDictionary dictionaryWithDictionary:parmasDicionary];
        
        NSString* queryString = [[[self componentsSeparatedByString:@"?"] lastObject] lowercaseString];
        NSArray* allKeys = parmasDicionary.allKeys;
        
        for (NSString* key in allKeys) {
            NSString* keyStr = [NSString stringWithFormat:@"%@=", key.lowercaseString];
            NSString* urlKey = [NSString stringWithFormat:@"&%@", keyStr];
            if ([queryString containsString:urlKey] || [queryString hasPrefix:keyStr]) {
                [mutableParams removeObjectForKey:key];
            }
        }
        parmasDicionary = [mutableParams copy];
    }
    if (parmasDicionary.count > 0) {
        return [self fm_appendingURLParams:parmasDicionary];
    }
    return self;
}
-(NSDictionary *)fm_queryDictionary
{
    NSArray* array = [self componentsSeparatedByString:@"?"];
    NSString* encodedString = array.lastObject;
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *pairs = [encodedString componentsSeparatedByString:@"&"];
    
    for (NSString *kvp in pairs) {
        if ([kvp length] == 0) {
            continue;
        }
        
        NSRange pos = [kvp rangeOfString:@"="];
        NSString *key;
        NSString *val;
        
        if (pos.location == NSNotFound) {
            key = [self fm_stringByUnescapingFromURLQuery:kvp];
            val = @"";
        } else {
            key = [self fm_stringByUnescapingFromURLQuery:[kvp substringToIndex:pos.location]];
            val = [self fm_stringByUnescapingFromURLQuery:[kvp substringFromIndex:pos.location + pos.length]];
        }
        
        if (!key || !val) {
            continue; // I'm sure this will bite my arse one day
        }
        
        [result setObject:val forKey:key];
    }
    return result;
}

- (NSString *)fm_stringByUnescapingFromURLQuery:(NSString*)string
{
    NSString *deplussed = [string stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [deplussed stringByRemovingPercentEncoding];
}

+ (NSString *)stringWithInteger:(NSInteger)integer
{
    return [NSNumber numberWithInteger:integer].stringValue;
}

+ (NSString *)stringWithLevel:(NSInteger)integer
{
    return [NSString stringWithFormat:@"LV.%ld",integer] ;
}

/**
 钻石格式
 显示钻石余额，
 0≤X<10000，显示具体数值
 10000≤X<1亿，显示1.2w
 X≥1亿，显示1.2亿
 @param integer integer description
 @return return value description
 */
+ (NSString *)stringWithDiamonds:(NSInteger)integer
{
    if (integer < 10000) {
        return [NSString stringWithInteger:integer];
    }
    else if (integer >=10000 && integer <100000000){
        return [NSString stringWithFormat:@"%0.1fw",integer/10000.0];
    }
    else{
        return [NSString stringWithFormat:@"%0.1f亿",integer/100000000.0];
    }
}

/**
 钻石格式
 显示钻石余额，
 0≤X<10000，显示具体数值
 10000≤X<1亿，显示1.2w
 X≥1亿，显示1.2亿
 @param integer integer description
 @return return value description
 */
+ (NSString *)stringWithDiamonds:(NSInteger)integer andUnit:(NSString *)unitString
{
    NSString *string = [NSString stringWithDiamonds:integer];
    return [[NSString stringWithDiamonds:integer] stringByAppendingString:unitString];
}
/**
 *  把string数组转成string，参数必须正确
 *
 *  @param array     string数组
 *  @param separator 分隔字符
 *
 *  @return string
 */
+ (NSString*)stringFromArray:(NSArray*)array withSeparatorString:(NSString*)separator
{
    if (!array || array.count < 1)
        return @"";
    NSString *string = @"";
    
    for (NSInteger i = 0; i < array.count; i++)
    {
        NSString *str = [array objectAtIndex:i];
        string = [string stringByAppendingString:str];
        if (i != array.count-1)
        {
            string = [string stringByAppendingString:separator];
        }
    }
    
    return string;
}

- (NSString*)subStringWithLength:(NSInteger)length tail:(BOOL)tail
{
    if (self.length <= length)
        return self;
    NSString *string = [self substringToIndex:length];
    if (tail)
    {
        string = [string stringByAppendingString:@"…"];
    }
    return string;
}

- (id)objectFromJSONString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    return result;
}

@end

NSString* NSStringFromNSIndexPath(NSIndexPath* indexPath)
{
    NSString *string = [NSString stringWithFormat:@"section = %ld, row = %ld", indexPath.section, indexPath.row];
    return string;
}
