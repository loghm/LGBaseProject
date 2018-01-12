//
//  NSObject+FM_Subscript.m
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright (c) 2015年 MeiMei. All rights reserved.
//

#import "NSObject+FM_Subscript.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSObject (FM_Subscript)
- (id)objectAtIndexedSubscript:(NSUInteger)index
{
    if ([self respondsToSelector:@selector(objectAtIndex:)] && [self respondsToSelector:@selector(count)]) {
        id unself = self;
        NSUInteger count = [unself count];
        if (index < count) {
            return [unself objectAtIndex:index];
        }
    }
    return nil;
}
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index
{
    if (object == nil) {
        return;
    }
    if ([self respondsToSelector:@selector(replaceObjectAtIndex:withObject:)] &&
        [self respondsToSelector:@selector(count)]) {
        id unself = self;

        NSUInteger count = [unself count];
        if (index < count) {
            [unself replaceObjectAtIndex:index withObject:object];
        }
        else if ([self respondsToSelector:@selector(addObject:)]) {
            [unself addObject:object];
        }
    }
}
- (id)objectForKeyedSubscript:(id)key
{
    if ([self respondsToSelector:@selector(objectForKey:)]) {
        id unself = self;
        return [unself objectForKey:key];
    }
    return nil;
}
- (void)setObject:(id)object forKeyedSubscript:(id)key
{
    if (key == nil) {
        return;
    }

    if ([self respondsToSelector:@selector(setObject:forKey:)]) {
        id unself = self;
        if (object) {
            [unself setObject:object forKey:key];
        }
        else if ([unself respondsToSelector:@selector(removeObjectForKey:)]) {
            [unself removeObjectForKey:key];
        }
    }
}

- (BOOL)containsString:(NSString*)aString
{
    if ([self respondsToSelector:@selector(rangeOfString:)]) {
        if ([(id)self rangeOfString:aString].length > 0) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)_accessibilityShouldSwapReceiverWithQuickSpeakPasteboard
{
    return NO;
}
@end

@implementation NSArray (FM_Subscript)
- (id)fm_safeInitWithObjects:(const id[])objects count:(NSUInteger)cnt
{
    for (int i = 0; i < cnt; i++) {
        if (objects[i] == nil) {
#if IS_TEST
            if (isSimulator) {
                [[MTStatusBarOverlay sharedOverlay] postFinishMessage:@"Array初始化错误..." duration:2];
            }
#endif
            return nil;
        }
    }

    return [self fm_safeInitWithObjects:objects count:cnt];
}
- (id)objectAtIndexedSubscript:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}
@end
@implementation NSMutableArray (FM_Subscript)
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index
{
    if (object == nil) {
        return;
    }
    if (index < self.count) {
        [self replaceObjectAtIndex:index withObject:object];
    }
    else {
        [self addObject:object];
    }
}
@end

@implementation NSDictionary (FM_Subscript)

- (instancetype)fm_safeInitWithObjects:(const id[])objects forKeys:(const id<NSCopying>[])keys count:(NSUInteger)cnt
{
    for (int i = 0; i < cnt; i++) {
        if (objects[i] == nil || keys[i] == nil) {
#if IS_TEST
            if (isSimulator) {
                [[MTStatusBarOverlay sharedOverlay] postFinishMessage:@"Dictionary初始化错误..." duration:2];
            }
#endif
            return nil;
        }
    }
    return [self fm_safeInitWithObjects:objects forKeys:keys count:cnt];
}
- (id)objectForKeyedSubscript:(id)key
{
    id value = [self objectForKey:key];
    if (value == [NSNull null] && [key isKindOfClass:[NSString class]]) {
        return nil;
    }
    return value;
}
@end
@implementation NSMutableDictionary (FM_Subscript)
- (void)setObject:(id)object forKeyedSubscript:(id)key
{
    if (key == nil) {
        return;
    }

    if (object) {
        [self setObject:object forKey:key];
    }
    else {
        [self removeObjectForKey:key];
    }
}
@end
@implementation NSMapTable (FM_Subscript)
- (id)objectForKeyedSubscript:(id)key
{
    if (key) {
        return [self objectForKey:key];
    }
    return nil;
}
- (void)setObject:(id)object forKeyedSubscript:(id)key
{
    if (key == nil)
        return;

    if (object) {
        [self setObject:object forKey:key];
    }
    else {
        [self removeObjectForKey:key];
    }
}
@end

@implementation NSUserDefaults (FM_Subscript)
- (id)objectForKeyedSubscript:(id)key
{
    if (key) {
        return [self objectForKey:key];
    }
    return nil;
}
- (void)setObject:(id)object forKeyedSubscript:(id)key
{
    if (key == nil)
        return;

    if (object) {
        [self setObject:object forKey:key];
    }
    else {
        [self removeObjectForKey:key];
    }
}
@end
@implementation NSCache (FM_Subscript)
- (id)objectForKeyedSubscript:(id)key
{
    if (key) {
        return [self objectForKey:key];
    }
    return nil;
}
- (void)setObject:(id)object forKeyedSubscript:(id)key
{
    if (key == nil)
        return;

    if (object) {
        [self setObject:object forKey:key];
    }
    else {
        [self removeObjectForKey:key];
    }
}
@end

@implementation NSObject (FM_Swizzle)
+ (BOOL)fm_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_
{
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (!origMethod) {
        return NO;
    }
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (!altMethod) {
        return NO;
    }

    class_addMethod(self,
        origSel_,
        class_getMethodImplementation(self, origSel_),
        method_getTypeEncoding(origMethod));
    class_addMethod(self,
        altSel_,
        class_getMethodImplementation(self, altSel_),
        method_getTypeEncoding(altMethod));

    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));

    return YES;
}

+ (BOOL)fm_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_
{
    return [object_getClass((id)self) fm_swizzleMethod:origSel_ withMethod:altSel_ error:error_];
}

+ (void)load
{
    [objc_getClass("__NSPlaceholderArray") fm_swizzleMethod:@selector(initWithObjects:count:) withMethod:@selector(fm_safeInitWithObjects:count:) error:nil];

    [objc_getClass("__NSPlaceholderDictionary") fm_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(fm_safeInitWithObjects:forKeys:count:) error:nil];
}
@end

@implementation NSProxy (fM_Swizzle)
+ (BOOL)fm_swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_
{
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (!origMethod) {
        return NO;
    }
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (!altMethod) {
        return NO;
    }
    
    class_addMethod(self,
                    origSel_,
                    class_getMethodImplementation(self, origSel_),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel_,
                    class_getMethodImplementation(self, altSel_),
                    method_getTypeEncoding(altMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));
    
    return YES;
}

+ (BOOL)fm_swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_
{
    return [object_getClass((id)self) fm_swizzleMethod:origSel_ withMethod:altSel_ error:error_];
}
@end

@implementation NSString (FM_FixFormatError)

+ (NSString*)stringWithInteger:(NSInteger)integer
{
    return [NSNumber numberWithInteger:integer].stringValue;
}

+ (NSString*)stringWithUInteger:(NSUInteger)integer
{
    return [NSNumber numberWithUnsignedInteger:integer].stringValue;
}

+ (NSString*)stringWithFloat:(CGFloat)f
{
    return [NSNumber numberWithFloat:f].stringValue;
}

+ (NSString*)stringWithInt:(int)number
{
    return [NSNumber numberWithInt:number].stringValue;
}

- (NSString*)stringValue
{
    return self.description;
}
- (BOOL)isEqualToNumber:(NSNumber*)number
{
    NSString *temp = [number stringValue];
    return [self isEqualToString:temp];
}
- (id)objectForKey:(NSString*)key
{
    return self;
}
@end

@implementation UIImagePickerController (FM_FixBugForBK)
+ (void)bk_registerDynamicDelegate
{
}
+ (void)bk_linkDelegateMethods:(NSDictionary*)dictionary
{
}
@end

static void* FMKVCMapKey = &FMKVCMapKey;

@implementation NSObject (FM_KVC)
+(void)load
{
    [NSObject fm_swizzleMethod:@selector(setValue:forUndefinedKey:) withMethod:@selector(fm_swizzleSetValue:forUndefinedKey:) error:nil];
    [NSObject fm_swizzleMethod:@selector(valueForUndefinedKey:) withMethod:@selector(fm_swizzleValueForUndefinedKey:) error:nil];
}
-(void)fm_swizzleSetValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key hasPrefix:@"fm_"])
    {
        [self fmkvc_setValue:value forKey:key];
    }
    else
    {
        [self fm_swizzleSetValue:value forUndefinedKey:key];
    }
}
-(id)fm_swizzleValueForUndefinedKey:(NSString *)key
{
    if ([key hasPrefix:@"fm_"])
    {
       return [self fmkvc_valueForKey:key];
    }
    else
    {
        return [self fm_swizzleValueForUndefinedKey:key];
    }
}
- (id)fmkvc_valueForKey:(NSString*)key
{
    if (key) {
        NSMutableDictionary* dic = objc_getAssociatedObject(self, FMKVCMapKey);
        if (dic) {
            return dic[key];
        }
    }

    return nil;
}
- (void)fmkvc_setValue:(id)value forKey:(NSString*)key
{
    if (key) {
        NSMutableDictionary* dic = objc_getAssociatedObject(self, FMKVCMapKey);
        if (dic == nil) {
            dic = [NSMutableDictionary dictionary];
            objc_setAssociatedObject(self, FMKVCMapKey, dic, OBJC_ASSOCIATION_RETAIN);
        }
        if (value) {
            [dic setObject:value forKey:key];
        }
        else {
            [dic removeObjectForKey:key];
        }
    }
}


- (void)fm_setPropertyWithDictionary:(NSDictionary*)dictionary
{
    [self fm_setPropertyWithDictionary:dictionary filter:nil];
}
- (void)fm_setPropertyWithDictionary:(NSDictionary*)dictionary filter:(NSString*)filter, ...
{
    NSMutableDictionary* keyValues = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    
    va_list list;
    va_start(list, filter);
    NSString* filterObject = filter;
    while (filterObject) {
        [keyValues removeObjectForKey:filterObject];
        filterObject = va_arg(list, NSString*);
    }
    va_end(list);
    
    [keyValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        id value = [self fm_valueWithSetPropertyObject:obj];
        [self setValue:value forKeyPath:key];
    }];
}
-(id)fm_valueWithSetPropertyObject:(id)obj
{
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSString* className = [obj objectForKey:@".class"];
        if (className) {
            id value = [[NSClassFromString(className) alloc] init];
            
            NSDictionary* params = [obj objectForKey:@".params"];
            [value fm_setPropertyWithDictionary:params filter:nil];
            
            return value;
        }
    }
    return obj;
}

@end


@implementation NSObject(FM_Print)
+(NSString *)fm_printAllMethods
{
#ifndef DEBUG
    return @"";
#else
    Class clazz = self;
    NSMutableString* sb = [NSMutableString stringWithFormat:@"\n <%@> :\n", NSStringFromClass(clazz)];
    [self fm_mutableString:sb appendMethodsWithClass:clazz pre:@"-"];
    [self fm_mutableString:sb appendMethodsWithClass:object_getClass((id)clazz) pre:@"+"];
    NSLog(@"%@",sb);
    return sb;
#endif
}
+(NSString *)fm_mutableString:(NSMutableString*)sb appendMethodsWithClass:(Class)clazz pre:(NSString*)preString
{
    unsigned int count = 0;
    Method* list = class_copyMethodList(clazz, &count);
    for (int i =0 ; i<count; i++) {
        Method m = list[i];
        
        [sb appendString:preString];
        
        SEL sel = method_getName(m);
        [sb appendString:NSStringFromSelector(sel)];
        
        [sb appendString:@"  r|"];
        const char* returnTypeChar = method_copyReturnType(m);
        NSString* returnType = [[NSString alloc] initWithCString:returnTypeChar encoding:NSUTF8StringEncoding];
        [sb appendString:returnType];
        
        [sb appendString:@"  arg|"];
        int argCount = method_getNumberOfArguments(m);
        
        for (int argIndex=0; argIndex < argCount; argIndex ++) {
            const char* argTypeChar = method_copyArgumentType(m, argIndex);
            NSString* argType = [[NSString alloc] initWithCString:argTypeChar encoding:NSUTF8StringEncoding];
            if (argIndex > 0) {
                [sb appendString:@","];
            }
            [sb appendString:argType];
        }
        [sb appendString:@"\n"];
    }
    return sb;
}

-(NSString *)fm_printAllPropertys
{
    return [self fm_printAllPropertys:NO];
}
-(NSString*)fm_getAllPropertys
{
    return [self fm_getAllPropertys:NO];

}

-(NSString *)fm_getAllPropertys:(BOOL)isContainSuper
{

    Class clazz = [self class];
    NSMutableString* sb = [NSMutableString stringWithFormat:@"\n <%@> :\n", NSStringFromClass(clazz)];
    [self fm_mutableString:sb appendPropertyStringWithClass:clazz containParent:isContainSuper];
    return sb;
}

-(NSString *)fm_printAllPropertys:(BOOL)isContainSuper
{
#ifndef DEBUG
    return @"";
#else
    Class clazz = [self class];
    NSMutableString* sb = [NSMutableString stringWithFormat:@"\n <%@> :\n", NSStringFromClass(clazz)];
    [self fm_mutableString:sb appendPropertyStringWithClass:clazz containParent:isContainSuper];
    NSLog(@"%@",sb);
    return sb;
#endif
}
-(void)fm_mutableString:(NSMutableString*)sb appendPropertyStringWithClass:(Class)clazz containParent:(BOOL)containParent
{
    if (clazz == [NSObject class]) {
        return;
    }
    
    unsigned int outCount = 0, i = 0;
    objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if (![propertyName isEqualToString:@"caretRect"]) {
            [sb appendFormat:@" %@ : %@ \n",propertyName,[self valueForKey:propertyName]];
        }
    }
    free(properties);
    
    if(containParent) {
        [self fm_mutableString:sb appendPropertyStringWithClass:clazz.superclass containParent:containParent];
    }
}
@end


@implementation NSNumber (FM_FixFormatError)

- (BOOL)isEqualToString:(NSString *)aString
{
    return [[self stringValue] isEqualToString:aString];
}

@end

@implementation NSObject (FM_Coding)

+ (void)fmCodingObject:(id)object withCOder:(NSCoder*)aDecoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([object class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [aDecoder decodeObjectForKey:key];
        
        // 设置到成员变量身上
        [object setValue:value forKey:key];
    }
    
    free(ivars);
}

+ (void)fmEncodingObject:(id)object WithCoder:(NSCoder*)aCoder
{
    unsigned int count = 0; Ivar *ivars = class_copyIvarList([object class], &count);
    
    for (int i = 0; i<count; i++)
    {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        // 查看成员变量
        const char *name = ivar_getName(ivar);
        
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [object valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(ivars);
}

@end
