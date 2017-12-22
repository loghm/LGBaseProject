//
//  LGNetWorkAction.m
//  LGBaseProject
//
//  Created by loghm on 2017/12/14.
//  Copyright © 2017年 loghm. All rights reserved.
//

#import "LGNetWorkAction.h"

@interface LGNetWorkAction()

@property (nonatomic, strong) AFHTTPSessionManager *manager;


@end

@implementation LGNetWorkAction

+(LGNetWorkAction *)shareInstance {
    static LGNetWorkAction *instance = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        instance = [[LGNetWorkAction alloc] init];
    });
    return instance;
}

-(instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        [self setSerializer];
    }
    return self;
}

-(void)setSerializer {
    
}


@end
