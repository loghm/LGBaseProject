//
//  FMBaseManager.h
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGServiceURL.h"
#import "UIAlertView+FMPublic.h"
typedef NS_ENUM(NSInteger, FMBaseManagerReturnInfoStatus)
{
    FMBaseManagerReturnInfoFailure      = 0,// 服务端逻辑错误
    FMBaseManagerReturnInfoSuccess,
    FMBaseManagerReturnInfoNotice,
    FMBaseManagerReturnInfoNeedLogin,       //需要重新登录
    FMBaseManagerReturnInfoPhoneISUsed,     //手机号已被注册
    FMBaseManagerReturnInfoEqulaOldData,    //获取成功，但是和旧数据一致，无修改
    FMBaseManagerReturnInfoNetworkError,    //网络异常
    FMBaseManagerReturnInfoNoNet,           //未连接网络
    FMBaseManagerReturnInfoUndefine,        //未知结果
    FMBaseManagerReturnNoStock,             //没有库存了
    FMBaseManagerReturnNotEnoughKey,        //钥匙不够
    FMBaseManagerReturnUserInfoMiss,        //个人资料不全
    FMBaseManagerReturnUserNeedVip,        //需要开通会员权限
    FMBaseManagerReturnUserNeedRecharge         //需要充值钻石
};

typedef void (^FMBaseManagerBlock)(FMBaseManagerReturnInfoStatus status ,id blockInfo);

@interface FMBaseManager : NSObject

//bNeedLogin是否需要登录，如果是需要登录，当前未登录则自动跳转登录界面
///get操作，block在主线程执行
-(NSURLSessionDataTask*)Get:(BOOL) bNeedLogin
 URLString:(NSString *)URLString
parameters:(NSDictionary *)parameters
     block:(FMBaseManagerBlock)block;

//是否使用缓存
-(NSURLSessionDataTask*)Get:(BOOL) bNeedLogin
 URLString:(NSString *)URLString
parameters:(NSDictionary *)parameters
isUserCache:(BOOL)isUserCache
     cache:(FMBaseManagerBlock)cacheBlock
     block:(FMBaseManagerBlock)block;

-(NSURLSessionDataTask*)Get:(BOOL) bNeedLogin
 URLString:(NSString *)URLString
parameters:(NSDictionary *)parameters
     cache:(FMBaseManagerBlock)cacheBlock
     block:(FMBaseManagerBlock)block;


///get操作，block在其他线程执行
-(NSURLSessionDataTask*)GetAsync:(BOOL) bNeedLogin
      URLString:(NSString *)URLString
     parameters:(NSDictionary *)parameters
          block:(FMBaseManagerBlock)block;
-(NSURLSessionDataTask*)GetAsync:(BOOL) bNeedLogin
      URLString:(NSString *)URLString
     parameters:(NSDictionary *)parameters
          cache:(FMBaseManagerBlock)cacheBlock
          block:(FMBaseManagerBlock)block;
///post操作，block在主线程执行
-(NSURLSessionDataTask*)Post:(BOOL) bNeedLogin
  URLString:(NSString *)URLString
 parameters:(NSDictionary *)parameters
      block:(FMBaseManagerBlock)block;
-(NSURLSessionDataTask*)Post:(BOOL) bNeedLogin
  URLString:(NSString *)URLString
 parameters:(NSDictionary *)parameters
      cache:(FMBaseManagerBlock)cacheBlock
      block:(FMBaseManagerBlock)block;

///post操作，block在主线程执行
-(NSURLSessionDataTask*)PostAysnc:(BOOL) bNeedLogin
       URLString:(NSString *)URLString
      parameters:(NSDictionary *)parameters
           block:(FMBaseManagerBlock)block;
-(NSURLSessionDataTask*)PostAysnc:(BOOL) bNeedLogin
       URLString:(NSString *)URLString
      parameters:(NSDictionary *)parameters
           cache:(FMBaseManagerBlock)cacheBlock
           block:(FMBaseManagerBlock)block;
//获取失败，判断接口之前是否存在数据
@property(nonatomic,assign)BOOL isHasContent;


- (void)responseResultWithObject:(id)responseObject
                             Url:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           cache:(FMBaseManagerBlock)cacheBlock
                           block:(FMBaseManagerBlock)block;


-(NSString *)compoentCacheKeyWithBaseUrl:(NSString *)url params:(NSDictionary *)parameters;
@end
