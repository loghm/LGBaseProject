//
//  UIAlertView+FMPublic.m
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright (c) 2015年 FM. All rights reserved.
//

#import "UIAlertView+FMPublic.h"
#import "NSObject+FM_Subscript.h"
#import "UIViewController+FMPublic.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
@interface FMAlertViewDelegateManager : NSObject
+(instancetype)shareManager;
@property(strong,nonatomic)NSMapTable* mapTable;
@end

@implementation FMAlertViewDelegateManager
+(instancetype)shareManager
{
    static FMAlertViewDelegateManager* manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsCopyIn];
    });
    return manager;
}
-(void)setAlertView:(UIAlertView*)alertView block:(UIAlertViewHandler)handler
{
    if(handler && alertView)
    {
        alertView.delegate = self;
        [_mapTable setObject:handler forKeyedSubscript:alertView];
    }
}
-(UIAlertViewHandler)handlerForAlertView:(UIAlertView*)alertView
{
    if(alertView)
    {
        return [_mapTable objectForKey:alertView];
    }
    return nil;
}
///UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertViewHandler completionHandler = [self handlerForAlertView:alertView];
    if (completionHandler != nil)
    {
        completionHandler(alertView, buttonIndex);
    }
}

@end

@implementation UIViewController(FM_AlertViewAutorotate)
- (NSUInteger)fm_alertSupportedInterfaceOrientations
{
    return [[UIViewController fm_currentTopViewController] supportedInterfaceOrientations];
}

- (BOOL)fm_alertShouldAutorotate
{
    return [[UIViewController fm_currentTopViewController] shouldAutorotate];
}
@end

@implementation UIAlertView (FMPublic)
-(void)fmswizzle_show
{
    [self fmcode_show];
}
-(void)fmcode_show
{
    NSString* title = self.title?:@"";
    NSString* message = self.message?:@"";
    
    if (title.length > 0 && message.length == 0)
    {
        message = title;
        title = @"";
    }
    self.title = title;
    self.message = message;
    
    [self fmswizzle_show];
}

+(void)load
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIAlertView fm_swizzleMethod:@selector(show) withMethod:@selector(fmswizzle_show) error:nil];
        
        Class clazz = NSClassFromString(@"_UIAlertShimPresentingViewController");
        [clazz fm_swizzleMethod:@selector(supportedInterfaceOrientations) withMethod:@selector(fm_alertSupportedInterfaceOrientations) error:nil];
        [clazz fm_swizzleMethod:@selector(shouldAutorotate) withMethod:@selector(fm_alertShouldAutorotate) error:nil];
    });
}
+(void)fm_quickAlert:(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

+(void)fm_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(UIAlertViewHandler)handler
{
    title = title?:@"";
    message = message?:@"";
    
    if (title.length > 0 && message.length == 0) {
        message = title;
        title = @"";
    }
    
    if(IOS8)
    {
        UIAlertController* alerController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        int buttonIndex = 0;
        if(cancelButtonTitle)
        {
            //字体会变粗，不用取消的了。
            [alerController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if(handler)
                {
                    handler(nil,0);
                }
            }]];
            buttonIndex = 1;
        }
        [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *button, NSUInteger idx, BOOL *stop) {
            [alerController addAction:[UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if(handler)
                {
                    handler(nil,idx + buttonIndex);
                }
            }]];
        }];
        
        UIViewController* rootVC = [UIViewController fm_currentTopViewController];
        
        Class alertVC0 = [UIAlertController class];
        Class alertVC1 = NSClassFromString(@"_UIAlertShimPresentingViewController");
        while ([rootVC isKindOfClass:alertVC0] || [rootVC isKindOfClass:alertVC1]) {
            rootVC = rootVC.presentingViewController;
        }
        [rootVC presentViewController:alerController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:nil];
        [otherButtonTitles enumerateObjectsUsingBlock:^(NSString *button, NSUInteger idx, BOOL *stop) {
            [alert addButtonWithTitle:button];
        }];
        [alert fm_showWithHandler:handler];
    }
}

- (void)fm_showWithHandler:(UIAlertViewHandler)handler
{
    [[FMAlertViewDelegateManager shareManager] setAlertView:self block:handler];
    [self show];
}
//是否在release的时候提示 简易的错误信息
+ (void)fm_quickErrorAlert:(NSError *)error isShowWhileRelease:(BOOL)isShow
{
    if (!error) {
        return;
    }
#ifdef DEBUG
    [self fm_quickAlert:[NSString stringWithFormat:@"%@",error]];
#else
    if (isShow) {
         [self fm_quickAlert:error.localizedDescription];
    }
#endif
}
@end
#pragma clang diagnostic pop
