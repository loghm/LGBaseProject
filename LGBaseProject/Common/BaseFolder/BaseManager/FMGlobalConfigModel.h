//
//  FMGlobalConfig.h
//  MeiMei
//
//  Created by chw on 15/12/4.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMGlobalConfigModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *locationCity;
@property (nonatomic, strong) NSString *selectedCity;
//
/////定位到的纬度
@property (nonatomic, assign) double latitude;
/////定位到的经度
@property (nonatomic, assign) double longitude;
//
//
//
//
///**
// *  获取当前城市
// *
// *  @return 用户手动选择城市后则现在用户选择的城市，否则返回定位城市或定位中
// */
//- (NSString*)getNowCity;
//
///**
// *  获取当前定位城市的ID
// *
// *  @return 区域id
// */
//- (NSInteger)getNowCityID;
//
///**
// *  获取最近访问的三个城市
// *
// *  @return 城市数组
// */
//-(NSArray *)getRecentlyCityArray;

///启动图片
@property (nonatomic, strong) NSString *starImageURL;
///商城图片前缀
@property (nonatomic, copy)NSString *storeImageUrlPrefix;
///用户头像图片前缀
@property (nonatomic, copy)NSString *userImageUrlPrefix;

///上传头像token
@property (nonatomic, copy) NSString *uploadUserHeadToken;

///上传身份证token
@property (nonatomic, copy) NSString *uploadCardToken;
///上传评价token
@property (nonatomic, copy) NSString *uploadEvaluateToken;

//筛选条件更新时间
@property (nonatomic, assign) NSTimeInterval filterUpdateTime;
//区域更新时间
@property (nonatomic, assign) NSTimeInterval areaupdateTime;

@property (nonatomic, copy) NSString *goodsDetailFAQURL;

///分享的地址前缀
@property (nonatomic, copy) NSString *shareURLPrefix;

//订单的购买协议h5地址
@property (nonatomic, copy) NSString *orderBuyProtocolURL;
//优惠券使用说明h5地址
@property (nonatomic, copy) NSString *couponURL;

//3des加密的iv和key
@property (nonatomic, strong) NSString *des3IV;
@property (nonatomic, strong) NSString *des3Key;

//消息推送的token
@property (nonatomic, strong) NSString *deviceToken;

@property (nonatomic, assign) BOOL showThirdLogin;
@property (nonatomic, assign) BOOL hadShoppingrecommend;//是否有推荐位
@property (nonatomic, assign) BOOL profitswitch;//是否显示收益
@property (nonatomic, assign) BOOL isSign;//是否已经签到

@property (nonatomic, copy) NSString *tempToken;        //临时token
@property (nonatomic, assign) BOOL foreignIp;//1是国外ip 0否

@property (nonatomic, assign) BOOL isVersionUpdateShowing;//版本跟新提示

@property (nonatomic, strong) NSArray *gameTypeArray;//游戏类型
@end


