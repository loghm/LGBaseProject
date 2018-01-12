//
//  FMRApplication.m
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMRApplication.h"
#import "FMRCore.h"
#import "FMRCore+FMRPrivate.h"
#import "FMRNode.h"
#import "FMRConfiguration.h"
#import "NSURL+FMRURLParser.h"
//#import "FMKWebViewController.h"
@interface FMRApplication ()

@property (nonatomic, strong) FMRCore *core;

@end

@implementation FMRApplication

+ (FMRApplication *)sharedInstance {
    static FMRApplication *application;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        application = [[FMRApplication alloc] init];
    });
    return application;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.core = [[FMRCore alloc] init];
    }
    return self;
}

- (void)setConfigure:(FMRConfiguration *)configure {
    [self.core.configurationManager setConfigure:configure];
}

- (FMRConfiguration *)configure {
    return self.core.configurationManager.configure;
}

- (void)addNode:(FMRNode *)node {
    [self.core.nodeManager addNode:node];
}

- (BOOL)canOpenURL:(NSURL *)URL {
    return
    [self.core.nodeManager nodeForURL:URL] != nil &&
    (self.core.configurationManager.configure.schemes == nil ||
    [self.core.configurationManager.configure.schemes containsObject:URL.scheme]);
}

- (id)openURL:(NSURL *)URL {
    return [self openURL:URL sourceObject:nil];
}

- (id)openURL:(NSURL *)URL sourceObject:(NSObject *)sourceObject {
    FMRNode *node = [self.core.nodeManager nodeForURL:URL];
    if (node == nil) {
        NSString *urlStr=[URL absoluteString];
            if (([urlStr hasPrefix:@"http://"] || [urlStr hasPrefix:@"https://"])) {
                if ([urlStr hasSuffix:FM_Router_Suffix_OutMeimei]) {//外链地址
                    urlStr= [urlStr stringByReplacingOccurrencesOfString:FM_Router_Suffix_OutMeimei withString:@""];//去除外链标记
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                    return nil;
                }
                //内链
//                FMKWebViewController *webVC=[FMKWebViewController webWithURLString:urlStr];
//                return webVC;
            }
        [[UIApplication sharedApplication] openURL:URL];
        return nil;
    }
    else {
        if (self.core.configurationManager.configure.URLStyle == FMRURLStylePathInfo) {

            if (node.executingBlock != nil) {
                return node.executingBlock(URL, [URL FMR_parseAsPathInfo], sourceObject);
            }
            else {
                return nil;
            }
        }
        else if (self.core.configurationManager.configure.URLStyle == FMRURLStyleQueryString) {
       
            if (node.executingBlock != nil) {
                return node.executingBlock(URL, [URL FMR_parseAsQueryString], sourceObject);
            }
            else {
                return nil;
            }
        }
        else {
            return nil;
        }
    }
}

@end
