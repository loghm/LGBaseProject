//
//  MMUserModel.m
//  MeiMei
//
//  Created by chw on 15/11/24.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "FMUserModel.h"
//#import "NSDate+FM_DateFormat.h"
#import "NSObject+MJKeyValue.h"

@implementation FMUserModel

- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init])
    {
        if (decoder == nil)
        {
            self.loginType = FMLoginTypeNone;
            self.isMarry = FMMarryStateUnknown;
            return self;
        }
        [NSObject fmCodingObject:self withCOder:decoder];
        self.inviteReward = nil;

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
    [NSObject fmEncodingObject:self WithCoder:coder];
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.isMarry = FMMarryStateUnknown;
        self.loginType = FMLoginTypeNone;
    }
    return self;
}


- (NSString*)loginTypeString
{
    NSString *string = nil;
    switch (self.loginType) {
        case FMLoginTypeWeiBo:
//            string = FMString(@"FMString_UserInfo_WeiboLogin");
            break;
        case FMLoginTypeQQ:
//            string = FMString(@"FMString_UserInfo_QQLogin");
            break;
        case FMLoginTypeWeChat:
//            string = FMString(@"FMString_UserInfo_WechatLogin");
            break;
        case FMLoginTypeMobile:
//            string = FMString(@"FMString_UserInfo_MobileLogin");
            break;
        default:
            break;
    }
    return string;
}

- (void)setIs_check:(BOOL)is_check
{
    _is_check = is_check;
    if (is_check) {
//        self.checkDay = [[NSDate fm_today] fm_getLocalTime];
    }
}

- (BOOL)getTodayIsCheck
{
    if (_is_check) {
        _is_check = [self.checkDay isToday];
    }
    return _is_check;
}

//- (void)resetModelData
//{
//    [NSObject fmCodingObject:self withCOder:nil];
//    self.inviteReward = nil;
//    return;
//    Class clazz = [self class];
//    NSArray *allowedPropertyNames = [clazz mj_totalAllowedPropertyNames];
//    NSArray *ignoredPropertyNames = [clazz mj_totalIgnoredPropertyNames];
//    
//    //通过封装的方法回调一个通过运行时编写的，用于返回属性列表的方法。
//    [clazz mj_enumerateProperties:^(MJProperty *property, BOOL *stop) {
//        @try {
//            // 0.检测是否被忽略
//            if (allowedPropertyNames.count && ![allowedPropertyNames containsObject:property.name]) return;
//            if ([ignoredPropertyNames containsObject:property.name]) return;
//            
//            // 1.取出属性值
//            id value;
//            
//            // 2.复杂处理
//            MJPropertyType *type = property.type;
//            Class propertyClass = type.typeClass;
//            Class objectClass = [property objectClassInArrayForClass:[self class]];
//            
//            // 不可变 -> 可变处理
//            if (propertyClass == [NSMutableArray class] && [value isKindOfClass:[NSArray class]]) {
//                value = [[NSMutableArray alloc] init];
//            } else if (propertyClass == [NSMutableDictionary class] && [value isKindOfClass:[NSDictionary class]]) {
//                value = [[NSMutableDictionary alloc] init];
//            } else if (propertyClass == [NSMutableString class] && [value isKindOfClass:[NSString class]]) {
//                value = [NSMutableString stringWithString:@""];
//            } else if (propertyClass == [NSMutableData class] && [value isKindOfClass:[NSData class]]) {
//                value = [[NSMutableData alloc] init];
//            }
//            
//            if (!type.isFromFoundation && propertyClass) { // 模型属性
//                value = @"";
//            } else if (objectClass) {
//                if (objectClass == [NSURL class] && [value isKindOfClass:[NSArray class]]) {
//                    // string array -> url array
//                    NSMutableArray *urlArray = [NSMutableArray array];
//                    for (NSString *string in value) {
//                        if (![string isKindOfClass:[NSString class]]) continue;
//                        [urlArray addObject:string.mj_url];
//                    }
//                    value = urlArray;
//                } else { // 字典数组-->模型数组
//                    value = @"";
//                }
//            } else {
//                if (propertyClass == [NSString class]) {
//                    if ([value isKindOfClass:[NSNumber class]]) {
//                        // NSNumber -> NSString
//                        value = [value description];
//                    } else if ([value isKindOfClass:[NSURL class]]) {
//                        // NSURL -> NSString
//                        value = [value absoluteString];
//                    }
//                } else if ([value isKindOfClass:[NSString class]]) {
//                    if (propertyClass == [NSURL class]) {
//                        // NSString -> NSURL
//                        // 字符串转码
//                        value = [value mj_url];
//                    } else if (type.isNumberType) {
//                        NSString *oldValue = value;
//                        
//                        // NSString -> NSNumber
//                        if (type.typeClass == [NSDecimalNumber class]) {
//                            value = [NSDecimalNumber decimalNumberWithString:oldValue];
//                        } else {
//                            value = 0;
//                        }
//                        
//                        // 如果是BOOL
//                        if (type.isBoolType) {
//                            // 字符串转BOOL（字符串没有charValue方法）
//                            // 系统会调用字符串的charValue转为BOOL类型
//                            NSString *lower = [oldValue lowercaseString];
//                            if ([lower isEqualToString:@"yes"] || [lower isEqualToString:@"true"]) {
//                                value = @YES;
//                            } else if ([lower isEqualToString:@"no"] || [lower isEqualToString:@"false"]) {
//                                value = @NO;
//                            }
//                        }
//                    }
//                }
//                
//                // value和property类型不匹配
//                if (propertyClass && ![value isKindOfClass:propertyClass]) {
//                    value = nil;
//                }
//            }
//            
//            // 3.赋值
//            [property setValue:value forObject:self];
//        } @catch (NSException *exception) {
////            MJExtensionBuildError([self class], exception.reason);
//            MJExtensionLog(@"%@", exception);
//        }
//    }];
//    
//    // 转换完毕
//    if ([self respondsToSelector:@selector(mj_keyValuesDidFinishConvertingToObject)]) {
//        [self mj_keyValuesDidFinishConvertingToObject];
//    }
//
//}

@end

@implementation FMInviteRewardModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"anchor_head"]) {
        if (oldValue != nil&&oldValue!=[NSNull null])
        {
            NSString *url=(NSString *)oldValue;
            if (url.length > 0 ) {
//                NSString *prefix=[FMGlobalManager shareInstance].globalConfig.storeImageUrlPrefix;
//                url=[prefix fmSpliceURL:url];
                return url;
            }
            else{
                return oldValue;
            }
        }
        
    }
    return oldValue;
}

- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init])
    {
//        if (decoder == nil)
//        {
//            self.loginType = FMLoginTypeNone;
//            self.isMarry = FMMarryStateUnknown;
//            return self;
//        }
//        [NSObject fmCodingObject:self withCOder:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
//    [NSObject fmEncodingObject:self WithCoder:coder];
}



@end

