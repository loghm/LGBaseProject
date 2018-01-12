//
//  NSNumber+FMRMBString.m
//  ForMan
//
//  Created by chw on 16/6/23.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "NSNumber+FMRMBString.h"

@implementation NSNumber (FMRMBString)

- (NSString*)RMBStringValue
{
    CGFloat f = [self floatValue];
    NSString *string = [NSString stringWithFormat:@"%.0f", f];
    return [@"￥" stringByAppendingString:string];
}

@end
