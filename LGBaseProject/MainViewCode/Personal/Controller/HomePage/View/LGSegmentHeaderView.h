//
//  LGSegmentHeaderView.h
//  LGBaseProject
//
//  Created by loghm on 2018/10/24.
//  Copyright © 2018 loghm. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const SegmentHeaderViewHeight;

NS_ASSUME_NONNULL_BEGIN

@interface SegmentHeaderViewCollectionViewCell : UICollectionViewCell

@property (nonatomic, readonly, strong) UILabel *titleLabel;

@end;

@interface LGSegmentHeaderView : UIView

@property (nonatomic, assign) NSUInteger defaultSelectedIndex;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, copy) void (^selectedItemHelper)(NSUInteger index);

- (void)changeItemWithTargetIndex:(NSUInteger)targetIndex;
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

@end

NS_ASSUME_NONNULL_END
