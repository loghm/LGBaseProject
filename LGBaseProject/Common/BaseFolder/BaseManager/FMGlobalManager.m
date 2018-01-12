//
//  FMGlobalManager.m
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "FMGlobalManager.h"
#import "FMUserManager.h"
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>
//#import <BaiduMapAPI_Location/BMKLocationComponent.h>
//#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "UIAlertView+FMPublic.h"
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "LGNetWorkAction.h"
//#import <OpenUDID.h>
#import "YYCache+FMPublic.h"
//#import "FMReachabilityHelper.h"
//#import "FMDateUtil.h"
#import "FMUserManager.h"
//#import "DES3Util.h"

#define KEY_GLOBAL_CONFIG_MODEL   @"key_global_config_model"
#define KEY_GLOBAL_VERSION_UPDATE   @"key_global_version_update"

@interface FMGlobalManager ()// <BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>
{
//    BMKLocationService *locService;
//    BMKUserLocation *nowLocation;
//    BMKGeoCodeSearch *geoSearch;
    NSInteger downloadEncyTimes;
    NSInteger downloadEncyProjectTimes;
    
    NSInteger _getGlobalConfigCount;
}
@property (nonatomic, assign)  NSInteger getSystemTimeCount;

@end

@implementation FMGlobalManager

+ (instancetype)shareInstance
{
    static FMGlobalManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FMGlobalManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [userDefaults objectForKey:KEY_GLOBAL_CONFIG_MODEL];
        if (data)
        {
            self.globalConfig = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        if (self.globalConfig == nil)
            self.globalConfig = [[FMGlobalConfigModel alloc] init];
        [self getGlobalCofig];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncUserInfo) name:FMGlobalManagerNeedSyncUserInfo object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAction) name:FMUserLoginNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutAction) name:FMUserLogoutNotification object:nil];
//        [self performSelector:@selector(startLocation) withObject:nil afterDelay:2.0];
        [self performSelector:@selector(delayDoing) withObject:nil afterDelay:3.0];
#if !TARGET_OS_SIMULATOR
        [self performSelector:@selector(uploadUserDeviceInfo) withObject:nil afterDelay:15.0];//上传用户手机信息
        [self performSelector:@selector(getVersonUpdate) withObject:nil afterDelay:0.0];//更新版本
#endif
        
        _getSystemTimeCount = 0;
        
    }
    return self;
}

//获取全局配置
- (void)getGlobalCofig
{
    
    //调用
    
    //启动图
    self.globalConfig.starImageURL =@"1.jpg";
    //

    self.globalConfig.storeImageUrlPrefix=@"http://oo8h36x0w.bkt.clouddn.com/";
    self.globalConfig.userImageUrlPrefix=@"http://oo8h36x0w.bkt.clouddn.com/";
    
    
    //    self.globalConfig.qnUploadUserHeadToken =@"jA53eXpe9ZKD7d13lX835nvmi-CTT_8ppkcxGhi9:-8bRRHEmwcIhvJwaDxybVUGpTYQ=:eyJzY29wZSI6InVzZXJoZWFkIiwiZGVhZGxpbmUiOjE0NTA2Mjg1NTN9";
    
//    FM_WEAKSELF
//    [super GetAsync:NO URLString:FM_URL_GLOBAL_COFIG_INITIALIZE parameters:nil block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            _getGlobalConfigCount = 0;
//            NSArray *array = (NSArray *)[blockInfo objectForKey:@"sysconfig"];
//            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSDictionary *dic = (NSDictionary*)obj;
//
//                NSString *keyString = [dic objectForKey:@"attribute"];
//                if ([[dic objectForKey:@"attribute"] isEqualToString:@"spic"])  //启动图
//                    weakSelf.globalConfig.starImageURL = [dic objectForKey:@"values"];
//                else if ([[dic objectForKey:@"attribute"] isEqualToString:@"productpic"])  //商城
//                    weakSelf.globalConfig.storeImageUrlPrefix = [dic objectForKey:@"values"];
//                else if ([[dic objectForKey:@"attribute"] isEqualToString:@"userheadpic"])  //用户头像
//                    weakSelf.globalConfig.userImageUrlPrefix = [dic objectForKey:@"values"];
//                //                if ([[dic objectForKey:@"attribute"] isEqualToString:@"rsa"])
//                //                    self.globalConfig.starImageURL = [dic objectForKey:@"values"];
//                else if ([[dic objectForKey:@"attribute"] isEqualToString:@"yuliu1"])
//                    weakSelf.globalConfig.des3IV = [dic objectForKey:@"values"];
//                else if ([[dic objectForKey:@"attribute"] isEqualToString:@"yuliu2"])
//                    weakSelf.globalConfig.des3Key = [dic objectForKey:@"values"];
//
//                else if ([[dic objectForKey:@"attribute"] isEqualToString:@"areaupdate"])  //地区更新
//                {
//                    NSTimeInterval newTime = [[dic objectForKey:@"values"] doubleValue]/1000;
//                    if (newTime > self.globalConfig.areaupdateTime) {
//                        weakSelf.globalConfig.areaupdateTime = newTime;
//                        [weakSelf saveGlobalConfig];
//                        [weakSelf downLoadAreaData];
//                    }
//                }
//                else if ([[dic objectForKey:@"attribute"] isEqualToString:@"game_type"])  //
//                {
//                    NSString *gameType = [dic objectForKey:@"values"];
//                    weakSelf.globalConfig.gameTypeArray = [gameType componentsSeparatedByString:@","];
//                }
//
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"headqnt"])     //七牛上传头像的token
//                    weakSelf.globalConfig.uploadUserHeadToken = [dic objectForKey:@"values"];
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"cardqnt"])     //七牛上传身份证的token
//                    weakSelf.globalConfig.uploadCardToken = [dic objectForKey:@"values"];
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"evaluateqnt"]) //七牛上传评论照片的token
//                    weakSelf.globalConfig.uploadEvaluateToken = [dic objectForKey:@"values"];
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"faqurl"])      //商品详情页的faq的url
//                    weakSelf.globalConfig.goodsDetailFAQURL = [dic objectForKey:@"values"];
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"shareurl"])      //分享链接前缀
//                    weakSelf.globalConfig.shareURLPrefix = [dic objectForKey:@"values"];
//
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"goumaiurl"])      //购买协议Url
//                    weakSelf.globalConfig.orderBuyProtocolURL = [dic objectForKey:@"values"];
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"couponurl"])      //优惠券协议Url
//                    weakSelf.globalConfig.couponURL = [dic objectForKey:@"values"];
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"thridswitch"])      //是否显示第三方登录、分享按钮
//                    weakSelf.globalConfig.showThirdLogin = [[dic objectForKey:@"values"] boolValue];
//
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:FMPROFITSWITCH]){
//                    NSLog(@"====获取全局配置====%@",[dic objectForKey:@"values"]);
//                    weakSelf.globalConfig.profitswitch = [[dic objectForKey:@"values"] boolValue];
//                    NSLog(@"%d",weakSelf.globalConfig.profitswitch);
////                    if (!weakSelf.globalConfig.profitswitch && ![FMToolsFunction isAppStoreInReview]) {
////                        weakSelf.globalConfig.profitswitch = YES;
////                    }
//                }
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"is_check"]){
//                    weakSelf.globalConfig.isSign = [[dic objectForKey:@"values"] boolValue];
//                    [FMUserManager shareInstance].userModel.is_check = self.globalConfig.isSign;
//                }
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"shoppingrecommend"])      //是否有推荐位
//                    weakSelf.globalConfig.hadShoppingrecommend = [[dic objectForKey:@"values"] boolValue];
//                else  if ([[dic objectForKey:@"attribute"] isEqualToString:@"foreign_ip"])      //是否是国外IP
//                    weakSelf.globalConfig.foreignIp = [[dic objectForKey:@"values"] boolValue];
//                else if ([[dic objectForKey:@"attribute"] isEqualToString:@"t1"])
//                {
//                    if (!weakSelf.globalConfig.tempToken)
//                    {
//                        weakSelf.globalConfig.tempToken = [dic objectForKey:@"values"];
//                        [[FMNetWorkingAction shareInstance] loadTempToken:[dic objectForKey:@"values"]];
//                    }
//                }
//            }];
//
//            weakSelf.globalConfig.showThirdLogin = YES;
//            [weakSelf saveGlobalConfig];
//        }
//        else if (status == FMBaseManagerReturnInfoNetworkError)
//        {
//            _getGlobalConfigCount++;
//            if (_getGlobalConfigCount < 5)
//            {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    if ([FMReachabilityHelper networkEnable])
//                    {
//                        [weakSelf getGlobalCofig];
//                    }
//                });
//            }
//        }
//    }];
}

- (void)delayDoing
{
//    [self syncUserInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfoRequest) name:FMPersonalNeedRequestNotification object:nil];
    //    [FMCacheManager resetAllCacheState];
    
//    @weakify(self);
//    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"kRealReachabilityChangedNotification" object:nil] subscribeNext:^(id x) {
//        @strongify(self);
//        NSNotification *notification = (NSNotification*)x;
//        RealReachability *reachability = (RealReachability *)notification.object;
//        ReachabilityStatus status=  [reachability currentReachabilityStatus];
//        if (status != 0)
//        {
//            FMRunInBackgroudQueue(^{
//                [self getSystemTime];
//                [FMGetAllDomainIP getAllDomainIP];
//            });
//
//        }
//    }];
    
    //延期执行的SDK初始化
    //清除7天前的缓存
    [[YYCache sharedCache] .diskCache trimToAge:60 * 60 * 24 * 7 withBlock:^{
        
    }];
    
    
    //友盟统计
//    UMConfigInstance.appKey = K_KEY_UMENG;
//    [MobClick startWithConfigure:UMConfigInstance];
    NSString *finalversion=[NSString stringWithFormat:@"%@.%@",APPVersion,APPBuildVersion] ;
    
#ifdef DEBUG
    finalversion =[NSString stringWithFormat:@"%@.%@",APPVersion,APPBuildVersion] ;
    
#else
    finalversion=APPVersion;
#endif
//    [MobClick setAppVersion:finalversion];
    
    
//    [FMJSPatchManager startService];
}


- (void)saveGlobalConfig
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.globalConfig];
    
    [userDefaults setObject:data forKey:KEY_GLOBAL_CONFIG_MODEL];
    
    [userDefaults synchronize];
}




- (void)downLoadAreaData
{
    
}

#pragma mark - notification event
-(void)getUserInfoRequest
{
    if ([FMUserManager isLogin])
    {
        
        [[FMUserManager shareInstance] getUserInfoComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
            if (status == FMBaseManagerReturnInfoSuccess)
            {
                FM_POST_NOTIFY(FMPersonalNeedRefreshNotification);

                NSLog(@"headImage:...%@, nickName:...%@", [FMUserManager shareInstance].userModel.headImageURL, [FMUserManager shareInstance].userModel.nickName);
                if ([FMUserManager shareInstance].userModel.headImageURL.length == 0 ||
                    [FMUserManager shareInstance].userModel.nickName.length == 0) {
                    [FMUserManager removeToken];
                    FM_POST_NOTIFY(FMPersonalNeedUpdateUserInfoNotification);
                }
            }
        }];
    }
}

- (void)syncUserInfo
{
    [[FMUserManager shareInstance] synUserInfoToServer];
}

/**
 *  登陆通知
 */
- (void)loginAction
{
    
}
/**
 *  登出通知
 */
- (void)logoutAction
{

}

//- (void)userSelectedCity:(NSString*)city
//{
//    self.globalConfig.selectedCity = city;
//    [self saveGlobalConfig];
//}

#pragma mark - Location
//- (void)startLocation
//{
//    if (!locService)
//    {
//        locService = [[BMKLocationService alloc] init];
//        locService.delegate = self;
//    }
//    [locService startUserLocationService];
//}
//
//- (void)stopLocation
//{
//    [locService stopUserLocationService];
//    locService.delegate = nil;
//    locService = nil;
//}
//
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    NSLog(@"heading is %@", userLocation.heading);
//}
//
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
//{
//    nowLocation = userLocation;
//    geoSearch = [[BMKGeoCodeSearch alloc]init];
//    geoSearch.delegate = self;
//    CLLocationCoordinate2D pt = userLocation.location.coordinate;
//    self.globalConfig.longitude = userLocation.location.coordinate.longitude;
//    self.globalConfig.latitude = userLocation.location.coordinate.latitude;
//    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
//    reverseGeocodeSearchOption.reverseGeoPoint = pt;
//    BOOL flag = [geoSearch reverseGeoCode:reverseGeocodeSearchOption];
//    if(flag)
//    {
//        NSLog(@"反geo检索发送成功");
//    }
//    else
//    {
//        NSLog(@"反geo检索发送失败");
//    }
//    [self stopLocation];
//}
//
//- (void)didFailToLocateUserWithError:(NSError *)error
//{
//    NSLog(@"定位失败");
//    [self stopLocation];
//}
//
//-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
//{
//    if (error == BMK_SEARCH_NO_ERROR)
//    {
//        NSString *string = result.addressDetail.city;
//        NSLog(@"当前定位城市：%@", string);
//        NSRange range = [string rangeOfString:@"市"];
//        if (range.length > 0)
//        {
//            string = [string substringToIndex:range.location];
//        }
//        if (string.length < 1)
//            string = @"全国";
//        if (![self.globalConfig.locationCity isEqualToString:string])
//            self.globalConfig.locationCity = string;
//        [self saveGlobalConfig];
//    }
//}

//上传用户手机信息
- (void)uploadUserDeviceInfo
{
//    获取已安装应用的bundleID
//        Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
//    #pragma clang diagnostic push
//    #pragma clang diagnostic ignored "-Wundeclared-selector"
//        NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
//        NSArray *array1 = [workspace performSelector:@selector(allApplications)];
//    #pragma clang diagnostic pop
    __block NSString *temp = @"";
//        [array1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj valueForKeyPath:@"boundApplicationIdentifier"])
//            {
//                NSString *string = [obj valueForKeyPath:@"boundApplicationIdentifier"];
//                if (![string hasPrefix:@"com.apple"])
//                {
//                    temp = [temp stringByAppendingString:string];
//                    temp = [temp stringByAppendingString:@","];
//                }
//            }
//        }];
    
     //获取广告id
     NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
     //获取设备机型
     NSString *code = [FMToolsFunction getDeviceVersion];
    
     //获取设备版本号
     NSString *phoneVersion = [UIDevice currentDevice].systemVersion;
     
     //获取运营商名称
     CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
     CTCarrier *carrier = [info subscriberCellularProvider];
     NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
     
     //手机分辨率CGFloat screenHeight = [ bounds].size.height;
     NSString *resolution = [NSString stringWithFormat:@"%.0fX%.0f", [UIScreen mainScreen].scale*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].scale*[UIScreen mainScreen].bounds.size.height];
     
     //获取网络类型
     NSString *networkType = [FMToolsFunction getNetworkType];
    
//     NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[OpenUDID value], @"driveid",
//                          code, @"mobile_model",
//                          @"iPhone", @"mobile_brand",
//                          phoneVersion, @"system_version",
//                          idfa, @"idfa",
//                          mCarrier, @"apn",
//                          temp, @"appname",
//                          [NSNumber numberWithLong:self.globalConfig.longitude], @"longitude",
//                          [NSNumber numberWithLong:self.globalConfig.latitude], @"latitude",
//                          resolution, @"resolution",
//                          networkType, @"network",
//                          self.globalConfig.deviceToken, @"udid",
//                          nil];
    
//     [super Post:NO URLString:FM_URL_GLOBAL_ADD_DEVICE_INFO parameters:dic block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//         if (status == FMBaseManagerReturnInfoSuccess)
//             NSLog(@"上传用户信息成功");
//         else
//             NSLog(@"上传用户信息失败");
//     }];

}

- (void)getVersonUpdate
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *keyString = [NSString stringWithFormat:@"updateVersion_%@",APPVersion];
   __block NSInteger updateVersionTime = [[userDefaults objectForKey:keyString ] integerValue];
    if (updateVersionTime > 2) {
        return;
    }
    if (updateVersionTime < 0) {
        updateVersionTime = 0;
    }
    
//    [super Get:NO URLString:FM_URL_GLOBAL_GET_VERSION_UPDATE
//    parameters:nil
//         block:^(FMBaseManagerReturnInfoStatus status, id blockInfo)
//    {
//        if (status == FMBaseManagerReturnInfoSuccess) {
//            BOOL is_update = [[blockInfo objectForKey:@"is_update"] boolValue];
//            if (is_update) {
//                updateVersionTime ++;
//                [userDefaults setObject:@(updateVersionTime) forKey:keyString];
//                NSString *updateVersionString = [blockInfo objectForKey:@"content"];
//                [[NSNotificationCenter defaultCenter] postNotificationName:FMUpdateVersionNotification object:updateVersionString];
//            }
//        }
//    }];
}

- (void)getSystemTime {

    FM_WEAKSELF
    
//    [super Get:NO
////     URLString:FM_URL_GLOBAL_GET_SERVICE_TIME
//    parameters:nil
//         block:^(FMBaseManagerReturnInfoStatus status, id blockInfo)
//    {
//        if (status == FMBaseManagerReturnInfoSuccess) {
//            weakSelf.getSystemTimeCount = 0;
//            NSString *systimeString = blockInfo;
//            NSDate *systimeData = [FMDateUtil dateFromString:systimeString];
//            long long systime = [systimeData timeIntervalSince1970];
//
//            long long localtime = [[NSDate date] timeIntervalSince1970];
//            // 本地时间 - 系统时间的差值
//            self.sysTimeOffset = localtime - systime;
//        }
//        else{
//            if ([FMReachabilityHelper networkEnable] && weakSelf.getSystemTimeCount < 3) {
//                weakSelf.getSystemTimeCount++;
//            }
//            else{
//                return ;
//            }
//            //30秒后重试获取系统时间
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf getSystemTime];
//            });
//        }
//    }];
}

@end
