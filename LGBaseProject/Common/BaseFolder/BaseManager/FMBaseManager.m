//
//  FMBaseManager.m
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMBaseManager.h"
#import "LGNetWorkAction.h"
#import "UIAlertView+FMPublic.h"
#import "YYCache+FMPublic.h"
#import "FMUserManager.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

dispatch_queue_t FMNetWork_operation_completion_queue() {
    static dispatch_queue_t FMGlobal_operation_completion_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FMGlobal_operation_completion_queue = dispatch_queue_create("com.FMBaseManager.operation.queue", DISPATCH_QUEUE_CONCURRENT );
    });
    return FMGlobal_operation_completion_queue;
}

// debug下打印请求信息
void printResponse(NSString *format, ...) {
#ifdef DEBUG
    va_list argptr;
    va_start(argptr, format);
    NSLogv(format, argptr);
    va_end(argptr);
#endif
}


@implementation FMBaseManager

///get操作，block在主线程执行
-(NSURLSessionDataTask*)Get:(BOOL) bNeedLogin
 URLString:(NSString *)URLString
parameters:(NSDictionary *)parameters
     block:(FMBaseManagerBlock)block
{
    return [self Get:bNeedLogin URLString:URLString parameters:parameters cache:nil block:block];
}

-(NSURLSessionDataTask*)Get:(BOOL) bNeedLogin
 URLString:(NSString *)URLString
parameters:(NSDictionary *)parameters
isUserCache:(BOOL)isUserCache
     cache:(FMBaseManagerBlock)cacheBlock
     block:(FMBaseManagerBlock)block
{
    if (!isUserCache) {
        cacheBlock =  nil;
    }
    return [self Get:bNeedLogin URLString:URLString parameters:parameters cache:cacheBlock block:block];
}

-(NSURLSessionDataTask*)Get:(BOOL) bNeedLogin
 URLString:(NSString *)URLString
parameters:(NSDictionary *)parameters
     cache:(FMBaseManagerBlock)cacheBlock
     block:(FMBaseManagerBlock)block
{
//    printResponse(@"HttpRequest:\n[\n  Type:%@\n  Url:%@\n  params:%@\n]",@"Get",URLString,parameters);
    NSLog(@"%@",parameters);
    if ([self isNeedLogin:bNeedLogin block:block]) {
        return nil;
    }
    [self getCacheDataWithUrl:URLString parameters:parameters cache:cacheBlock];
    
    __weak typeof(self) weakSelf                    = self;
    return [[LGNetWorkAction shareInstance] doGetURL:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        printResponse(@"HttpResponse:\n[\n  Type:%@\n  Url:%@\n params:%@\n response:%@\n]",@"Get",URLString,parameters,responseObject);
        [weakSelf responseResultWithObject:responseObject Url:URLString parameters:parameters cache:cacheBlock block:block];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block)
        {
#ifdef DEBUG
            [UIAlertView fm_quickErrorAlert:error isShowWhileRelease:NO];
#endif
            if (error.code==-1009) {
//                [UIView fm_showTextHUD:@"哦啊~手机网络不太顺畅哦"];
            }
            else
            {
//                [UIView fm_showTextHUD:@"哦啊~手机网络不太顺畅哦"];
            }
            
            block(FMBaseManagerReturnInfoNetworkError, [error localizedDescription]);
        }
    }];
    
}


///get操作，block在其他线程执行
-(NSURLSessionDataTask*)GetAsync:(BOOL) bNeedLogin
      URLString:(NSString *)URLString
     parameters:(NSDictionary *)parameters
          block:(FMBaseManagerBlock)block
{
    return [self GetAsync:bNeedLogin URLString:URLString parameters:parameters cache:nil block:block];
}

-(NSURLSessionDataTask*)GetAsync:(BOOL) bNeedLogin
      URLString:(NSString *)URLString
     parameters:(NSDictionary *)parameters
          cache:(FMBaseManagerBlock)cacheBlock
          block:(FMBaseManagerBlock)block
{
    if ([self isNeedLogin:bNeedLogin block:block]) {
        return nil;
    }
    [self getCacheDataWithUrl:URLString parameters:parameters cache:cacheBlock];
    
    FM_WEAKSELF
    return [[LGNetWorkAction shareInstance] doGetURL:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_async(FMNetWork_operation_completion_queue(), ^{
            [weakSelf responseResultWithObject:responseObject Url:URLString parameters:parameters cache:cacheBlock block:block];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block)
        {
#ifdef DEBUG
            [UIAlertView fm_quickErrorAlert:error isShowWhileRelease:NO];
#else
            [UIView fm_showTextHUD:@"哦啊~手机网络不太顺畅哦"];
#endif
            block(FMBaseManagerReturnInfoNetworkError, [error localizedDescription]);
        }
    }];
}

///post操作，block在主线程执行
-(NSURLSessionDataTask*)Post:(BOOL) bNeedLogin
  URLString:(NSString *)URLString
 parameters:(NSDictionary *)parameters
      block:(FMBaseManagerBlock)block
{
    return [self Post:bNeedLogin URLString:URLString parameters:parameters cache:nil block:block];
}
-(NSURLSessionDataTask*)Post:(BOOL) bNeedLogin
  URLString:(NSString *)URLString
 parameters:(NSDictionary *)parameters
      cache:(FMBaseManagerBlock)cacheBlock
      block:(FMBaseManagerBlock)block
{
    if ([self isNeedLogin:bNeedLogin block:block]) {
        return nil;
    }
    
    [self getCacheDataWithUrl:URLString parameters:parameters cache:cacheBlock];
    
    FM_WEAKSELF
    return [[LGNetWorkAction shareInstance] doPostURL:URLString
                                              parameters:parameters
                                                 success:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf responseResultWithObject:responseObject Url:URLString parameters:parameters cache:cacheBlock block:block];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block)
        {
#ifdef DEBUG
            [UIAlertView fm_quickErrorAlert:error isShowWhileRelease:NO];
#endif
            if (error.code==-1009) {
//                [UIView fm_showTextHUD:@"操作失败！请检查网络连接后再次操作！"];
            }
            else
            {
//                [UIView fm_showTextHUD:@"哦啊~手机网络不太顺畅哦"];
//                [UIAlertView fm_quickAlert:error.localizedDescription];
            }
            block(FMBaseManagerReturnInfoNetworkError, [error localizedDescription]);
        }
    }];
}
///post操作，block在主线程执行
-(NSURLSessionDataTask*)PostAysnc:(BOOL) bNeedLogin
       URLString:(NSString *)URLString
      parameters:(NSDictionary *)parameters
           block:(FMBaseManagerBlock)block
{
    return [self PostAysnc:bNeedLogin URLString:URLString parameters:parameters cache:nil block:block];
}

-(NSURLSessionDataTask*)PostAysnc:(BOOL) bNeedLogin
       URLString:(NSString *)URLString
      parameters:(NSDictionary *)parameters
           cache:(FMBaseManagerBlock)cacheBlock
           block:(FMBaseManagerBlock)block
{
    if ([self isNeedLogin:bNeedLogin block:block]) {
        return nil;
    }
    
    [self getCacheDataWithUrl:URLString parameters:parameters cache:cacheBlock];
    
    FM_WEAKSELF
    return [[LGNetWorkAction shareInstance] doPostURL:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_async(FMNetWork_operation_completion_queue(), ^{
            [weakSelf responseResultWithObject:responseObject Url:URLString parameters:parameters cache:cacheBlock block:block];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block)
        {
#ifdef DEBUG
            [UIAlertView fm_quickErrorAlert:error isShowWhileRelease:NO];
#else
            [UIView fm_showTextHUD:@"哦啊~手机网络不太顺畅哦"];
#endif
            block(FMBaseManagerReturnInfoNetworkError, [error localizedDescription]);
        }
    }];
}

#pragma mark - private

- (BOOL)isNeedLogin:(BOOL)isNeedLogin block:(FMBaseManagerBlock)block
{
    if (isNeedLogin)
    {
        if ([FMUserManager getToken] == nil)
        {
            block(FMBaseManagerReturnInfoNeedLogin, @"请登录");
//            FM_POST_NOTIFY(FMUserNeedLoginNotification);
            return YES;
        }
    }
    return NO;
}

- (void)getCacheDataWithUrl:(NSString *)URLString
                 parameters:(NSDictionary *)parameters
                      cache:(FMBaseManagerBlock)cacheBlock
{
    if (cacheBlock && [self needCacheWithPara:parameters])
    {
        NSString *cacheKey=  [self compoentCacheKeyWithBaseUrl:URLString params:parameters];
        FM_WEAKSELF
        [[YYCache sharedCache] objectForKey:cacheKey withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
            if (object) {
                FMRunInMainQueue(^{
                    cacheBlock(FMBaseManagerReturnInfoSuccess, object);
                     weakSelf.isHasContent=YES;
                });
            }
        }];
    }

}

- (void)responseResultWithObject:(id)responseObject
                             Url:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                           cache:(FMBaseManagerBlock)cacheBlock
                           block:(FMBaseManagerBlock)block
{
    NSDictionary *dic = (NSDictionary*)responseObject;
    NSInteger sign = [[dic objectForKey:@"sign"] intValue];
    if (sign == 1) //1为成功
    {
        NSDictionary *data = [dic objectForKey:@"d"];

         self.isHasContent=YES;
        //使用url当cache的key 进行缓存
        if (cacheBlock && [self needCacheWithPara:parameters])
        {
            NSString *cacheKey=  [self compoentCacheKeyWithBaseUrl:URLString params:parameters];
            [[YYCache sharedCache] setObject:data forKey:cacheKey];
        }
        if (block)
            block(FMBaseManagerReturnInfoSuccess, data);
    }
    else if (sign == 30004)
    {
        if (block)
        {
            NSString *msg = [[dic objectForKey:@"d"] objectForKey:@"msg"];
            block(FMBaseManagerReturnNoStock, msg);
        }
    }
    else if (sign == 30005)
    {
        if (block)
        {
            NSString *msg = [[dic objectForKey:@"d"] objectForKey:@"msg"];
            block(FMBaseManagerReturnNotEnoughKey, msg);
        }
    }
    else if (sign == 30006)
    {
        if (block)
        {
            NSString *msg = [[dic objectForKey:@"d"] objectForKey:@"msg"];
            block(FMBaseManagerReturnUserInfoMiss, msg);
        }
    }
    else if (sign == 20013) {
        //你不是会员
        if (block)
        {
            NSString *msg = [[dic objectForKey:@"d"] objectForKey:@"msg"];
            block(FMBaseManagerReturnUserNeedVip, msg);
        }
    }
    else if (sign == 20014) {
        //余额不足
        if (block)
        {
            NSString *msg = [[dic objectForKey:@"d"] objectForKey:@"msg"];
            block(FMBaseManagerReturnUserNeedRecharge, msg);
        }
    }
    else
    {
        NSString *msg = [[dic objectForKey:@"d"] objectForKey:@"msg"];
        if (block)
            block(FMBaseManagerReturnInfoFailure, msg);
    }

}

-(NSString *)compoentCacheKeyWithBaseUrl:(NSString *)url params:(NSDictionary *)parameters
{
    
    NSDictionary *paramDict=parameters;
    //如果添加了公用参数，url中已经自动添加了公用参数，这里不需要在进行拼接打印
    NSString *className=NSStringFromClass(self.class);
    NSString *outPutUrl=[NSString stringWithFormat:@"forMan://%@",className];
    
    NSArray *urlArray=url.pathComponents;
    for (int i=0; i<url.pathComponents.count; i++) {
        if (i==0||i==1) {//http://vmeimei.user.meimeizhengxing.com/
            continue;//i==0 http:    i==1 vmeimei.user.meimeizhengxing.com
        }
        NSString *newPath=urlArray[i];
        outPutUrl=[NSString stringWithFormat:@"%@\%@",outPutUrl,newPath];
    }
    
    if([outPutUrl rangeOfString:@"?"].location ==NSNotFound)
    {//不带公共参数添加 ?     ?xx=xx&yy=yy&
        outPutUrl=[outPutUrl stringByAppendingString:@"?"];
    }
    else//如果带了公共参数添加&
    {
        outPutUrl=[outPutUrl stringByAppendingString:@"&"];
    }
    NSArray *allKeys = [paramDict allKeys];//对参赛进行了排序，保证顺序，链接的一致性
    allKeys = [allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    for (NSString *key in allKeys) {
        //    for (NSString *key in paramDict.keyEnumerator) {
        NSString *keyValue= [NSString stringWithFormat:@"%@=%@&",key,[paramDict objectForKey:key]];
        outPutUrl= [outPutUrl stringByAppendingString:keyValue];
    }
    outPutUrl=[outPutUrl substringToIndex:outPutUrl.length-1];
    //    NSString * encodingString = [outPutUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSLog(@"%@",encodingString);
    return outPutUrl;

//    return nil;
}

- (BOOL)needCacheWithPara:(NSDictionary*)dic
{
    if ([dic objectForKey:@"p"] && [[dic objectForKey:@"p"] integerValue]!=0)
        return NO;
    return YES;
}



@end
#pragma clang diagnostic pop
