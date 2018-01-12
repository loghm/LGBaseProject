//
//  UIWindow+FMViewKit.h
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright (c) 2015年 FM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (FMPublic)

///当前显示的最顶层window
+(UIWindow*)fm_getShowTopWindow;

///是否有键盘弹起来的多选的gridview
- (BOOL)fm_hasKeyboardPeripheralGridCell;

@end
