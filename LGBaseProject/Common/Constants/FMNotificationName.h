//
//  FMNotificationName.h
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FM_POST_NOTIFY(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil]
#define FMNotification [NSNotificationCenter defaultCenter]

@interface FMNotificationName : NSObject

extern NSString *const IsEnablePersonalCenterVCMainTableViewScroll;
extern NSString *const CurrentSelectedChildViewControllerIndex;
extern NSString *const PersonalCenterVCBackingStatus;

///用户需要登录通知
extern NSString *const FMUserNeedLoginNotification;

///用户登录通知
extern NSString *const FMUserLoginNotification;

///用户退出通知
extern NSString *const FMUserLogoutNotification;

///用户界面需要刷新的通知
extern NSString *const FMPersonalNeedRefreshNotification;

///需要填写用户信息
extern NSString *const FMPersonalNeedUpdateUserInfoNotification;

///用户界面需要重新请求接口的通知
extern NSString *const FMPersonalNeedRequestNotification;
//后台管理中的通知
///用户信息需要同步至服务端的通知
extern NSString *const FMGlobalManagerNeedSyncUserInfo;

//我的订单，订单状态发生变化，通知更新
extern NSString *const FMMyOrderStateChangeNotification;


//购物车界面tabbar小红点
extern NSString *const FMShoppingCartTabBarRedPointNotification;
//我的界面tabbar小红点
extern NSString *const FMPersonTabBarRedPointNotification;

//主播开启和关闭美颜的通知
extern NSString *const FMLiveAnchorConfigureMeiYanOpenNotification;
extern NSString *const FMLiveAnchorConfigureMeiYanCloseNotification;

//美颜设置改变
extern NSString *const FMLiveViewBeautySettingChangeNotification;

//观看时主播下线了…
extern NSString *const FMLiveViewHostHadLeftNotification;


//分享界面消失通知，用于处理防止分享多次被打开
extern NSString *const FMShareViewHideNotification;

//用于 观众端观看时播放器开始播放通知
extern NSString *const FMAudiencePlayIngNotification;

// 通知首页刷新
extern NSString *const FMHomeNeedRequestNotification;

//通知有完成的任务未领取奖励
extern NSString *const FMHaveDoneTaskNotification;

//主播端断线1分钟处理
extern NSString *const FMHostLiveDropOneMinuteNotification;

///
extern NSString *const FMAnchorOnLinePushNotification;

extern NSString *const FMUpdateVersionNotification;

//启动新手指引
extern NSString *const FMGameRoomStartNewPlayerGuideNotification;
//新手指引下注的一定要在倒计时大于20秒时执行，新开局的通知
extern NSString *const FMGameRoomNeedShowWagerGuide;
//倒计时结束要收回下注新手指引
extern NSString *const FMGameRoomNeedHideWagerGuide;
//领完钻石后要显示送礼物的指引
extern NSString *const FMGameRoomNeedShowGiftViewGuideNotification;

//创建直播间
extern NSString *const FMHostCreateLiveNotification;

//通知商城界面进行刷新
extern NSString *const FMMallViewControllerNeedRefreshNotification;

@end
