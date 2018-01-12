//
//  NSString+FMSpliceURL.m
//  ForMan
//
//  Created by chw on 16/6/29.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "NSString+FMSpliceURL.h"

@implementation NSString (FMSpliceURL)

//主要用于图片url拼接，本身是图片前缀
- (NSString*)fmSpliceURL:(NSString *)url
{
    
    if (!url || url.length < 1)
        return self;
//    if ([url containsString:@"http"]) {
//        return url;
//    }
//修改2017/05/31  后台数据返回问题 删除
    if ([url containsString:@"http://oi64tg8v4.bkt.clouddn.com"]) {
        url = [url stringByReplacingOccurrencesOfString:@"http://oi64tg8v4.bkt.clouddn.com" withString:@""];
//        return url;
    }else if([url containsString:@"http"])
    {
        return url;
    }
    
    NSString *compent=[NSString stringWithFormat:@"%@",self];
    NSLog(@"%@",compent);
//    NSRange range= [url rangeOfString:@"?"];
//    if (range.location !=NSNotFound) {
//        url=[url substringToIndex:range.location];
//    }

    if ([self hasSuffix:@"/"])
    {
        compent= [compent stringByAppendingString:url];
    }
    else
    {
        compent=  [NSString stringWithFormat:@"%@/%@", compent, url];
    }
    return compent;
}
//提取   s = 640x426;
//       t = jpg;
- (NSDictionary *)fm_parseAsQueryString
{
    NSRange range= [self rangeOfString:@"?"];
    NSString *param = nil;
    if (range.location !=NSNotFound) {
        param = [self substringFromIndex:range.location+1];
    }
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [result setObject:[self substringToIndex:range.location] forKey:@"url"];
    if (param.length) {
        
        NSString *pattern = @"([^=]+)=(.*?)&";
        NSRegularExpression *expression = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                               options:kNilOptions
                                                                                 error:nil];
        NSString *query = [param stringByAppendingString:@"&"];
        NSArray *matches = [expression matchesInString:query
                                               options:NSMatchingReportCompletion
                                                 range:NSMakeRange(0, [query length])];
        [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL *stop) {
            if ([obj numberOfRanges] >= 3) {
                [result setObject:([param substringWithRange:[obj rangeAtIndex:2]])
                           forKey:([param substringWithRange:[obj rangeAtIndex:1]])];
            }
        }];
    }
    return result;
}

- (CGSize)fm_getSize
{
    NSDictionary *dic = [self fm_parseAsQueryString];
    if ([dic objectForKey:@"s"])
    {
        NSString *string = [dic objectForKey:@"s"];
        if (string && string.length > 0)
        {
            NSRange range= [string rangeOfString:@"*"];
            if (range.location != NSNotFound)
            {
                NSString *width = [string substringToIndex:range.location];
                NSString *height = [string substringFromIndex:range.location+1];
                return CGSizeMake([width floatValue], [height floatValue]);
            }
        }
    }
    return CGSizeZero;
}

//用于图片url数组拼接，本身是图片前缀
- (NSArray*)translateForURLArray:(NSString*)images
{
    NSArray *array = [images componentsSeparatedByString:@","];
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:0];
    for (NSString *string in array)
    {
        NSString *url = [self fmSpliceURL:string];
        if (url)
            [ret addObject:url];
    }
    return ret;
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

/**
 *  删除字符串的前缀(用于添加到购物车时删除图片url前缀的)
 *
 *  @param string 要删除的
 *
 *  @return
 */
- (NSString*)removePrefixString:(NSString*)string
{
    NSRange range = [self rangeOfString:string];
    if (range.location == NSNotFound)
        return self;
    return [self substringFromIndex:(range.location+range.length)];
}

- (NSString*)fm_thirdBindOpenID
{
    NSArray *array = [self componentsSeparatedByString:@"|"];
    if (array.count == 2)
        return [array firstObject];
    else
        return @"";
}

- (NSString*)fm_thirdBindNickname
{
    NSArray *array = [self componentsSeparatedByString:@"|"];
    if (array.count == 2)
        return [array lastObject];
    else
        return @"";
}

@end
