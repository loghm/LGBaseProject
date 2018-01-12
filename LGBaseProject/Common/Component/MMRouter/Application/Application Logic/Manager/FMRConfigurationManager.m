//
//  FMRConfigurationManager.m
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import "FMRConfigurationManager.h"
#import "FMRConfiguration.h"

@implementation FMRConfigurationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.configure = [FMRConfiguration defaultConfiguration];
    }
    return self;
}

@end
