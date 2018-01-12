//
//  FMRConfiguration.m
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import "FMRConfiguration.h"

@implementation FMRConfiguration

+ (FMRConfiguration *)defaultConfiguration {
    FMRConfiguration *configure = [[FMRConfiguration alloc] init];
    configure.schemes = nil;
    configure.URLStyle = FMRURLStyleQueryString;
    return configure;
}

@end
