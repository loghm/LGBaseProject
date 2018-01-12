//
//  FMLayoutManager.h
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FMLayoutManagerInstance     [FMLayoutManager shareInstance]

#define FMLayoutManagerLeftMargin   [FMLayoutManager shareInstance].fmLeftMargin
#define FMLayoutManagerRightMargin  [FMLayoutManager shareInstance].fmRightMargin

@interface FMLayoutManager : NSObject

+ (instancetype)shareInstance;

/**
 * @brief 默认尺寸的基数，按找不同屏幕的尺寸不一样.默认按照4.7寸的屏来设置
 *
 */
@property (nonatomic,assign) CGFloat fmWidthBase;
@property (nonatomic,assign) CGFloat fmHeightBase;
@property (nonatomic,assign) CGFloat fmFontBase;

@property (nonatomic, assign) CGFloat fmLeftMargin;         //默认的左边距
@property (nonatomic, assign) CGFloat fmRightMargin;        //默认的右边距

@property (nonatomic, assign) CGFloat fmTopBarHeight;       //默认64，navBar+statusBar高度
@property (nonatomic, assign) CGFloat fmBottomBarHeight;    //默认49

@property (nonatomic, strong) UIFont *fmNavTitleFont;

#pragma mark - MQFont
@property (nonatomic,assign) CGFloat fmFont_9;
@property (nonatomic,assign) CGFloat fmFont_10;
@property (nonatomic,assign) CGFloat fmFont_11;
@property (nonatomic,assign) CGFloat fmFont_12;
@property (nonatomic,assign) CGFloat fmFont_13;
@property (nonatomic,assign) CGFloat fmFont_14;
@property (nonatomic,assign) CGFloat fmFont_15;
@property (nonatomic,assign) CGFloat fmFont_16;
@property (nonatomic,assign) CGFloat fmFont_17;
@property (nonatomic,assign) CGFloat fmFont_18;
@property (nonatomic,assign) CGFloat fmFont_19;
@property (nonatomic,assign) CGFloat fmFont_20;
@property (nonatomic,assign) CGFloat fmFont_22;
@property (nonatomic,assign) CGFloat fmFont_23;
@property (nonatomic,assign) CGFloat fmFont_24;
@property (nonatomic,assign) CGFloat fmFont_27;
@property (nonatomic,assign) CGFloat fmFont_29;
@property (nonatomic,assign) CGFloat fmFont_30;
@property (nonatomic,assign) CGFloat fmFont_33;
@property (nonatomic,assign) CGFloat fmFont_36;
@property (nonatomic,assign) CGFloat fmFont_55;

@property (nonatomic,strong) UIFont *fmDefaultFont_9;
@property (nonatomic,strong) UIFont *fmDefaultFont_10;
@property (nonatomic,strong) UIFont *fmDefaultFont_11;
@property (nonatomic,strong) UIFont *fmDefaultFont_12;
@property (nonatomic,strong) UIFont *fmDefaultFont_13;
@property (nonatomic,strong) UIFont *fmDefaultFont_14;
@property (nonatomic,strong) UIFont *fmDefaultFont_15;
@property (nonatomic,strong) UIFont *fmDefaultFont_16;
@property (nonatomic,strong) UIFont *fmDefaultFont_17;
@property (nonatomic,strong) UIFont *fmDefaultFont_18;
@property (nonatomic,strong) UIFont *fmDefaultFont_19;
@property (nonatomic,strong) UIFont *fmDefaultFont_20;
@property (nonatomic,strong) UIFont *fmDefaultFont_22;
@property (nonatomic,strong) UIFont *fmDefaultFont_23;
@property (nonatomic,strong) UIFont *fmDefaultFont_24;
@property (nonatomic,strong) UIFont *fmDefaultFont_27;
@property (nonatomic,strong) UIFont *fmDefaultFont_29;
@property (nonatomic,strong) UIFont *fmDefaultFont_33;
@property (nonatomic,strong) UIFont *fmDefaultFont_36;
@property (nonatomic,strong) UIFont *fmDefaultFont_55;

@property (nonatomic,strong) UIFont *fmBlodFont_9;
@property (nonatomic,strong) UIFont *fmBlodFont_10;
@property (nonatomic,strong) UIFont *fmBlodFont_11;
@property (nonatomic,strong) UIFont *fmBlodFont_12;
@property (nonatomic,strong) UIFont *fmBlodFont_13;
@property (nonatomic,strong) UIFont *fmBlodFont_14;
@property (nonatomic,strong) UIFont *fmBlodFont_15;
@property (nonatomic,strong) UIFont *fmBlodFont_16;
@property (nonatomic,strong) UIFont *fmBlodFont_17;
@property (nonatomic,strong) UIFont *fmBlodFont_18;
@property (nonatomic,strong) UIFont *fmBlodFont_20;
@property (nonatomic,strong) UIFont *fmBlodFont_22;
@property (nonatomic,strong) UIFont *fmBlodFont_23;
@property (nonatomic,strong) UIFont *fmBlodFont_24;
@property (nonatomic,strong) UIFont *fmBlodFont_27;
@property (nonatomic,strong) UIFont *fmBlodFont_30;

@end
