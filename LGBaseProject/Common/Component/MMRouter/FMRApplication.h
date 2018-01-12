//
//  FMRApplication.h
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIApplication+FMRSwizzle.h"
#import "FMRNode.h"
#import "FMRConfiguration.h"
#import "FMRouterHeader.h"
#ifndef FMR
    #define FMR 1
#endif



@class FMRConfiguration, FMRNode;

/**
 *  FMR means 'FM  Router'
 *  FMR accepts PathInfo style URL (eg. wechat://sayhello/key1/value1/key2/value2....)
 *  FMR also accepts QueryString style URL (eg. wechat://sayhello/?key1=value1&key2=value2...)
 *  Default style = QueryString
 */
@interface FMRApplication : NSObject

@property (nonatomic, readwrite) FMRConfiguration *configure;

+ (FMRApplication *)sharedInstance;

- (void)addNode:(FMRNode *)node;

- (BOOL)canOpenURL:(NSURL *)URL;

- (id)openURL:(NSURL *)URL;

- (id)openURL:(NSURL *)URL sourceObject:(NSObject *)sourceObject;


//@property(nonatomic,weak)id<FMRApplicationProtocol> FMDelegate;
@end
