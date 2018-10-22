//
//  DatePicker.h
//  HybridApp
//
//  Created by iOSgo on 2017/9/8.
//  Copyright © 2017年 iOSgo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatetimePicker : UIView

@property (nonatomic , strong) UIColor *fontColor;//字体颜色


@property (nonatomic, copy) void(^dateBlock)(NSString *dateString, NSString *timeString);

@property (nonatomic, copy) void(^cancelBlock)();


+ (DatetimePicker *)createDatetimePicker;

- (void)show;

@end
