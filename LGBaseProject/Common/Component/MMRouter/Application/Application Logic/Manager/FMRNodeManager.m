//
//  FMRNodeManager.m
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import "FMRNodeManager.h"
#import "FMRNode.h"

@interface FMRNodeManager ()

@property (nonatomic, copy) NSArray *nodes;

@end

@implementation FMRNodeManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nodes = @[];
    }
    return self;
}

- (void)addNode:(FMRNode *)node {
    NSMutableArray *nodes = [self.nodes mutableCopy];
    [nodes addObject:node];
    self.nodes = nodes;
}

- (FMRNode *)nodeForURL:(NSURL *)URL {
    __block FMRNode *node;
    [self.nodes enumerateObjectsUsingBlock:^(FMRNode *obj, NSUInteger idx, BOOL *stop) {
        if (!obj.usePattern) {
            if (obj.scheme == nil ||
                [[obj.scheme lowercaseString] isEqualToString:[URL.scheme lowercaseString]]) {
                if ([[obj.identifier lowercaseString] isEqualToString:[URL.host lowercaseString]]) {
                    node = obj;
                    *stop = YES;
                }
            }
        }
        else {
            BOOL schemeMatch = NO;
            BOOL identifierMatch = NO;
            
            if (URL.scheme == nil) {
                schemeMatch = NO;
            }
            else if (obj.scheme != nil) {
                NSRegularExpression *schemeExpression = [[NSRegularExpression alloc]
                                                         initWithPattern:obj.scheme
                                                         options:NSRegularExpressionCaseInsensitive
                                                         error:nil];
                schemeMatch = [schemeExpression numberOfMatchesInString:URL.scheme
                                                                options:NSMatchingReportCompletion
                                                                  range:NSMakeRange(0, URL.scheme.length)];
            }
            else {
                schemeMatch = YES;
            }
            
            if (URL.host == nil) {
                identifierMatch = NO;
            }
            else if (obj.identifier != nil) {
                NSRegularExpression *identifierExpression = [[NSRegularExpression alloc]
                                                             initWithPattern:obj.identifier
                                                             options:NSRegularExpressionCaseInsensitive
                                                             error:nil];
                identifierMatch = [identifierExpression numberOfMatchesInString:URL.host
                                                                        options:NSMatchingReportCompletion
                                                                          range:NSMakeRange(0, URL.host.length)];
            }
            if (schemeMatch && identifierMatch) {
                node = obj;
                *stop = YES;
            }
        }
    }];
    return node;
}

@end
