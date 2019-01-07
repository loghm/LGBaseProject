//
//  LGSegmentView.h
//  LGBaseProject
//
//  Created by loghm on 2018/10/24.
//  Copyright © 2018 loghm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGSegmentHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGSegmentView : UIView

@property (nonatomic, assign) NSUInteger selectedIndex;

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray parentController:(UIViewController *)parentController;

@end

NS_ASSUME_NONNULL_END
