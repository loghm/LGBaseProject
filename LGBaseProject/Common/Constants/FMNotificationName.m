//
//  FMNotificationName.m
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMNotificationName.h"

@implementation FMNotificationName


NSString *const IsEnablePersonalCenterVCMainTableViewScroll =   @"IsEnablePersonalCenterVCMainTableViewScroll";

NSString *const CurrentSelectedChildViewControllerIndex     =   @"CurrentSelectedChildViewControllerIndex";

NSString *const PersonalCenterVCBackingStatus               =   @"PersonalCenterVCBackingStatus";


//用户需要登录通知
NSString *const FMUserNeedLoginNotification                 =   @"fm_user_need_login_notification";
//登录通知
NSString *const FMUserLoginNotification                     =   @"fm_user_login_notification";
NSString *const FMUserLogoutNotification                    =   @"fm_user_logout_notification";

NSString *const FMPersonalNeedRefreshNotification           =   @"fm_personal_need_refresh_notification";

NSString *const FMPersonalNeedUpdateUserInfoNotification    =   @"fm_personal_need_update_userInfo_notification";

NSString *const FMPersonalNeedRequestNotification           =   @"fm_personal_need_request_notification";

NSString *const FMGlobalManagerNeedSyncUserInfo             =   @"fm_global_manager_need_sync_user_info";

NSString *const FMMyOrderStateChangeNotification            =   @"fm_myOrder_state_change_notification";

NSString *const FMShoppingCartTabBarRedPointNotification    =   @"fm_shoppingcart_tabbar_redpoint_notification";
NSString *const FMPersonTabBarRedPointNotification          =   @"fm_person_tabbar_redpoint_notification";

NSString *const FMLiveAnchorConfigureMeiYanOpenNotification =   @"fm_live_anchor_configure_meiyan_open_notification";
NSString *const FMLiveAnchorConfigureMeiYanCloseNotification =   @"fm_live_anchor_configure_meiyan_close_notification";

NSString *const FMMallViewControllerLXPMeiYanhNotification = @"lxp_meiyan";

//点击聊天区域的用户昵称
NSString *const FMLiveViewClickChatNicknameNotification = @"fm_live_view_click_nickname_notification";

//点击切换摄像头
NSString *const FMLiveViewClickChangeCameraNotification = @"fm_live_view_click_change_camera_notification";

//美颜设置改变
NSString *const FMLiveViewBeautySettingChangeNotification = @"fm_live_view_beauty_setting_change_notification";

//观看时主播下线了…
NSString *const FMLiveViewHostHadLeftNotification = @"fm_live_view_host_had_left_notification";

//分享界面消失通知，用于处理防止分享多次被打开
NSString *const FMShareViewHideNotification = @"fm_share_view_hide_notification";

NSString *const FMAudiencePlayIngNotification = @"fm_audience_playing_notification";

// 通知首页刷新
NSString *const FMHomeNeedRequestNotification = @"fm_home_need_requeset_notification";

//通知有完成的任务未领取奖励
NSString *const FMHaveDoneTaskNotification = @"fm_have_done_task_notification";

//主播端断线一分钟处理
NSString *const FMHostLiveDropOneMinuteNotification = @"fm_host_live_drop_one_minute_notification";

NSString *const FMAnchorOnLinePushNotification = @"fm_anchor_online_push_notification";

NSString *const FMUpdateVersionNotification = @"fm_update_version_notification";

//启动新手指引
NSString *const FMGameRoomStartNewPlayerGuideNotification = @"fm_game_room_start_new_player_guide_notification";
//新手指引下注的一定要在倒计时大于20秒时执行，新开局的通知
NSString *const FMGameRoomNeedShowWagerGuide = @"fm_game_room_need_show_wager_guide";
//倒计时结束要收回下注新手指引
NSString *const FMGameRoomNeedHideWagerGuide = @"fm_game_room_need_hide_wager_guide";
//领完钻石后要显示送礼物的指引
NSString *const FMGameRoomNeedShowGiftViewGuideNotification = @"fm_game_room_need_show_gift_guide_notification";

NSString *const FMHostCreateLiveNotification = @"fm_host_create_live_notification";

//通知商城界面进行刷新
NSString *const FMMallViewControllerNeedRefreshNotification = @"fm_mall_viewcontroller_need_refresh_notification";



@end
