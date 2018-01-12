//
//  FMRCore.m
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import "FMRCore.h"
#import "FMRNodeManager.h"
#import "FMRConfigurationManager.h"

@interface FMRCore ()

@property (nonatomic, strong) FMRNodeManager *nodeManager;

@property (nonatomic, strong) FMRConfigurationManager *configurationManager;

@end

@implementation FMRCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nodeManager = [[FMRNodeManager alloc] init];
        self.configurationManager = [[FMRConfigurationManager alloc] init];
    }
    return self;
}

@end
