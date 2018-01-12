//
//  LGNetWorkAction.h
//  LGBaseProject
//
//  Created by loghm on 2017/12/14.
//  Copyright © 2017年 loghm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LGRequestSuccess)(id requestTask, id responseObject);
typedef void(^LGRequestFailure)(id requestTask,  NSError *error);

@interface LGNetWorkAction : NSObject

+ (LGNetWorkAction *)shareInstance;


/**
 *  设置登录后的token
 *
 *  设置成功YES，失败NO
 */
- (void)loadToken;

/**
 *  去掉登录后的token，退出登录用
 */
- (void)removeToken;

/**
 *  设置临时token，临时token永远都带
 */
- (void)loadTempToken:(NSString*)token;


-(NSURLSessionDataTask*)doGetURL:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(LGRequestSuccess)success
                         failure:(LGRequestFailure)failure;

-(NSURLSessionDataTask*)doPostURL:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(LGRequestSuccess)success
                          failure:(LGRequestFailure)failure;

-(void)doDeleteData:(NSString *)URLString
         parameters:(NSDictionary *)parameters
            success:(LGRequestSuccess)success
            failure:(LGRequestFailure)failure;

-(void)doPut:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(LGRequestSuccess)success
     failure:(LGRequestFailure)failure;



@end
