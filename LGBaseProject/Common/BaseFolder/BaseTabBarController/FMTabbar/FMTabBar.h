//
//  FMTabBar.h
//  MeiMei
//
//  Created by 陈炜来 on 16/4/26.
//  Copyright © 2016年 MeiMei. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSUInteger FMTabbarItemsCount;
FOUNDATION_EXTERN CGFloat FMTabBarItemWidth;
@interface FMTabBar : UITabBar

//@property (nonatomic, copy) FMSenderBlock centerButtonClickBlock;

//显示小红点
- (void)showBadgeOnItemIndex:(NSInteger)index withValue:(NSInteger)value;

//隐藏小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index;

@end
