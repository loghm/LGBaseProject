//
//  UIApplication+FMRSwizzle.h
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (FMRSwizzle)

+ (void)FMR_swizzleUIApplicationMethod;

@end
