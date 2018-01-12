//
//  UIAlertView+FMPublic.h
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright (c) 2015年 FM. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
typedef void(^UIAlertViewHandler)(UIAlertView *alertView, NSInteger buttonIndex);
#pragma clang diagnostic pop

@interface UIAlertView (FMPublic)

+ (void)fm_quickAlert:(NSString *)title;

+ (void)fm_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(UIAlertViewHandler)handler;



+ (void)fm_quickErrorAlert:(NSError *)error isShowWhileRelease:(BOOL)isShow;

- (void)fm_showWithHandler:(UIAlertViewHandler)handler;


@end
