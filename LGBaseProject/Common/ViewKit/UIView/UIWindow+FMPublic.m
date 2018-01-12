//
//  UIWindow+FMViewKit.m
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright (c) 2015年 FM. All rights reserved.
//

#import "UIWindow+FMPublic.h"

@implementation UIWindow (FMPublic)
+(UIWindow *)fm_getShowTopWindow
{
    UIWindow *window = nil;
    
    NSArray *windows = [UIApplication sharedApplication].windows;
//    for (UIWindow *uiWindow in windows)
//    {
//        //有inputView或者键盘时，避免提示被挡住，应该选择这个 UITextEffectsWindow 来显示
//        if ([NSStringFromClass(uiWindow.class) isEqualToString:@"UITextEffectsWindow"])
//        {
//            window = uiWindow;
//            break;
//        }
//    }
    if (!window)
    {
        window = [[UIApplication sharedApplication] keyWindow];
    }
    return window;
}
-(BOOL)fm_hasKeyboardPeripheralGridCell
{
    for (UIView* subview in self.subviews)
    {
        if([subview isKindOfClass:NSClassFromString(@"UIPeripheralHostView")])
        {
            return [UIWindow fm_findSubviewKeyboardPeripheralGridCell:subview];
        }
    }
    return NO;
}
///是否有键盘弹起来的gridview
+ (BOOL)fm_findSubviewKeyboardPeripheralGridCell:(UIView*)view
{
    Class UIKeyboardCandidateGridCellClass = NSClassFromString(@"UIKeyboardCandidateGridCell");
    Class UIKeyboardCandidateBarShadowViewClass = NSClassFromString(@"UIKeyboardCandidateBarShadowView");
    
    for (UIView* subview in view.subviews)
    {
        if([UIDevice currentDevice].systemVersion.floatValue >= 6)
        {
            if([subview isKindOfClass:UIKeyboardCandidateGridCellClass])
            {
                return YES;
            }
        }
        else
        {
            if([subview isKindOfClass:UIKeyboardCandidateBarShadowViewClass])
            {
                return YES;
            }
        }
        if([self fm_findSubviewKeyboardPeripheralGridCell:subview])
        {
            return YES;
        }
    }
    return NO;
}

@end
