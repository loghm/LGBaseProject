//
//  FMUserManager.m
//  MeiMei
//
//  Created by chw on 15/11/24.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "FMUserManager.h"
#import "LGNetWorkAction.h"
//#import "FMQQSdkManager.h"
//#import "FMWeiboSdkManager.h"
//#import "FMWeChatSdkManager.h"
//#import "FMQiNiuUploadManager.h"
//#import "NSDate+FM_DateFormat.h"
//#import "FMShareInfoModel.h"

NSString *const KEY_USER_MODEL = @"key_user_model";

NSString *const FMUserInfoHeadImageURLKey   = @"head";
NSString *const FMUserInfoNickNameKey       = @"nickname";
NSString *const FMUserInfoSexKey            = @"sex";
NSString *const FMUserInfoBirthdayKey       = @"birthday";
NSString *const FMUserInfoProvinceKey       = @"province";
NSString *const FMUserInfoCityKey           = @"city";
NSString *const FMUserInfoIntroKey          = @"synopsis";
NSString *const FMUserInfoIsMarry           = @"ismarry";
NSString *const FMUserInfoAreaKey           = @"area";
NSString *const FMUserInfoCharacter         = @"character_autograph";

NSString *const FMUserInfoRealName          = @"name";
NSString *const FMUserInfoRealCard          = @"card";
NSString *const FMUserInfoRealTel           = @"tel";
NSString *const FMUserInfoRealAddress       = @"address";

@interface FMUserManager ()
{
    NSString *servicer_time;
}
@property (nonatomic, assign) BOOL bHasGetDiary;
@property (nonatomic, assign) BOOL bHasGetInvitation;

@end

@implementation FMUserManager
+ (FMUserManager *)shareInstance
{
    static FMUserManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FMUserManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *userData = [userDefaults objectForKey:KEY_USER_MODEL];
        if (userData)
        {
            self.userModel = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        }
        if (self.userModel == nil)
            self.userModel = [[FMUserModel alloc] init];
    }
    return self;
}

- (void)saveUserInfo
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.userModel];
    
    [userDefaults setObject:data forKey:KEY_USER_MODEL];
    
    [userDefaults synchronize];
}

/**
 *  获取token
 *
 *  @return NSString* token
 */
+ (NSString*)getToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [userDefaults objectForKey:@"fm_user_token"];
//    str = @"23832cecd0b0ffe7433289f585bbe31cc98d";
    return str;
}
/**
 *  保存token
 *
 *  @param token NSString
 */
+ (void)saveToken:(NSString*)token
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"fm_user_token"];
    [userDefaults synchronize];
}

/**
 *  退出登录后删除token
 */
+ (void)removeToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"fm_user_token"];
    [userDefaults synchronize];
}

/**
 *  判断是否已登录
 */
+ (BOOL)isLogin
{
    return ([[self class] getToken]!=nil);
}

/**
 *  判断token是否是自己
 */
+ (BOOL)checkIsSelf:(NSString*)token
{
    if ([[self class] getToken]!=nil && token != nil)
    {
        return [[[self class] getToken] isEqualToString:token];
    }
    return NO;
}

/**
 *  判断uuid是否是自己
 */
+ (BOOL)checkUuidIsSelf:(NSString*)f_uuid
{
    if (!FMUserManagerUtil.userModel.f_uuid || !f_uuid)
        return NO;
    return [FMUserManagerUtil.userModel.f_uuid isEqualToString:f_uuid];
}

- (void)requestVerificationCodeWithAccout:(NSString*)account type:(BOOL)isLogin complete:(FMBaseManagerBlock)block
{
//    [super Get:NO URLString:FM_URL_USER_GET_VALID_CODE parameters:@{@"phone":account, @"ltype":[NSNumber numberWithBool:isLogin]} block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            NSLog(@"%@", blockInfo);
//        }
//        block(status, blockInfo);
//    }];
}

- (void)loginWithAccount:(NSString*)account verificationCode:(NSString*)code complete:(FMBaseManagerBlock)block
{
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
//    [dic setValue:account forKey:@"phone"];
//    [dic setValue:code forKey:@"validate"];
//    if (FMGlobalConfigModelInstance.deviceToken)
//        [dic setValue:FMGlobalConfigModelInstance.deviceToken forKey:@"udid"];
//    [super Post:NO URLString:FM_URL_USER_MOBILE_LOGIN parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            [self logout];
//            NSLog(@"%@", blockInfo);
//            self.userModel.account = account;
//            self.userModel.bindedMobile = account;
//            [self getUserModelFromJson:blockInfo];
//            self.userModel.loginType = FMLoginTypeMobile;
//
//            [self saveUserInfo];
//            [self getUserBindListComplete:nil];
//        }
//        block(status, blockInfo);
//    }];
}

///退出登录
- (void)logout
{
    //清除用户数据
    [self removeUserHeadCache];
    self.userModel = [[FMUserModel alloc] init];
//    [self.userModel resetModelData];

    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:KEY_USER_MODEL];
    [userDefaults synchronize];
    
    //清除登录后的token
    [[self class] removeToken];
    [[LGNetWorkAction shareInstance] removeToken];


    FM_POST_NOTIFY(FMUserLogoutNotification);
}

#pragma mark - 第三方登录
/**
 *  qq登录
 *
 *  @param block 完成回调
 */
- (void)qqLoginComplete:(FMBaseManagerBlock)block
{
//    [[FMQQSdkManager createInstance] qqLoginComplete:^(BOOL successed, id object) {
//        if (successed)
//        {
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:object];
//            __block NSString *nickName = [dic objectForKey:@"nickname"];
//            __block NSString *openID = [dic objectForKey:@"openid"];
//            [dic removeObjectForKey:@"nickname"];
//            [dic setObject:[NSNumber numberWithInteger:FMLoginTypeQQ] forKey:@"ltype"];
//            if (FMGlobalConfigModelInstance.deviceToken)
//                [dic setValue:FMGlobalConfigModelInstance.deviceToken forKey:@"udid"];
//            [super Post:NO URLString:FM_URL_USER_THIRD_LOGIN parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                [UIView fm_hideHUD];
//                if (status == FMBaseManagerReturnInfoSuccess)
//                {
//                    NSLog(@"%@",blockInfo);
//                    [self logout];
//                    self.userModel.bindedQQ = [NSString stringWithFormat:@"%@|%@", openID, nickName];
//                    self.userModel.account = self.userModel.bindedQQ;
//                    [self getUserModelFromJson:blockInfo];
//                    self.userModel.loginType = FMLoginTypeQQ;
//                    [self saveUserInfo];
//                    [self getUserBindListComplete:nil];
//                    if ([blockInfo objectForKey:@"first_login"]) {
//                        if ([[blockInfo objectForKey:@"first_login"] boolValue]) {
//                            [[self class] removeToken];
//                            FM_POST_NOTIFY(FMPersonalNeedUpdateUserInfoNotification);
//                        }
//                    }
//                }
//                block(status, blockInfo);
//            }];
//        }
//        else
//        {
//            block(successed, object);
//        }
//        [FMQQSdkManager releaseInstance];
//    }];
}

/**
 *  微信登录
 *
 *  @param block 完成回调
 */
- (void)wechatLoginComplete:(FMBaseManagerBlock)block
{
//    [[FMWeChatSdkManager createInstance] wechatLoginComplete:^(BOOL successed, id object) {
//        if (successed)
//        {
//            NSLog(@"%@    %d",object,successed);
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:object];
//            __block NSString *nickName = [dic objectForKey:@"nickname"];
//            __block NSString *openID = [dic objectForKey:@"openid"];
//            [dic removeObjectForKey:@"nickname"];
//            [dic setObject:[NSNumber numberWithInteger:FMLoginTypeWeChat] forKey:@"ltype"];
//            if (FMGlobalConfigModelInstance.deviceToken)
//                [dic setValue:FMGlobalConfigModelInstance.deviceToken forKey:@"udid"];
//            [super Post:NO URLString:FM_URL_USER_THIRD_LOGIN parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                if (status == FMBaseManagerReturnInfoSuccess)
//                {
//                    [self logout];
//                    self.userModel.bindedWechat = [NSString stringWithFormat:@"%@|%@", openID, nickName];
//                    self.userModel.account = self.userModel.bindedWechat;
//                    [self getUserModelFromJson:blockInfo];
//                    self.userModel.loginType = FMLoginTypeWeChat;
//                    [self saveUserInfo];
//                    [self getUserBindListComplete:nil];
//                    if ([blockInfo objectForKey:@"first_login"]) {
//                        if ([[blockInfo objectForKey:@"first_login"] boolValue]) {
//                            [[self class] removeToken];
//                            FM_POST_NOTIFY(FMPersonalNeedUpdateUserInfoNotification);
//                        }
//                    }
//                }
//                block(status, blockInfo);
//            }];
//        }
//        else
//        {
//            block(successed, object);
//        }
//        [FMWeChatSdkManager releaseInstance];
//    }];
}

/**
 *  微博登录
 *
 *  @param block 完成回调
 */
- (void)weiboLoginComplete:(FMBaseManagerBlock)block
{
//    [[FMWeiboSdkManager createInstance] weiboLoginComplete:^(BOOL successed, id object) {
//        if (successed)
//        {
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:object];
//            __block NSString *nickName = [dic objectForKey:@"nickname"];
//            __block NSString *openID = [dic objectForKey:@"openid"];
//            [dic removeObjectForKey:@"nickname"];
//            [dic setObject:[NSNumber numberWithInteger:FMLoginTypeWeiBo] forKey:@"ltype"];
//            if (FMGlobalConfigModelInstance.deviceToken)
//                [dic setValue:FMGlobalConfigModelInstance.deviceToken forKey:@"udid"];
//            [super Post:NO URLString:FM_URL_USER_THIRD_LOGIN parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                [UIView fm_hideHUD];
//                if (status == FMBaseManagerReturnInfoSuccess)
//                {
//                    [self logout];
//                    self.userModel.bindedWeibo = [NSString stringWithFormat:@"%@|%@", openID, nickName];
//                    self.userModel.account = self.userModel.bindedWeibo;
//                    [self getUserModelFromJson:blockInfo];
//                    self.userModel.loginType = FMLoginTypeWeiBo;
//                    [self saveUserInfo];
//                    [self getUserBindListComplete:nil];
//                    if ([blockInfo objectForKey:@"first_login"]) {
//                        if ([[blockInfo objectForKey:@"first_login"] boolValue]) {
//                            [[self class] removeToken];
//                            FM_POST_NOTIFY(FMPersonalNeedUpdateUserInfoNotification);
//                        }
//                    }
//                }
//                block(status, blockInfo);
//            }];
//        }
//        else
//        {
//            block(successed, object);
//        }
//        [FMWeiboSdkManager releaseInstance];
//    }];
}

/**
 *  获取我的页面数据
 *
 *  @param block 回调
 */
- (void)getUserInfoComplete:(FMBaseManagerBlock)block
{
//    [super Get:YES URLString:FM_URL_USER_GET_USER_INFO parameters:nil block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            [self getUserModelFromJson:blockInfo];
////            if ([blockInfo objectForKey:@"recommend"])
////            {
////                NSDictionary *dic = [blockInfo objectForKey:@"recommend"];
////                if (![self.pic isEqualToString:[dic objectForKey:@"pic"]])
////                {
////                    self.pic = [dic objectForKey:@"pic"];
////                }
////                self.href = [dic objectForKey:@"href"];
////                self.style2 = [[dic objectForKey:@"style2"] integerValue];
////                self.url = [dic objectForKey:@"url"];
////            }
//            [self saveUserInfo];
//        }
//        block(status, blockInfo);
//    }];
}



#pragma mark - 绑定账号
- (void)getUserBindListComplete:(FMBaseManagerBlock)block
{
//    [super Get:YES URLString:FM_URL_USER_GET_BIND_LIST parameters:nil block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            self.userModel.bindedMobile = [blockInfo objectForKey:@"4"];
//            self.userModel.bindedWeibo = [blockInfo objectForKey:@"0"];
//            self.userModel.bindedQQ = [blockInfo objectForKey:@"1"];
//            self.userModel.bindedWechat = [blockInfo objectForKey:@"2"];
//            self.userModel.bindedAlipay = [blockInfo objectForKey:@"3"];
//            [self saveUserInfo];
//        }
//        if (block)
//        {
//            block(status, nil);
//        }
//    }];
}

- (void)bindWithPhone:(NSString*)phone vcode:(NSString*)code complete:(FMBaseManagerBlock)block
{
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:phone, @"bind", code, @"validate", [NSNumber numberWithInt:FMLoginTypeMobile], @"ltype", nil];
//    [super Post:YES URLString:FM_URL_USER_BIND parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            self.userModel.bindedMobile = phone;
//            [self saveUserInfo];
//            [self getUserInfoComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                FM_POST_NOTIFY(FMPersonalNeedRefreshNotification);
//            }];
//            if (block)
//            {
//                block(status, blockInfo);
//            }
//        }
//        else
//        {
//            if (block)
//            {
//                block(status, blockInfo);
//            }
//        }
//    }];
}

- (void)bindWIthQQComplete:(FMBaseManagerBlock)block
{
//    [[FMQQSdkManager createInstance] qqLoginComplete:^(BOOL successed, id object) {
//        if (successed)
//        {
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:object];
//            __block NSString *nickName = [dic objectForKey:@"nickname"];
//            __block NSString *openID = [dic objectForKey:@"openid"];
//            [dic removeObjectForKey:@"nickname"];
//            [dic removeObjectForKey:@"openid"];
//            [dic setObject:openID forKey:@"bind"];
//            [dic setObject:[NSNumber numberWithInteger:FMLoginTypeQQ] forKey:@"ltype"];
//            [super Post:NO URLString:FM_URL_USER_BIND parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                if (status == FMBaseManagerReturnInfoSuccess)
//                {
//                    self.userModel.bindedQQ = [NSString stringWithFormat:@"%@|%@", openID, nickName];
//                    [self saveUserInfo];
//                }
//                block(status, blockInfo);
//            }];
//        }
//        else
//        {
//            block(FMBaseManagerReturnInfoFailure, object);
//        }
//    }];
}

- (void)bindWithWechatComplete:(FMBaseManagerBlock)block
{
//    [[FMWeChatSdkManager createInstance] wechatLoginComplete:^(BOOL successed, id object) {
//        if (successed)
//        {
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:object];
//            __block NSString *nickName = [dic objectForKey:@"nickname"];
//            __block NSString *openID = [dic objectForKey:@"openid"];
//            [dic removeObjectForKey:@"nickname"];
//            [dic removeObjectForKey:@"openid"];
//            [dic setObject:openID forKey:@"bind"];
//            [dic setObject:[NSNumber numberWithInteger:FMLoginTypeWeChat] forKey:@"ltype"];
//            [super Post:NO URLString:FM_URL_USER_BIND parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                if (status == FMBaseManagerReturnInfoSuccess)
//                {
//                    self.userModel.bindedWechat = [NSString stringWithFormat:@"%@|%@", openID, nickName];
//                    [self saveUserInfo];
//                }
//                block(status, blockInfo);
//            }];
//        }
//        else
//        {
//            block(FMBaseManagerReturnInfoFailure, object);
//        }
//    }];
}

- (void)bindWithWeiboComplete:(FMBaseManagerBlock)block
{
//    [[FMWeiboSdkManager createInstance] weiboLoginComplete:^(BOOL successed, id object) {
//        if (successed)
//        {
//            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:object];
//            __block NSString *nickName = [dic objectForKey:@"nickname"];
//            __block NSString *openID = [dic objectForKey:@"openid"];
//            [dic removeObjectForKey:@"nickname"];
//            [dic removeObjectForKey:@"openid"];
//            [dic setObject:openID forKey:@"bind"];
//            [dic setObject:[NSNumber numberWithInteger:FMLoginTypeWeiBo] forKey:@"ltype"];
//            [super Post:NO URLString:FM_URL_USER_BIND parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                if (status == FMBaseManagerReturnInfoSuccess)
//                {
//                    self.userModel.bindedWeibo = [NSString stringWithFormat:@"%@|%@", openID, nickName];
//                    [self saveUserInfo];
//                }
//                block(status, blockInfo);
//            }];
//        }
//        else
//        {
//            block(successed, object);
//        }
//    }];
}

/**
 *  从json中读取数据
 *
 *  @param json json数据
 */
- (void)getUserModelFromJson:(id)json
{
    NSLog(@"%@",json);

    if ([json objectForKey:@"t"])
    {
        self.thirdLoginToken = [json objectForKey:@"t"];
        [[self class] saveToken:self.thirdLoginToken];
        //登录后设置token
        [[LGNetWorkAction shareInstance] loadToken];
    }
    if ([json objectForKey:@"userinfo"])
    {
        NSDictionary *userInfo = [json objectForKey:@"userinfo"];
        if ([userInfo objectForKey:@"head"])
        {
            if (![self.userModel.headImageURL isEqualToString:[userInfo objectForKey:@"head"]])
            {
                self.userModel.headImageURL = [userInfo objectForKey:@"head"];
                [self removeUserHeadCache];
            }
        }
        else
        {
            self.userModel.headImageURL = nil;
            [self removeUserHeadCache];
        }
        self.userModel.nickName = [[userInfo objectForKey:@"nickname"] stringValue];
        self.userModel.sex = [[userInfo objectForKey:@"sex"] integerValue];
        if ([[[userInfo objectForKey:@"birthday"] stringValue] isEqualToString:@"0"]){
            self.userModel.birthday = nil;
        }
        else{self.userModel.birthday = [[userInfo objectForKey:@"birthday"] stringValue];}
        self.userModel.province = [userInfo objectForKey:@"province"];
        self.userModel.city = [userInfo objectForKey:@"city"];
        self.userModel.introduction = [userInfo objectForKey:@"synopsis"];
        self.userModel.serviceAccout = [userInfo objectForKey:@"imuserid"];
        self.userModel.servicePassword = [userInfo objectForKey:@"impassword"];
        self.userModel.isMarry=[[userInfo objectForKey:@"ismarry"]boolValue ];
        if ([userInfo objectForKey:@"isnew"])
            self.userModel.isnew =[[userInfo objectForKey:@"isnew"]boolValue ];
        if ([userInfo objectForKey:@"is_anchor"])
            self.userModel.is_anchor =[[userInfo objectForKey:@"is_anchor"] boolValue ];
        
        self.userModel.balance_virtual = [[userInfo objectForKey:@"balance_virtual"] integerValue];;    //余额
        self.userModel.level = [[userInfo objectForKey:@"level"] integerValue];;
        self.userModel.f_uuid = [userInfo objectForKey:@"f_uuid"];;
        self.userModel.area = [userInfo objectForKey:@"area"];
        self.userModel.character_autograph = [userInfo objectForKey:@"character_autograph"];



    }

    self.userModel.attention_count = [[json objectForKey:@"attention_count"] integerValue];;    ///关注数
    self.userModel.follower_count = [[json objectForKey:@"follower_count"] integerValue];;    //粉丝数
    self.userModel.total_anchor_time = [json objectForKey:@"total_anchor_time"];//我的直播时间
    self.userModel.total_anchor_virtual = [[json objectForKey:@"total_anchor_virtual"] integerValue];//我的魅力值
    self.userModel.total_anchor_time = [json objectForKey:@"total_anchor_time"];//我的直播时间
    if ([json objectForKey:@"is_check"]) {
        self.userModel.is_check = [[json objectForKey:@"is_check"] boolValue];;
    }
    
    if ([json objectForKey:@"invitefriend"])
    {
        NSDictionary *invite = [json objectForKey:@"invitefriend"];
        self.userModel.inviteTitle = [invite objectForKey:@"title"];
        self.userModel.inviteSubTitle = [invite objectForKey:@"sub_title"];
        self.userModel.inviteURL = [invite objectForKey:@"url"];
    }
    if ([json objectForKey:@"userreal"])
    {
        NSDictionary *invite = [json objectForKey:@"userreal"];
        self.userModel.name = [invite objectForKey:@"name"];
        self.userModel.card = [invite objectForKey:@"card"];
        self.userModel.tel = [invite objectForKey:@"tel"];
        self.userModel.address = [invite objectForKey:@"address"];
    }
    if ([json objectForKey:@"invite_reward"])
    {
        NSDictionary *invite = [json objectForKey:@"invite_reward"];
        self.userModel.inviteReward = [FMInviteRewardModel mj_objectWithKeyValues:invite];
    }
    NSLog(@"%@",[json objectForKey:@"profitswitch"]);

    self.userModel.welfare = [json objectForKey:@"welfare"];//粉丝福利

    
    servicer_time = [json objectForKey:@"servicer_time"];
    
    if (!self.userModel.headImageURL || self.userModel.headImageURL.length == 0 ||
        !self.userModel.nickName || self.userModel.nickName.length == 0 ||
        !self.userModel.area || self.userModel.area.length == 0 ||
        !self.userModel.birthday || self.userModel.birthday.length == 0)
    {
        self.userModel.isInfoCompleted = NO;
    }
    else{
        self.userModel.isInfoCompleted = YES;
    }
}

- (void)synUserInfoToServer
{
    [self synUserInfoToServerComplete :^{
        
    } failure:^(NSString *errStr) {
        
    }];
}

- (void)synUserInfoToServerComplete :(void(^)(void))complete  failure:(void(^)(NSString *errStr))failure
{
    if (![[self class] isLogin])
    {
        return;
    }
    FM_WEAKSELF
    [self uploadHeadComplete:^(BOOL boolean){
        if (weakSelf.userModel.needSynToServer)
        {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:weakSelf.userModel.headImageURL,@"head",
                                 weakSelf.userModel.birthday, @"birthday",
                                 weakSelf.userModel.nickName, @"nickname",
                                 [NSNumber numberWithInteger:weakSelf.userModel.sex], @"sex",
                                 weakSelf.userModel.area, @"area",
                                 weakSelf.userModel.character_autograph, @"character_autograph",
                                 nil];
//
//            NSMutableDictionary *parmer = [[NSMutableDictionary alloc] init];
//            [parmer setValue:weakSelf.userModel.headImageURL forKey:@"head"];
//            [parmer setValue:weakSelf.userModel.birthday forKey:@"birthday"];
//            [parmer setValue:weakSelf.userModel.nickName forKey:@"nickname"];
//            [parmer setValue:[NSNumber numberWithInteger:weakSelf.userModel.sex] forKey: @"sex"];

//            [super Post:YES URLString:FM_URL_USER_UPDATE_USER_INFO parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                if (status == FMBaseManagerReturnInfoSuccess)
//                {
//                    weakSelf.userModel.needSynToServer = NO;
//                    [weakSelf saveUserInfo];
//                    [self getUserInfoComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                        FM_POST_NOTIFY(FMPersonalNeedRefreshNotification);
//                    }];
//                    complete ();
//                }
//                else if(status==FMBaseManagerReturnInfoFailure)//服务端逻辑错误
//                {
//                    //                    [UIAlertView mm_quickAlert:blockInfo];
//                    failure(blockInfo);
//                }
//                else//其他一切错误
//                {
//                    failure(@"");
//                }
//            }];
        }
        complete ();
    }];
    
}

- (void)uploadUserHeadComplete :(void(^)(void))complete  failure:(void(^)(NSString *errStr))failure
{
    NSLog(@"是否存在：%d", [[YYImageCache sharedCache] containsImageForKey:self.userModel.account]);
    
    FM_WEAKSELF
    [self uploadHeadComplete:^(BOOL boolean){
        if (boolean)
        {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 weakSelf.userModel.headImageURL,@"head",
                                 weakSelf.userModel.birthday, @"birthday",
                                 weakSelf.userModel.nickName, @"nickname",
                                 [NSNumber numberWithInteger:weakSelf.userModel.sex], @"sex",
                                 weakSelf.userModel.area, @"area",
                                 weakSelf.userModel.character_autograph, @"character_autograph",
                                 nil];
//            [super Post:NO URLString:FM_URL_USER_UPDATE_USER_INFO parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                if (status == FMBaseManagerReturnInfoSuccess)
//                {
//                    if (self.thirdLoginToken) {
//                        [[self class] saveToken:self.thirdLoginToken];
//                    }
//                    weakSelf.userModel.needSynToServer = NO;
//                    [weakSelf saveUserInfo];
//                    [self getUserInfoComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                        FM_POST_NOTIFY(FMPersonalNeedRefreshNotification);
//                    }];
//                    complete ();
//                }
//                else if(status==FMBaseManagerReturnInfoFailure)//服务端逻辑错误
//                {
//                    //                    [UIAlertView mm_quickAlert:blockInfo];
//                    failure(blockInfo);
//                }
//                else//其他一切错误
//                {
//                    failure(blockInfo);
//                }
//            }];
        }
        else{
//            failure(@"头像上传失败，请重试");
        }
    }];
    
}

- (UIImage*)headCache
{
    return [[YYImageCache sharedCache] getImageForKey:self.userModel.account];
}

- (void)setUserHeadCache:(UIImage*)image
{
    [[YYImageCache sharedCache] setImage:image forKey:self.userModel.account];
}

- (void)removeUserHeadCache
{
    [[YYImageCache sharedCache] removeImageForKey:self.userModel.account];
}

//上传头像
- (void)uploadHeadComplete:(FMBOOLBlock)block
{
    if ([[YYImageCache sharedCache] containsImageForKey:self.userModel.account])
    {
        UIImage *image = [[YYImageCache sharedCache] getImageForKey:self.userModel.account];
        FM_WEAKSELF
//        NSString *token = [FMGlobalManager shareInstance].globalConfig.uploadUserHeadToken;
//        [[FMQiNiuUploadManager shareInstance]uploadImage:image  token:token complete:^(NSString *string) {
//            if (string)
//            {
//                [weakSelf modifyUserInfo:string forKey:FMUserInfoHeadImageURLKey];
//                if (block) {
//                    block(YES);
//                }
//            }
//        } failure:^(void){
//            if (block) {
//                block(NO);
//            }
//        } progress:^(NSString *key, float percent) {
//
//        }];
    }
    else
    {
        NSLog(@"没有缓存图片");
        //没有缓存图片
        if (block) {
            block(NO);
        }
    }
}

- (void)modifyUserInfo:(id)info forKey:(NSString *)key
{
    BOOL bChange = NO;
    if ([key isEqualToString:FMUserInfoHeadImageURLKey])
    {
        if (![self.userModel.headImageURL isEqualToString:info])
        {
            bChange = YES;
            self.userModel.headImageURL = info;
        }
    }
    else if ([key isEqualToString:FMUserInfoNickNameKey])
    {
        if (![self.userModel.nickName isEqualToString:info])
        {
            self.userModel.nickName = info;
            bChange = YES;
        }
    }
    else if ([key isEqualToString:FMUserInfoSexKey])
    {
        NSInteger sex = [(NSNumber*)info integerValue];
        if (self.userModel.sex != sex)
        {
            self.userModel.sex = sex;
            bChange = YES;
        }
    }
    else if ([key isEqualToString:FMUserInfoBirthdayKey])
    {
        if (![self.userModel.birthday isEqualToString:info])
        {
            self.userModel.birthday = info;
            bChange = YES;
        }
    }
    else if ([key isEqualToString:FMUserInfoProvinceKey])
    {
        if (![self.userModel.province isEqualToNumber:info])
        {
            self.userModel.province = info;
            bChange = YES;
        }
    }
    else if ([key isEqualToString:FMUserInfoCityKey])
    {
        if (![self.userModel.city isEqualToNumber:info])
        {
            self.userModel.city = info;
            bChange = YES;
        }
    }
    else if ([key isEqualToString:FMUserInfoIntroKey])
    {
        if (![self.userModel.introduction isEqualToString:info])
        {
            self.userModel.introduction = info == nil ? @"" : info;
            bChange = YES;
        }
    }
    else if ([key isEqualToString:FMUserInfoIsMarry])
    {
        if (self.userModel.isMarry != [(NSNumber*)info integerValue])
        {
            self.userModel.isMarry = [(NSNumber*)info integerValue];
            bChange = YES;
        }
    }
    else if ([key isEqualToString:FMUserInfoAreaKey])
    {
        if (![self.userModel.area isEqualToString:info])
        {
            self.userModel.area = info;
            bChange = YES;
        }
    }
    else if ([key isEqualToString:FMUserInfoCharacter])
    {
        if (![self.userModel.character_autograph isEqualToString:info])
        {
            self.userModel.character_autograph = info;
            bChange = YES;
        }
    }
    
    if (bChange)
    {
        self.userModel.needSynToServer = YES;
        [self saveUserInfo];
    }
}

- (void)postShareCallBack:(FMBaseManagerBlock)block {
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:@(0) forKey:@"type"];
    
    [super Post:YES
      URLString:@""
     parameters:params
          block:^(FMBaseManagerReturnInfoStatus status, id blockInfo)
     {
         if (status == FMBaseManagerReturnInfoSuccess)
         {
             block(status, blockInfo);
         }
         else
         {
             block(status, blockInfo);
         }
         
     }];
}

//1.6
- (NSAttributedString *)getServiceNotice
{
    NSString *string = @"搭配客服";
    if (servicer_time)
        string = [string stringByAppendingString:servicer_time];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range1 = [string rangeOfString:@"搭配客服"];
    NSRange range2 = NSMakeRange(range1.length, string.length-4);
    [attr addAttribute:NSForegroundColorAttributeName value:[FMColor fmColor_g1] range:range1];
    [attr addAttribute:NSFontAttributeName value:FMLayoutManagerInstance.fmDefaultFont_13 range:range1];
    [attr addAttribute:NSForegroundColorAttributeName value:[FMColor fmColor_g3] range:range2];
    [attr addAttribute:NSFontAttributeName value:FMLayoutManagerInstance.fmDefaultFont_11 range:range2];
    [attr addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:FMFixWidthFloat(2)-1] range:range1];   //-1是因为系统默认的字间距为0时实际有1的差距
    return attr;
}

- (void)modifyNickName:(NSString*)nickName complete:(FMBaseManagerBlock)block
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:nickName, @"nickname", nil];
    if (self.userModel.needSynToServer) {
        dic = [NSDictionary dictionaryWithObjectsAndKeys:self.userModel.headImageURL,@"head",
                             self.userModel.birthday, @"birthday",
                             nickName, @"nickname",
                             [NSNumber numberWithInteger:self.userModel.sex], @"sex",
                             self.userModel.area, @"area",
                             self.userModel.character_autograph, @"character_autograph",
                             nil];
    }

    FM_WEAKSELF
//    [super Post:NO URLString:FM_URL_USER_UPDATE_USER_INFO parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            if (self.thirdLoginToken) {
//                [[self class] saveToken:self.thirdLoginToken];
//            }
//            weakSelf.userModel.needSynToServer = NO;
//            [weakSelf saveUserInfo];
//            [self getUserInfoComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                FM_POST_NOTIFY(FMPersonalNeedRefreshNotification);
//            }];
//            block(FMBaseManagerReturnInfoSuccess, nil);
//        }
//        else if(status==FMBaseManagerReturnInfoFailure)//服务端逻辑错误
//        {
//            block(FMBaseManagerReturnInfoFailure, blockInfo);
//        }
//        else//其他一切错误
//        {
//            block(status, blockInfo);
//        }
//    }];
}

- (void)modifycharacter_autograph:(NSString*)character_autograph complete:(FMBaseManagerBlock)block
{
   
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:character_autograph, @"character_autograph", nil];
    if (self.userModel.needSynToServer) {
        dic = [NSDictionary dictionaryWithObjectsAndKeys:self.userModel.headImageURL,@"head",
               self.userModel.birthday, @"birthday",
               self.userModel.nickName, @"nickname",
               [NSNumber numberWithInteger:self.userModel.sex], @"sex",
               self.userModel.area, @"area",
               character_autograph, @"character_autograph",
               nil];
    }
    FM_WEAKSELF
//    [super Post:YES URLString:FM_URL_USER_UPDATE_USER_INFO parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            weakSelf.userModel.needSynToServer = NO;
//            [weakSelf saveUserInfo];
//            [self getUserInfoComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                FM_POST_NOTIFY(FMPersonalNeedRefreshNotification);
//            }];
//            block(FMBaseManagerReturnInfoSuccess, nil);
//        }
//        else if(status==FMBaseManagerReturnInfoFailure)//服务端逻辑错误
//        {
//            block(FMBaseManagerReturnInfoFailure, blockInfo);
//        }
//        else//其他一切错误
//        {
//            block(status, blockInfo);
//        }
//    }];
}

- (void)modifyRealInfoWithKey:(NSString*)key andValue:(NSString *)value complete:(FMBaseManagerBlock)block
{
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:value,key,nil];

    FM_WEAKSELF
//    [super Post:YES URLString:FM_URL_USER_REAL_UPDATE_USER_INFO parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            weakSelf.userModel.needSynToServer = NO;
//            [weakSelf saveUserInfo];
//            [self getUserInfoComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//                FM_POST_NOTIFY(FMPersonalNeedRefreshNotification);
//            }];
//            block(FMBaseManagerReturnInfoSuccess, nil);
//        }
//        else if(status==FMBaseManagerReturnInfoFailure)//服务端逻辑错误
//        {
//            block(FMBaseManagerReturnInfoFailure, blockInfo);
//        }
//        else//其他一切错误
//        {
//            block(status, blockInfo);
//        }
//    }];
}


//更新余额
- (void)updateBalance:(NSInteger)balance
{
    FMRunInMainQueue(^{
        self.userModel.balance_virtual = balance;
        [self saveUserInfo];
    });
}

- (BOOL)isTodaySign{
    
    NSString * f_uuid = self.userModel.f_uuid;
    if ([f_uuid isKindOfClass:[NSNumber class]]) {
        f_uuid = [f_uuid stringValue];
    }
    if ([[self class] isLogin] && f_uuid && f_uuid.length > 0) {
        NSString *keyString = [f_uuid stringByAppendingString:@"signKey"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *str = [userDefaults objectForKey:keyString];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:str];
        if ([date isToday]) {
            return YES;
        }
        else{
            return NO;
        }
    }
    else{
        return YES;
    }
  
}
- (void)signAction{
    NSString * f_uuid = self.userModel.f_uuid;
    if ([f_uuid isKindOfClass:[NSNumber class]]) {
        f_uuid = [f_uuid stringValue];
    }
//    if (f_uuid && f_uuid.length > 0) {
////        NSString *time = [[NSDate fm_today] fm_getOnlyDateString];
//        NSString *keyString = [f_uuid stringByAppendingString:@"signKey"];
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:time forKey: keyString];
//        [userDefaults synchronize];
//    }
    
}


@end
