//
//  NSString+FMRMBString.m
//  ForMan
//
//  Created by 陈炜来 on 16/6/30.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "NSString+FMRMBString.h"

@implementation NSString (FMRMBString)
- (NSString*)RMBStringValue
{
    return [@"￥" stringByAppendingString:self];
}

@end
