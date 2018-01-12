
//
//  FMEnum.h
//  ForMan
//
//  Created by slj on 16/6/25.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#ifndef FMEnum_h
#define FMEnum_h

#define FMGameVersionLowerTip @"请更新至最新版本，才能进入此游戏间！"

//首页 内容样式
typedef NS_ENUM(NSInteger, FMHallType) {
    FMHallType_Hot          = 0,           //热门
    FMHallType_New          = 1,           //新人
};

//排行榜

typedef NS_ENUM(NSInteger, FMRankListType) {
    FMRankListType_CharmWeek        = 0,           //0魅力周榜
    FMRankListType_RichWeek         = 1,            // 1土豪周榜
    FMRankListType_CharmTotal       = 2,           //2魅力总榜
    FMRankListType_RichTotal        = 3,            //3土豪总榜
    FMRankListType_GuardianList     = 9,            //守护榜
    FMRankListType_CharmDay         = 4,           //0魅力日榜
    FMRankListType_RichDay          = 5,            // 1土豪日榜

};

//0魅力周榜 1土豪周榜 2魅力总榜 3土豪总榜

//直播房间类型
typedef NS_ENUM(NSInteger, FMAnchorRoomType) {
    FMAnchorRoomType_Show     = 0,           //秀场
    FMAnchorRoomType_Game     = 1,           //游戏
    FMAnchorRoomType_Vedio    = 2,           //视频

};

typedef NS_ENUM(NSInteger, FMAnchorState) {
    FMAnchorState_off   = 0,//0休息
    FMAnchorState_on    = 1,//1直播
    FMAnchorState_ban   = 2,//2禁播
    
};


//我的订单支付方式
typedef NS_ENUM(NSInteger, FMMyOrderPayWayType)
{
    FMMyOrderPayWayTypeNone             = -1,//未知
    FMMyOrderPayWayTypeAliPay           = 0,//支付宝支付
    FMMyOrderPayWayTypeWeChat           = 1,//微信支付
};

typedef NS_ENUM(NSInteger, FMBottomLineColorStyle){
    FMBottomLineColorStyleLight = 0,            //浅色[FMColor fmColor_Line1]
    FMBottomLineColorStyleDark,                 //深色[FMColor fmColor_Line2]
    FMBottomLineColorStyleWhite,
};

typedef NS_ENUM(NSUInteger, FMShareTargetType) {
    FMShareTargetTypeweChatFriend=0,
    FMShareTargetTypeweChatRound,
    FMShareTargetTypeWeibo,
    FMShareTargetTypeQQ,
    FMShareTargetTypeQQZone,
    FMShareTargetTypeCopyURL,
};

typedef NS_ENUM(NSInteger, FMMyProfitType)
{
    FMMyProfitType_Live     = 0,
    FMMyProfitType_PeiPei   = 1,
};

#endif /* FMEnum_h */
