//
//  FMConstants.h
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#ifndef FMConstants_h
#define FMConstants_h

#ifdef DEBUG
#define NSLog(...) NSLog(@"%@", [NSString stringWithFormat:__VA_ARGS__])
#define DMLog(...) NSLog(@"%s line:%d :%@", __PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:__VA_ARGS__])
#define DDLogError(...) NSLog(@"%s line:%d :%@", __PRETTY_FUNCTION__, __LINE__,[NSString stringWithFormat:__VA_ARGS__])
//A Better from OneV's Den Blog:https://onevcat.com/2014/01/black-magic-in-macro/
#define DLog(format, ...) do {                                                          \
            fprintf(stderr, "<%s : %d> %s\n",                                           \
            [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
            __LINE__, __func__);                                                        \
            (NSLog)((format), ##__VA_ARGS__);                                           \
            fprintf(stderr, "-------\n");                                               \
        } while (0)
#else
#define NSLog(...)
#define DMLog(...)
#define DDLogError(...)
#define DLog(...)
#endif


static inline void FMRunInMainQueue(dispatch_block_t block){
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

static inline void FMRunInBackgroudQueue(dispatch_block_t block){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            if(block)
            {
                block();
            }
        }
    });
}

//各种Block定义
#pragma mark - BlockDefine
typedef void (^FMBlock)(void);
typedef void (^FMBOOLBlock)(BOOL boolean);
typedef void (^FMIndexBlock)(NSUInteger index);
typedef void (^FMStringBlock)(NSString *string);
typedef void (^FMSenderBlock)(id sender);
typedef void (^FMKeyValueBlock)(id key, id obj);
typedef void (^FMBooleanValueBlock)(BOOL boolean, id value);


#pragma mark - 色值


#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]


#pragma mark - 适配参数

#define SCREEN_BOUNDS ([[UIScreen mainScreen]bounds])
/// 屏幕宽度
#define SCREEN_WIDTH ([[UIScreen mainScreen]bounds].size.width)
/// 屏幕高度
#define SCREEN_HEIGHT ([[UIScreen mainScreen]bounds].size.height)
/// 系统 scale
#define SCREEN_SCALE ([[UIScreen mainScreen] scale])


//适配iOS 11 导航栏高度
#define NAVIGATION_HEIGHT (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]) + CGRectGetHeight(self.navigationController.navigationBar.frame))
//适配iOS 11 tabBar高度
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
//适配iOS 11状态栏高度
#define STATUS_HEIGHT (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]))

//判断系统版本
#define IOS5 ([UIDevice currentDevice].systemVersion.floatValue >= 5)
#define IOS6 ([UIDevice currentDevice].systemVersion.floatValue >= 6)
#define IOS7 ([UIDevice currentDevice].systemVersion.floatValue >= 7)
#define IOS8 ([UIDevice currentDevice].systemVersion.floatValue >= 8)
#define IOS9 ([UIDevice currentDevice].systemVersion.floatValue >= 9)
#define IOS10 ([UIDevice currentDevice].systemVersion.floatValue >= 10)
#define IOS11 ([UIDevice currentDevice].systemVersion.floatValue >= 11)

//判断手机型号
#define iPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define iPhone6 ([UIScreen mainScreen].bounds.size.width == 375)
#define iPhone6p ([UIScreen mainScreen].bounds.size.width == 414)
//适配iPhone X
#define IS_iPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)

/** 本地化字符串*/
#define LGLocalString(x) NSLocalizedString(x, nil)
/** 设置图片*/
#define LGImageName(string) [UIImage imageNamed:string]



/** strongSelf和weakSelf*/
#define  FM_WEAKSELF      __weak typeof(self) weakSelf                    = self;
#define  FM_STRONGSELF(weakSelf)    __strong __typeof(weakSelf)strongSelf = weakSelf;


/** app信息（名字，版本，bundleID）*/
#define APPName [[NSBundle mainBundle] infoDictionary][@"CFBundleName"]
#define APPVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
#define APPBuildVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]
#define APPBundleIdentifier [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"]



#pragma mark - ThirdPart
//第三方key等
//#define K_KEY_UMENG             @"586b4f3245297d42c1000e1d"
#define K_KEY_BAIDU             @"2zEe8EAtNm0mG9GBGbbTrWU1ZIqTUZR4"
#define K_APPID_QQ              @"1106162070"
#define K_SCRECT_QQ             @"iGSAWEK6Q5M2J6G7"
//#define K_APPID_WECHAT          @"wxe77b74c5aeed5758"
//#define K_SCRECT_WECHAT         @"b88b9cac7d02556124706f089abe7694"
#define K_APPID_WECHAT          @"wxce439d179a5ee18b"
#define K_SCRECT_WECHAT         @"b88b9cac7d02556124706f089abe7694"


#define K_TrackWithAppkey       @"59269beac895760c6b0018a8"


//#define K_APPID_WECHAT          @"wx587e9149bd080c0e"
//#define K_SCRECT_WECHAT         @"50e84ffcb06bd3e1c74c9c2532dbb696"

#define K_KEY_WEIBO             @"3934020870"
#define K_SCRECT_WEIBO          @"f03bc8d991dbc1487a87e43e7af52065"
#define K_REDIRECTURI_WEIBO     @"https://api.weibo.com/oauth2/default.html"

#endif /* FMConstants_h */
