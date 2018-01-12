//
//  FMRNode.m
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import "FMRNode.h"

@implementation FMRNode

- (instancetype)initWithIdentifier:(NSString *)identifier
                    executingBlock:(FMRNodeExecutingBlock)executingBlock {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.executingBlock = executingBlock;
    }
    return self;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
                            scheme:(NSString *)scheme
                        usePattern:(BOOL)usePattern
                    executingBlock:(FMRNodeExecutingBlock)executingBlock {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.scheme = scheme;
        self.usePattern = usePattern;
        self.executingBlock = executingBlock;
    }
    return self;
}
-(void)setIdentifier:(NSString *)identifier
{
    if (!identifier) {
        _identifier=@".*?";
    }
    else
    {
        _identifier=identifier;
    }
    
}


@end
