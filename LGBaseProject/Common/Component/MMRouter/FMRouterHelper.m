//
//  FMRouterHelper.m
//  MeiMei
//
//  Created by 陈炜来 on 16/2/26.
//  Copyright © 2016年 MeiMei. All rights reserved.
//

#import "FMRouterHelper.h"
#import "FMRApplication.h"
#import "Appdelegate.h"
//#import "FMHostLiveViewController.h"
//#import "FMAudienceViewController.h"
@implementation FMRouterHelper



/**
 *  通过服务端返回的herfType 和href切割  拼接成URL
 *
 *  @param prefix meimei://sticker
 *  @param herf   @"8"
 *
 *  @return <#return value description#>
 */
+(NSString *)jumpLinkComponentsWithPrefix:(NSString *)prefix herfString:(NSString *)herf
{
    if ([prefix isEqualToString:@""]||prefix==nil) {
        return nil;
    }
    if ([herf isEqualToString:@""]) {
        herf=nil;//因为herf为@"" 仍然会切割,所以黑魔法nil
    }
    NSMutableString *url=[NSMutableString new];
    [url appendString:prefix];
    [url appendString:@"?"];
    NSArray *array=[herf componentsSeparatedByString:@","];
    
    int i=0;
    for (NSString *str in array) {
        [url appendFormat:@"param%d=%@&",i,str];
        i++;
    }
    
    NSString * finalUrl=    [url substringToIndex:url.length-1];
    finalUrl=  [finalUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return finalUrl;
}
+(NSString *)jumpLinkComponentsWithPrefix:(NSString *)prefix herfString:(NSString *)herf FMStyle2:(FMHomeStyle2)style2
{
    //    isOutLink:(BOOL)isOutLink execute:(BOOL)isExecute;
    BOOL isExecute=YES;
    BOOL isOutLink=NO;
    if (style2==kFMHomeStyle2None) {
        isExecute=NO;
    }
    if (!isExecute) {//是否执行
        return nil;
    }
    if (style2==kFMHomeStyle2OutLinks) {
        isOutLink=YES;
    }
    if (isOutLink) {//对外链做一个特殊标记
        prefix=  [prefix stringByAppendingString:FM_Router_Suffix_OutMeimei];
        return  prefix ;
    }
    NSString *link= [self jumpLinkComponentsWithPrefix:prefix herfString:herf];
     link=[link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return link;
}

+(NSString *)jumpLinkComponentsWithModel:(id<FMRouterModelProtocol>)model
{
    return   [self jumpLinkComponentsWithPrefix: [model url] herfString:[model href] FMStyle2:[model style2]];
}

+(NSString *)getImagePrefixByRouterAddress:(NSString *)routerAddress
{
    return nil;
}







+(void)rootJumpVCAction:(NSString *)router
{
    if (router) {
        UIViewController *vc=  [[FMRApplication sharedInstance] openURL:[NSURL URLWithString:router]];
        if(!vc)return;
        AppDelegate *app=  (AppDelegate *)[UIApplication sharedApplication].delegate;
        if ([app.rootTabBarViewController.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navc=(UINavigationController *)  app.rootTabBarViewController.selectedViewController;
            
            if (navc.presentedViewController) {//navc 当前显示模态视图的时候
                if (  [navc.presentationController isKindOfClass:[UINavigationController class]]) {//能push则push，不行就dismiss，用rootpush
                    UINavigationController *  presentNAVC=(UINavigationController*) navc.presentationController;
                    [presentNAVC pushViewController:vc animated:YES];
                    return;
                }
                else
                {
                    [navc dismissViewControllerAnimated:NO completion:nil];
                }
            }
            //如果要跳转的界面是观看直播界面，需要判断当前是否在观看直播或者是正在主播
//            if ([vc isKindOfClass:[FMAudienceViewController class]])
//            {
//                for (UIViewController *viewController in navc.viewControllers)
//                {
//                    if ([viewController isKindOfClass:[FMHostLiveViewController class]] && viewController == navc.viewControllers.lastObject)
//                    {
//                        //当前正在主播界面进行直播则不跳转
//                        return;
//                    }
//                    else if ([viewController isKindOfClass:[FMAudienceViewController class]])
//                    {
//                        FMAudienceViewController *temp = (FMAudienceViewController*)viewController;
//                        if (viewController != navc.viewControllers.lastObject)
//                            [navc popToViewController:viewController animated:NO];
//                        [temp changeToOtherAnchor: [vc valueForKey:@"host_uuid"]];
//                        return;
//                    }
//                }
//            }
//            [navc pushViewController:vc animated:YES];
        }
        else
        {
            [app.rootTabBarViewController.selectedViewController presentViewController:vc animated:YES completion:nil];
        }
    }
}
@end
