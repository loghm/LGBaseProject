//
//  FMCaptionView.h
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright (c) 2015年 MeiMei. All rights reserved.
//  请求失败的时候覆盖的View

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FMCaptionViewState) {
    ///隐藏
    FMCaptionViewStateHidden           = 0,

    ///加载中
    FMCaptionViewStateLoading,
    
    ///点击重试
    FMCaptionViewStateRetry,
    
    ///无数据
    FMCaptionViewStateNoResult,
    
    ///用户还没有收藏数据
    FMCaptionViewStateNoUserData,
};

@interface FMCaptionView : UIView

+ (instancetype)addToView:(UIView *)view;

+ (instancetype)addToView:(UIView *)view show:(BOOL)show;

+ (instancetype)captionFromView:(UIView *)view;

+ (void)fm_setCaptionViewClass:(Class)captionViewClass;

+ (BOOL)removeFromView:(UIView *)view;

/**
 *  @brief 修改状态
 */
@property(assign,nonatomic) FMCaptionViewState state;


/**
 *  @brief 同时修改文案和状态
 */
- (void)setTitle:(NSString *)title andState:(FMCaptionViewState)state;
- (void)setState:(FMCaptionViewState)state andTitle:(NSString*)title;


@property(copy, nonatomic) void(^retryBlock)(void);

/**
 *  @brief  所有状态下 点击都重新设置为 loading 状态。
            默认为NO   只有 点击重试状态  才会去刷新
 */
@property(assign,nonatomic)BOOL allTapToRetry;

@property(strong,nonatomic)UIImageView* imageView;
@property(strong,nonatomic)UILabel* titleLabel;
@property(strong,nonatomic)UIButton* button;

- (void)show;

- (void)hide;

- (void)setTitle:(NSString *)title forState:(FMCaptionViewState)state;
- (NSString*)titleForState:(FMCaptionViewState)state;

- (void)setImage:(UIImage *)image forState:(FMCaptionViewState)state;
- (UIImage *)imageForState:(FMCaptionViewState)state;

/**
 *  @brief title nil to hidden
 */
- (void)setButtonTitle:(NSString *)title;

@end
