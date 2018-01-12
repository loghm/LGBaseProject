//
//  YYCache+FMPublic.m
//  ForMan
//
//  Created by chw on 16/6/13.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "YYCache+FMPublic.h"

@implementation YYCache (FMPublic)

+ (instancetype)sharedCache
{
    static YYCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        cachePath = [cachePath stringByAppendingPathComponent:APPBundleIdentifier];
        cachePath = [cachePath stringByAppendingPathComponent:@"fmDataCache"];
        cache = [self cacheWithPath:cachePath];
    });
    return cache;
}

@end
