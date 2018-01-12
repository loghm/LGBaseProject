//
//  LGNetWorkAction.m
//  LGBaseProject
//
//  Created by loghm on 2017/12/14.
//  Copyright © 2017年 loghm. All rights reserved.
//

#import "LGNetWorkAction.h"
#import "FMUserManager.h"
#import "AppDelegate.h"

@interface LGNetWorkAction()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, assign) BOOL bHasSetToken;

@property (nonatomic, strong) AFSecurityPolicy *imSecurityPolicy;
@property (nonatomic, strong) AFSecurityPolicy *indexSecurityPolicy;
@property (nonatomic, strong) AFSecurityPolicy *orderSecurityPolicy;
@property (nonatomic, strong) AFSecurityPolicy *userSecurityPolicy;


@end

@implementation LGNetWorkAction

+(LGNetWorkAction *)shareInstance {
    static LGNetWorkAction *instance = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        instance = [[LGNetWorkAction alloc] init];
    });
    return instance;
}

-(instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        [self setSerializer];
    }
    return self;
}

-(void)setSerializer {
    AFHTTPSessionManager *manager=(AFHTTPSessionManager*)self.manager;
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.timeoutInterval = 30;
    [manager setRequestSerializer:requestSerializer];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.removesKeysWithNullValues = YES;
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject: @"text/plain"];
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    
    [manager setResponseSerializer:responseSerializer];
    self.bHasSetToken = NO;
    
//    [requestSerializer setValue:[FMToolsFunction fmHttpHeadDefaultString] forHTTPHeaderField:@"h"];
    
    
    __weak AFHTTPSessionManager *weakManager = manager;
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential *__autoreleasing  _Nullable * _Nullable credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        /*
         * 获取原始域名信息。
         */
        NSString* host = [weakManager.requestSerializer valueForHTTPHeaderField:@"host"];
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            if ([self evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:host]) {
                disposition = NSURLSessionAuthChallengeUseCredential;
                *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            } else {
                disposition = NSURLSessionAuthChallengePerformDefaultHandling;
            }
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
        return disposition;
    }];
    
    [self loadToken];
    [self loadTempToken:nil];
}

- (void)loadToken
{
    NSString *string = [FMUserManager getToken];
    NSLog(@"用户token：%@", string);
    if (string)
    {
        
        AFHTTPSessionManager *manager=(AFHTTPSessionManager*)self.manager;
        [manager.requestSerializer setValue:string forHTTPHeaderField:@"t"];
        
        
        self.bHasSetToken = YES;
    }
}

- (void)removeToken
{
    
    AFHTTPSessionManager *manager=(AFHTTPSessionManager*)self.manager;
    [manager.requestSerializer setValue:nil forHTTPHeaderField:@"t"];
    
    
    self.bHasSetToken = NO;
}

/**
 *  设置临时token，临时token永远都带
 */
- (void)loadTempToken:(NSString*)token
{
    NSString *string = nil;
    if (!token)
    {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [userDefaults objectForKey:@"key_global_config_model"];
        
        if (data)
        {
//            FMGlobalConfigModel *globalConfig = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            string = globalConfig.tempToken;
        }
    }
    else
    {
        string = token;
    }
    if (string)
    {
        NSLog(@"临时token:%@", string);
        
        AFHTTPSessionManager *manager=(AFHTTPSessionManager*)self.manager;
        [manager.requestSerializer setValue:string forHTTPHeaderField:@"t1"];
        
    }
}

//设置当前是哪个界面请求的
- (void)loadController
{
    //    UINavigationController *nav = (UINavigationController*)[self.rootViewController selectedViewController];
    //    if (![nav isKindOfClass:[UINavigationController class]])
    //        return;
    //    UIViewController *topViewController = [nav topViewController];
    //    UIViewController *controller = nil;
    //    if (topViewController.presentedViewController)
    //    {
    //        controller = topViewController;
    //    }
    //    else
    //    {
    //        if (nav.viewControllers.count > 1)
    //            controller = [nav.viewControllers objectAtIndex:nav.viewControllers.count-2];
    //    }
    //
    //    AFHTTPSessionManager *manager=(AFHTTPSessionManager*)self.manager;
    //    [manager.requestSerializer setValue:NSStringFromClass([controller class]) forHTTPHeaderField:@"view"];
    
}

-(NSURLSessionDataTask*)doGetURL:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(LGRequestSuccess)success
                         failure:(LGRequestFailure)failure
{
    [self loadController];
    
    
    AFHTTPSessionManager *manager=(AFHTTPSessionManager*)self.manager;
    // 加上这行代码，https ssl 验证。
    //    if(openHttpsSSL)
    //    {
    //        [manager setSecurityPolicy:[self indexSecurityPolicy]];
    //    }
    //    [manager setSecurityPolicy:[self userSecurityPolicy]];
//    NSString *host = [FMGetAllDomainIP getRealHostFromURL:URLString];
//    NSLog(@"host   %@  ====",host);
//    [manager.requestSerializer setValue:host forHTTPHeaderField:@"host"];
    NSLog(@"%@  ====",manager);
    return [manager GET:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failure(task, error);
    }];
}

-(NSURLSessionDataTask*)doPostURL:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(LGRequestSuccess)success
                          failure:(LGRequestFailure)failure
{
    [self loadController];
    
    AFHTTPSessionManager *manager=(AFHTTPSessionManager*)self.manager;
//    NSString *host = [FMGetAllDomainIP getRealHostFromURL:URLString];
//    [manager.requestSerializer setValue:host forHTTPHeaderField:@"host"];
    // 加上这行代码，https ssl 验证。
    //    if(openHttpsSSL)
    //    {
    //        [manager setSecurityPolicy:[self customSecurityPolicy]];
    //    }
    //    [manager.securityPolicy setValidatesDomainName:NO];
    
    return [manager POST:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failure(task, error);
    }];
    
}




-(void)doDeleteData:(NSString *)URLString
         parameters:(NSDictionary *)parameters
            success:(LGRequestSuccess)success
            failure:(LGRequestFailure)failure
{
    [self loadController];
    
    AFHTTPSessionManager *manager=(AFHTTPSessionManager*)self.manager;
    [manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failure(task, error);
    }];
    
    
    
}

-(void)doPut:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(LGRequestSuccess)success
     failure:(LGRequestFailure)failure
{
    [self loadController];
    
    AFHTTPSessionManager *manager=(AFHTTPSessionManager*)self.manager;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failure(task, error);
    }];
    
}


- (AFSecurityPolicy *)userSecurityPolicy
{
    if (!_userSecurityPolicy) {
//        [self customSecurityPolicy:kUserCertificate];
    }
    return _userSecurityPolicy;
}

- (AFSecurityPolicy *)imSecurityPolicy
{
    if (!_imSecurityPolicy) {
//        [self customSecurityPolicy:kIMCertificate];
    }
    return _imSecurityPolicy;
}
- (AFSecurityPolicy *)orderSecurityPolicy
{
    if (!_orderSecurityPolicy) {
//        [self customSecurityPolicy:kOrderCertificate];
    }
    return _orderSecurityPolicy;
}

- (AFSecurityPolicy *)indexSecurityPolicy
{
    if (!_indexSecurityPolicy) {
//        [self customSecurityPolicy:kIndexCertificate];
    }
    return _indexSecurityPolicy;
}


- (AFSecurityPolicy*)customSecurityPolicy:(NSString *)certificateName
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificateName ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = @[certData];
    
    
    return securityPolicy;
}

- (BOOL)evaluateServerTrust:(SecTrustRef)serverTrust
                  forDomain:(NSString *)domain
{
    /*
     * 创建证书校验策略
     */
    NSMutableArray *policies = [NSMutableArray array];
    if (domain) {
        [policies addObject:(__bridge_transfer id)SecPolicyCreateSSL(true, (__bridge CFStringRef)domain)];
    } else {
        [policies addObject:(__bridge_transfer id)SecPolicyCreateBasicX509()];
    }
    /*
     * 绑定校验策略到服务端的证书上
     */
    SecTrustSetPolicies(serverTrust, (__bridge CFArrayRef)policies);
    /*
     * 评估当前serverTrust是否可信任，
     * 官方建议在result = kSecTrustResultUnspecified 或 kSecTrustResultProceed
     * 的情况下serverTrust可以被验证通过，https://developer.apple.com/library/ios/technotes/tn2232/_index.html
     * 关于SecTrustResultType的详细信息请参考SecTrust.h
     */
    SecTrustResultType result;
    SecTrustEvaluate(serverTrust, &result);
    return (result == kSecTrustResultUnspecified || result == kSecTrustResultProceed);
}


@end
