//
//  FMRCore+FMRPrivate.h
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import "FMRCore.h"
#import "FMRNodeManager.h"
#import "FMRConfigurationManager.h"

@interface FMRCore (FMRPrivate)

@property (nonatomic, readonly) FMRNodeManager *nodeManager;

@property (nonatomic, readonly) FMRConfigurationManager *configurationManager;

@end
