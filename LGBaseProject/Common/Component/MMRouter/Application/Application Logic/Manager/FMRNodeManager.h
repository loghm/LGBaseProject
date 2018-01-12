//
//  FMRNodeManager.h
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMRNode;

@interface FMRNodeManager : NSObject

- (void)addNode:(FMRNode *)node;

- (FMRNode *)nodeForURL:(NSURL *)URL;

@end
