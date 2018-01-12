//
//  MMUserManager.h
//  MeiMei
//
//  Created by chw on 15/11/24.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "FMBaseManager.h"
#import "FMUserModel.h"

extern NSString *const FMUserInfoHeadImageURLKey;
extern NSString *const FMUserInfoNickNameKey;
extern NSString *const FMUserInfoSexKey;
extern NSString *const FMUserInfoBirthdayKey;
extern NSString *const FMUserInfoProvinceKey;
extern NSString *const FMUserInfoCityKey;
extern NSString *const FMUserInfoIntroKey;
extern NSString *const FMUserInfoIsMarry;
extern NSString *const FMUserInfoAreaKey;

extern NSString *const FMUserInfoRealName;
extern NSString *const FMUserInfoRealCard;
extern NSString *const FMUserInfoRealTel;
extern NSString *const FMUserInfoRealAddress;


#define FMUserManagerUtil [FMUserManager shareInstance]

@interface FMUserManager : FMBaseManager

@property (nonatomic, strong)  FMUserModel *userModel;

//我的界面底部的广告图
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *href;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSInteger style2;

//1.6新增的客服在线规则
@property (nonatomic, strong) NSArray *weekDays;    //一周有哪几天上班
@property (nonatomic, copy)   NSString *startTime;  //每天的上班时间
@property (nonatomic, copy)   NSString *endTime;    //每天的下班时间

@property (nonatomic, copy) NSString *vipState;

@property (nonatomic, copy) NSString *thirdLoginToken;
+ (FMUserManager *)shareInstance;

/**
 *  获取token
 *
 *  @return NSString* token
 */
+ (NSString*)getToken;

/**
 *  保存token
 *
 *  @param token NSString
 */
+ (void)saveToken:(NSString*)token;

/**
 *  退出登录后删除token
 */
+ (void)removeToken;

/**
 *  判断是否已登录
 */
+ (BOOL)isLogin;

/**
 *  判断token是否是自己
 */
+ (BOOL)checkIsSelf:(NSString*)token;

/**
 *  判断uuid是否是自己
 */
+ (BOOL)checkUuidIsSelf:(NSString*)f_uuid;

///获取验证码
- (void)requestVerificationCodeWithAccout:(NSString*)account type:(BOOL)isLogin complete:(FMBaseManagerBlock)block;

///手机号登录
- (void)loginWithAccount:(NSString*)account verificationCode:(NSString*)code complete:(FMBaseManagerBlock)block;

///退出登录
- (void)logout;

///qq登录
- (void)qqLoginComplete:(FMBaseManagerBlock)block;

///微信登录
- (void)wechatLoginComplete:(FMBaseManagerBlock)block;

///微博登录
- (void)weiboLoginComplete:(FMBaseManagerBlock)block;


///绑定各种号
- (void)bindWithPhone:(NSString*)phone vcode:(NSString*)code complete:(FMBaseManagerBlock)block;
- (void)bindWIthQQComplete:(FMBaseManagerBlock)block;
- (void)bindWithWechatComplete:(FMBaseManagerBlock)block;
- (void)bindWithWeiboComplete:(FMBaseManagerBlock)block;
- (void)getUserBindListComplete:(FMBaseManagerBlock)block;

- (void)getUserInfoComplete:(FMBaseManagerBlock)block;
//获取是否是会员
- (void)getVipState:(FMBaseManagerBlock)block;

- (void)modifyUserInfo:(id)info forKey:(NSString *)key;
- (void)uploadUserHeadComplete :(void(^)(void))complete  failure:(void(^)(NSString *errStr))failure;

- (UIImage*)headCache;
- (void)setUserHeadCache:(UIImage*)image;
- (void)removeUserHeadCache;

///同步用户信息至服务端
- (void)synUserInfoToServer;
- (void)postShareCallBack:(FMBaseManagerBlock)block;

//1.6客服时间
- (NSAttributedString *)getServiceNotice;
- (void)modifyNickName:(NSString*)nickName complete:(FMBaseManagerBlock)block;
- (void)modifycharacter_autograph:(NSString*)character_autograph complete:(FMBaseManagerBlock)block;
- (void)modifyRealInfoWithKey:(NSString*)key andValue:(NSString *)value complete:(FMBaseManagerBlock)block;
//更新余额
- (void)updateBalance:(NSInteger)balance;

- (BOOL)isTodaySign;//今天是签到了
- (void)signAction;//签到

/**
 获取主播分享信息

 @param block 回调
 */
- (void)anchorGetinviteInfo:(FMBaseManagerBlock)block;
@end
