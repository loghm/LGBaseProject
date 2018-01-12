//
//  NSData+FMRouterTrans.m
//  MyStoryTest
//
//  Created by 陈炜来 on 15/11/30.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import "NSData+FMRouterTrans.h"

@implementation NSData (FMRouterTrans)
+ (NSArray*)FM_arrayWithJSONData:(NSData*)data
{
    id JSON = [data FM_jsonObject];
    if ([JSON isKindOfClass:[NSArray class]]) {
        return JSON;
    }
    return nil;
}
+ (NSDictionary*)FM_dictionaryWithJSONData:(NSData*)data
{
    id JSON = [data FM_jsonObject];
    if ([JSON isKindOfClass:[NSDictionary class]]) {
        return JSON;
    }
    return nil;
}

@end
@implementation NSObject (FMRouterDataConvert)

- (id)FM_jsonObjectFromJSONData
{
    NSData* data = (NSData*)self;
    if (data.length > 0) {
        NSError* error = nil;
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
#if IS_TEST
            ///模拟器直接断言
            if (isSimulator) {
                NSAssert(NO, @"\n jsonData 解析出错 %@ \n", [error debugDescription]);
            }
            else {
                ///测试情况下 弹出黑窗
                [UIWindow FM_showTextHUD:@"jsonData 解析出错, 请告诉开发人员 \n %@ \n",[[NSString alloc] initWithData:(NSData*)self encoding:NSUTF8StringEncoding],nil];
            }
#endif
        }
        return object;
    }
    return nil;
}
- (id)FM_jsonObjectFromJSONString
{
    NSString* string = (NSString*)self;
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data FM_jsonObjectFromJSONData];
}
- (id)FM_jsonObject
{
    if ([self isKindOfClass:[NSData class]]) {
        return [self FM_jsonObjectFromJSONData];
    }
    if ([self isKindOfClass:[NSString class]]) {
        return [self FM_jsonObjectFromJSONString];
    }
    return nil;
}
- (NSData*)FM_jsonData
{
    if ([self isKindOfClass:[NSNull class]])
        return nil;
    
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError* error = nil;
        NSData* data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        if (error) {
#if IS_TEST
            ///模拟器直接断言
            if (isSimulator) {
                NSAssert(NO, @"\n object 转换 jsonData 出错: %@ \n", error.debugDescription);
            }
            else {
                ///测试情况下 弹出黑窗
                [UIWindow FM_showTextHUD:@"object 转换 jsonData 出错, 请告诉开发人员 \n %@ \n",self.debugDescription,nil];
            }
#endif
        }
        return data;
    }
    return nil;
}
- (NSString*)FM_jsonString
{
    NSData* data = [self FM_jsonData];
    if (data.length > 0) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}
@end