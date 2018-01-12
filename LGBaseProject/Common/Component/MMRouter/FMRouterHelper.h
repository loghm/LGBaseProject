//
//  FMRouterHelper.h
//  MeiMei
//
//  Created by 陈炜来 on 16/2/26.
//  Copyright © 2016年 MeiMei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMRouterHeader.h"



@interface FMRouterHelper : NSObject
/**
 *  路由的时候
 *  通过服务端返回的herfType 和href切割  拼接成URL
 *
 *  @param prefix meimei://sticker
 *  @param herf   @"8"
 *
 *  @return <#return value description#>
 */
//+(NSString *)jumpLinkComponentsWithPrefix:(NSString *)prefix herfString:(NSString *)herf;

/**
 *  路由的网址外链
 *
 *  @param prefix    url
 *  @param herf      参数
 *  @param style2    类型
 *
 *  @return 完整的url
 */
+(NSString *)jumpLinkComponentsWithPrefix:(NSString *)prefix herfString:(NSString *)herf FMStyle2:(FMHomeStyle2)style2;


+(NSString *)jumpLinkComponentsWithModel:(id<FMRouterModelProtocol>)model;


/**
 *  根据路由地址 获取到对应的 图片前缀
 *
 *  @param routerAddress <#routerAddress description#>
 *
 *  @return <#return value description#>
 */
//+(NSString *)getImagePrefixByRouterAddress:(NSString *)routerAddress;


//使用根部root 跳转
+(void)rootJumpVCAction:(NSString *)router;
@end
