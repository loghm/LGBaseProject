//
//  NSString+FMSpliceURL.h
//  ForMan
//
//  Created by chw on 16/6/29.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FMSpliceURL)

///主要用于图片url拼接，本身是图片前缀
- (NSString*)fmSpliceURL:(NSString*)url;

///用于图片url数组拼接，本身是图片前缀
- (NSArray*)translateForURLArray:(NSString*)images;

/**
 *  把string数组转成string，参数必须正确
 *
 *  @param array     string数组
 *  @param separator 分隔字符
 *
 *  @return string
 */
+ (NSString*)stringFromArray:(NSArray*)array withSeparatorString:(NSString*)separator;

///解析图片url可能带参数了
- (NSDictionary *)fm_parseAsQueryString;

///从图片url中获取图片大小，如果没有则返回CGSizeZero
- (CGSize)fm_getSize;

/**
 *  删除字符串的前缀(用于添加到购物车时删除图片url前缀的)
 *
 *  @param string 要删除的
 *
 *  @return 处理结果
 */
- (NSString*)removePrefixString:(NSString*)string;

- (NSString*)fm_thirdBindOpenID;
- (NSString*)fm_thirdBindNickname;
@end
