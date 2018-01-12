//
//  UIApplication+FMRSwizzle.m
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import <objc/runtime.h>
#import "UIApplication+FMRSwizzle.h"
#import "FMRApplication.h"

@implementation UIApplication (FMRSwizzle)

+ (void)FMR_swizzleUIApplicationMethod {
    Method origMethod = class_getInstanceMethod([UIApplication class],
                                                @selector(openURL:));
    Method replacingMethod = class_getInstanceMethod([UIApplication class],
                                                     @selector(swizzle_FMRopenURL:));
    method_exchangeImplementations(origMethod, replacingMethod);
}

- (BOOL)swizzle_FMRopenURL:(NSURL *)URL {
    if ([[FMRApplication sharedInstance] canOpenURL:URL]) {
        [[FMRApplication sharedInstance] openURL:URL];
        return YES;
    }
    else {
        return [self swizzle_FMRopenURL:URL];
    }
}

@end
