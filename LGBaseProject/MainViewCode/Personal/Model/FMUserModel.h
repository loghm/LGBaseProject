//
//  FMUserModel.h
//  MeiMei
//
//  Created by chw on 15/11/24.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MMLoginType) {
    FMLoginTypeNone     =   -1,     //未登录
    FMLoginTypeWeiBo    =   0,      //微博登录
    FMLoginTypeQQ,                  //QQ登录
    FMLoginTypeWeChat,              //微信登录
    FMLoginTypeAliPay,              //支付宝登录
    FMLoginTypeMobile,              //手机号登录
};

typedef NS_ENUM(NSInteger, MMGender) {
    FMGenderMale  = 0,              //男
    FMGenderFemale,                 //女
    FMGenderUndefine,               //人妖
};

typedef NS_ENUM(NSInteger, FMMarryState) {
    FMMarryStateNo  = 0,            //未婚
    FMMarryStateHad,                //已婚
    FMMarryStateUnknown,            //未知
};

@class FMInviteRewardModel;

@interface FMUserModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *account;            //账号=手机号
@property (nonatomic, assign) NSInteger loginType;          //登录类型MMLoginType
@property (nonatomic, copy) NSString *nickName;           //昵称
@property (nonatomic, copy) NSString *headImageURL;       //头像url
@property (nonatomic, assign) NSInteger sex;                //性别
@property (nonatomic, copy) NSString *birthday;           //生日
@property (nonatomic, copy) NSString *province;           //省份
@property (nonatomic, copy) NSNumber *provinceId;           //省份id
@property (nonatomic, copy) NSString *city;               //城市
@property (nonatomic, copy) NSNumber *cityId;               //城市id

@property (nonatomic, copy) NSString *introduction;       //简介
@property (nonatomic, assign) NSInteger isMarry;            //婚姻状况MMMarryState
@property (nonatomic, assign) BOOL needSynToServer;         //数据是否需要同步至服务端
@property (nonatomic, assign) BOOL isnew;                   //1为老用户0为新用户
@property (nonatomic, assign) BOOL is_anchor;         //是否是主播 1是 0否
@property (nonatomic, copy) NSString *f_uuid;           //直播平台id


//绑定的账号
@property (nonatomic, copy) NSString *bindedMobile;
@property (nonatomic, copy) NSString *bindedQQ;
@property (nonatomic, copy) NSString *bindedWechat;
@property (nonatomic, copy) NSString *bindedWeibo;
@property (nonatomic, copy) NSString *bindedAlipay;


@property (nonatomic, copy) NSString *serviceAccout;           //客服账号
@property (nonatomic, copy) NSString *servicePassword;         //客服密码

@property (nonatomic, assign) NSInteger balance_virtual;    //余额
@property (nonatomic, assign) NSInteger attention_count;    ///关注数
@property (nonatomic, assign) NSInteger follower_count;    //粉丝数
@property (nonatomic, assign) NSInteger level;    //等级数
@property (nonatomic, copy) NSString *total_anchor_time;    //我的直播 时长
@property (nonatomic, assign) NSInteger total_anchor_virtual;    //魅力值
@property (nonatomic, copy  ) NSString *character_autograph;    //动态

@property (nonatomic, copy) NSString *signTime;//签到日期
@property (nonatomic, copy  ) NSString *area;    //地区
@property (nonatomic, assign) BOOL is_check;     //第三方登录和手机登录接口也会返回今天是否签到
@property (nonatomic, copy) NSDate *checkDay;

@property (nonatomic, strong  ) FMInviteRewardModel *inviteReward;
@property (nonatomic, copy) NSString *welfare;//粉丝福利

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy  ) NSString *card;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy  ) NSString *address;

//1.1邀请好友新增
@property (nonatomic, copy) NSString *inviteTitle;
@property (nonatomic, copy) NSString *inviteSubTitle;
@property (nonatomic, copy) NSString *inviteURL;

@property (nonatomic, assign) BOOL isInfoCompleted;     

- (NSString*)loginTypeString;

- (BOOL)getTodayIsCheck;

//- (void)resetModelData;
@end

@interface FMInviteRewardModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *anchor_nickname;           //主播昵称
@property (nonatomic, copy) NSString *anchor_head;//主播头像
@property (nonatomic, copy) NSString *anchor_f_uuid;//主播房间号
@property (nonatomic, assign) NSInteger reward_count;    //奖励钻石数

@end



//"invite_reward": {
//    "anchor_nickname": "123",//主播昵称
//    "anchor_head": "1.png",//主播头像
//    "anchor_f_uuid": 42345679,//主播房间号
//    "reward_count": 39//奖励钻石数
//}

