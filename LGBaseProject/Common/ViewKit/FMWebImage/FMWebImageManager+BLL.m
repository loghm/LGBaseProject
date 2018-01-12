//
//  FMWebImageManager+BLL.m
//  FMYYWebImage
//
//  Created by 陈炜来 on 16/6/15.
//  Copyright © 2016年 陈炜来. All rights reserved.
//  根据应用中的实际框架， 进行网络状态变更的监听

#import "FMWebImageManager+BLL.h"


@implementation FMWebImageManager (BLL)
-(id)init
{
    self=[super init];
    if (self) {
     
         //使用afnetworking [AFNetworkReachabilityManager startMonitoring]进行监听，但是我们项目中并不会手动去激活af的,所以这个其实没什么用。根据项目自行使用
//         RACSignal* afnSignal = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"com.alamofire.networking.reachability.change" object:nil] map:^id(NSNotification *notification) {
//             return notification.userInfo[@"AFNetworkingReachabilityNotificationStatusItem"];
//         }];
        
         //来自RealReachability定义的通知
//         RACSignal* FMSignal = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRealReachabilityChangedNotification object:nil] map:^id(NSNotification *notification) {
//          RealReachability *reachability = (RealReachability *)notification.object;
//            ReachabilityStatus status=  [reachability currentReachabilityStatus];
//             return @(status);
//         }];
//         if ([FMReachabilityHelper isWWAN]) {
         self.s_imageNetworkType=FMImageNetworkTypeWWAN;
//         }
//         else
//         {
//         self.s_imageNetworkType=FMImageNetworkTypeWIFI;
//         }
//
        //任意一个发送网络变化的通知都会触发
//         [[afnSignal merge:FMSignal] subscribeNext:^(NSNumber* x) {
//             self.s_imageNetworkType = (FMImageNetworkType) x.integerValue;
//         }];
        //        _s_qiniuQualityAutoChange=YES;
        self.s_qiniuImageQuality=30;
    }
    return self;
}

@end
