//
//  FMRouterMapManager.m
//  MyStoryTest
//
//  Created by 陈炜来 on 15/11/30.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import "FMRouterMapManager.h"
#import "FMRApplication.h"
#import "FMRNode.h"
#import <objc/runtime.h>
#import "NSData+FMRouterTrans.h"
#import "FMRouterHeader.h"
#import "AppDelegate.h"

#import "FMBaseViewController.h"
@interface FMRouterMapManager()//<FMRApplicationProtocol>

@property(nonatomic,strong,readwrite)NSDictionary *mapDict;


@end


@implementation FMRouterMapManager

+(void)load
{
    //注册url呼唤式启动页面
    [UIApplication FMR_swizzleUIApplicationMethod];
    [FMRouterMapManager sharedInstance];
}
+ (FMRouterMapManager*)sharedInstance
{
    static FMRouterMapManager *manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(instancetype)init
{
    self=[super init];
    if (self) {
        [self addControllerMap];
        //        [FMRApplication sharedInstance].FMDelegate=self;
    }
    return self;
}

-(NSDictionary *)mapDict
{
    if (!_mapDict) {
        NSData* jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FMRouterMap.json" ofType:nil]];
        NSDictionary  *config = [NSData FM_dictionaryWithJSONData:jsonData];
        _mapDict=config;
    }
    return _mapDict;
}


-(void)addControllerMap
{
    //        [[[FMRApplication sharedInstance] configure] setSchemes:@[@"MeiMei"]];
    
    if(self.mapDict.count>0)
    {
        //映射
        [self.mapDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            NSDictionary *mapContent=(NSMutableDictionary *)obj;
            FMRNode *node = [[FMRNode alloc] init];
            
            NSString *mapId=key;
            NSString *mapVC=mapContent[@"mapVC"];//对应controller
            NSString *mapSB=mapContent[@"mapSB"];//对应SB
            NSDictionary *mapParamDict=mapContent[@"mapParams"];//服务端参数
            NSDictionary *localParamsDict=mapContent[@"localParams"];//本地参数
            node.identifier =mapId;
            node.scheme=@"fm";
            BOOL needLogin=[mapContent[@"needLogin"] boolValue];
            if ([key isEqualToString:@"login"])
            {
                [node setExecutingBlock:^(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
//                      FM_POST_NOTIFY(FMUserNeedLoginNotification);
                    UIViewController *vc;
                    return vc;
                }];

            }
            else if  ([key isEqualToString:@"my"] || [key isEqualToString:@"shop"])
            {
//                UIViewController *viewController;
//                [node setExecutingBlock:^(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
//                    AppDelegate *app=   (AppDelegate *)[[UIApplication sharedApplication] delegate];
////                       FMRootViewController *tabVC=[app rootTabBarViewController];
//                 
//                    NSArray *subRoots= tabVC.fmViewControllers;
//                    
//                    for (UIViewController *tabRoot in subRoots) {
//                        if ([tabRoot isKindOfClass:[UINavigationController class]]) {
//                            UINavigationController *navc=(UINavigationController *)tabRoot;
//                            NSString *className= NSStringFromClass([navc.topViewController class]);
//                            if ([className isEqualToString:mapVC]) {
//                                [navc popToRootViewControllerAnimated:NO];
//                                NSInteger index=  [subRoots indexOfObject:navc];
//                                tabVC.fm_selectedIndex=index;
//                                break;
//                            }
//                        }
//                        
//                    }
//                    return viewController;
//                }];
                
            }
            else
            {
                //执行
                [node setExecutingBlock:^(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
                    UIViewController *viewController;
                    if (mapSB!=nil&&![mapSB isEqualToString:@""]) {//stroyboard
                        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:mapSB bundle:nil];
                        if(storyBoard)
                        {
                            //使用KVO 提取除stroyBoard映射的列表
                            NSDictionary  *nibMapDict= [storyBoard valueForKey:@"identifierToNibNameMap"];
                            NSString *mapNib=    [nibMapDict objectForKey:mapVC];
                            if (mapNib) {
                                viewController= [storyBoard instantiateViewControllerWithIdentifier:mapVC];
                            }
                            else
                            {
                                //请完善映射表
//                                NSAssert(NO, @"storyBoard没有找到对应的controller,mapId:%@ mapVC:%@ mapSB:%@",mapId,mapVC,mapSB);
                                DMLog(@"没有找到对应的controller mapId:%@ mapVC:%@ mapSB:%@",mapId,mapVC,mapSB);
                                FMBaseViewController *errVC= [[FMBaseViewController alloc]init];
                                [errVC.captionView setTitle:@"error 没有找到对应的页面" andState:FMCaptionViewStateNoResult];
                                errVC.captionView.state=FMCaptionViewStateNoResult;
                                return (UIViewController *)errVC;
                            }
                        }
                    }
                    else
                    {// xib和纯代码
                        Class vcClass = NSClassFromString(mapVC);
                        viewController=[[vcClass alloc]init];
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//                        //                        UIViewController *reviewVC = [vcClass performSelector:NSSelectorFromString(@"reviewViewController:") withObject:@{@"bookId":@1, @"type": @(1)}];
//#pragma clang diagnostic pop

                    }
            
                    
                    if (viewController) {//给属性赋值
                        for (NSString *key in [params allKeys]) {//便利url中的所有key
                            if ([mapParamDict objectForKey:key]) {
                                NSString *urlValue=[params objectForKey:key];
                                NSString *mapProperty= [mapParamDict objectForKey:key];
                                [viewController setValue:urlValue forKeyPath:mapProperty];
                            }
                        }
                        //本地参数赋值
                        [localParamsDict enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString * obj, BOOL * _Nonnull stop) {
                            [viewController setValue:obj forKeyPath:key];
                        }];
                        
                    }
                       [viewController setValue:@(needLogin) forKey:@"needLogin"];
                    if (viewController) {
                        return viewController;
                    }
                    else
                    {
//                        NSAssert(NO, @"没有找到对应的controller mapId:%@ mapVC:%@ mapSB:%@",mapId,mapVC,mapSB);
                        DMLog(@"没有找到对应的controller mapId:%@ mapVC:%@ mapSB:%@",mapId,mapVC,mapSB);
                        FMBaseViewController *errVC= [[FMBaseViewController alloc]init];
                        [errVC.captionView setTitle:@"error 没有找到对应的页面" andState:FMCaptionViewStateNoResult];
                        errVC.captionView.state=FMCaptionViewStateNoResult;

                        return (UIViewController *)errVC;
                    }
                }];
            }
            [[FMRApplication sharedInstance] addNode:node];
            
            
            
        }];
    }
}
























- (NSArray *)getAllProperties:(Class )class

{
    
    u_int count;
    
    objc_property_t *properties  =class_copyPropertyList(class, &count);
    
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i<count; i++)
    
    {
        
        const char* propertyName =property_getName(properties[i]);
        
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
        
    }
    
    free(properties);
    
    return propertiesArray;
    
}
@end
