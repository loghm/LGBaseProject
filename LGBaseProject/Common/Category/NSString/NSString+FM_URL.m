//
//  NSString+FM_URL.m
//  FM_ViewKit
//
//  Created by dm on 15/5/23.
//  Copyright (c) 2015年 FM. All rights reserved.
//

#import "NSString+FM_URL.h"
#import "NSString+FMPublic.h"


@implementation NSString (FM_URL)

- (NSString*)fm_URLEncodedString
{
    static CFStringRef toEscape = CFSTR(":/=,!$&'()*+;[]@#?%");
    return (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
        (__bridge CFStringRef)self,
        NULL,
        toEscape,
        kCFStringEncodingUTF8);
}

- (NSString*)fm_URLDecodedString
{
    return (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
        (__bridge CFStringRef)self,
        CFSTR(""),
        kCFStringEncodingUTF8);
}
- (NSString*)fm_replaceUnicode
{
    NSString* tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString* tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString* tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData* tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:nil error:nil];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}



@end
