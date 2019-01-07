//
//  FMLayoutManager.m
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMLayoutManager.h"

@implementation FMLayoutManager

+(instancetype)shareInstance
{
    static FMLayoutManager* shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[FMLayoutManager alloc]init];
        [shareManager fmCurrentInit];
    });
    return shareManager;
}
-(void)fmDefault
{
    self.fmWidthBase  = 1;
    self.fmHeightBase = 1;
    self.fmFontBase   = 1;
    self.fmFont_9     = 9;
    self.fmFont_10    = 10;
    self.fmFont_11    = 11;
    self.fmFont_12    = 12;
    self.fmFont_13    = 13;
    self.fmFont_14    = 14;
    self.fmFont_15    = 15;
    self.fmFont_16    = 16;
    self.fmFont_17    = 17;
    self.fmFont_18    = 18;
    self.fmFont_19    = 19;
    self.fmFont_20    = 20;
    self.fmFont_22    = 22;
    self.fmFont_23    = 23;
    self.fmFont_24    = 24;
    self.fmFont_27    = 27;
    self.fmFont_29    = 29;
    self.fmFont_30    = 30;
    self.fmFont_33    = 33;
    self.fmFont_36    = 36;
    self.fmFont_55    = 55;
    
    self.fmLeftMargin = 16;
    self.fmRightMargin = 16;
    
    if (IS_iPhoneX) {
        self.fmTopBarHeight = 88;
        self.fmBottomBarHeight = 83;
    }else {
        self.fmTopBarHeight = 64;
        self.fmBottomBarHeight = 49;
    }
}

- (void)layout{
    self.dtSafeMargin = kScreenWidthRatio * 24;
    self.dtGrayRectangleHeight = kScreenHeightRatio * 12;
    if (IS_iPhoneX) {
        self.dtNavBarHeight = 88;
        self.dtTabBarHeight = 83;
    }else {
        self.dtNavBarHeight = 64;
        self.dtTabBarHeight = 49;
    }
}

-(void)fmCurrentInit
{
    [self layout];
    [self fmDefault];
    
    //默认用4.7寸屏布局
//    if(iPhone4)
//    {
//        self.fmWidthBase  = 1;
//        self.fmHeightBase = 1;
//        self.fmFontBase   = 1;
//    }
//    else if (iPhone5)
//    {
//        self.fmWidthBase  = 1;
//        self.fmHeightBase = 1;
//        self.fmFontBase   = 1;
//        
//    }
//    else
    if (iPhone6p)
    {
        self.fmWidthBase  = 1.104;
        self.fmHeightBase = 1.104;
        self.fmFontBase   = 1.104;
        
        self.fmLeftMargin *= 1.104;
        self.fmRightMargin *= 1.104;
    }
    self.fmFont_9 = floor(self.fmFont_9*self.fmFontBase);
    self.fmFont_10 = floor(self.fmFont_10*self.fmFontBase);
    self.fmFont_11 = floor(self.fmFont_11*self.fmFontBase);
    self.fmFont_12 = floor(self.fmFont_12*self.fmFontBase);
    self.fmFont_13 = floor(self.fmFont_13*self.fmFontBase);
    self.fmFont_14 = floor(self.fmFont_14*self.fmFontBase);
    self.fmFont_15 = floor(self.fmFont_15*self.fmFontBase);
    self.fmFont_16 = floor(self.fmFont_16*self.fmFontBase);
    self.fmFont_17 = floor(self.fmFont_17*self.fmFontBase);
    self.fmFont_18 = floor(self.fmFont_18*self.fmFontBase);
    self.fmFont_19 = floor(self.fmFont_19*self.fmFontBase);
    self.fmFont_20 = floor(self.fmFont_20*self.fmFontBase);
    self.fmFont_22 = floor(self.fmFont_22*self.fmFontBase);
    self.fmFont_23 = floor(self.fmFont_23*self.fmFontBase);
    self.fmFont_24 = floor(self.fmFont_24*self.fmFontBase);
    self.fmFont_27 = floor(self.fmFont_27*self.fmFontBase);
    self.fmFont_29 = floor(self.fmFont_29*self.fmFontBase);
    self.fmFont_30 = floor(self.fmFont_30*self.fmFontBase);
    self.fmFont_33 = floor(self.fmFont_33*self.fmFontBase);
    self.fmFont_36 = floor(self.fmFont_33*self.fmFontBase);
    self.fmFont_55 = floor(self.fmFont_55*self.fmFontBase);
    
    self.fmNavTitleFont = [UIFont systemFontOfSize:self.fmFont_18];
    
    [self fmResetFont:nil];
}

-(void)fmResetFont:(NSString*)fontName
{
    if(fontName)
    {
        self.fmDefaultFont_9 = [UIFont fontWithName:fontName size:self.fmFont_9];
        self.fmDefaultFont_10 = [UIFont fontWithName:fontName size:self.fmFont_10];
        self.fmDefaultFont_11 = [UIFont fontWithName:fontName size:self.fmFont_11];
        self.fmDefaultFont_12 = [UIFont fontWithName:fontName size:self.fmFont_12];
        self.fmDefaultFont_13 = [UIFont fontWithName:fontName size:self.fmFont_13];
        self.fmDefaultFont_14 = [UIFont fontWithName:fontName size:self.fmFont_14];
        self.fmDefaultFont_15 = [UIFont fontWithName:fontName size:self.fmFont_15];
        self.fmDefaultFont_16 = [UIFont fontWithName:fontName size:self.fmFont_16];
        self.fmDefaultFont_17 = [UIFont fontWithName:fontName size:self.fmFont_17];
        self.fmDefaultFont_18 = [UIFont fontWithName:fontName size:self.fmFont_18];
        self.fmDefaultFont_19 = [UIFont fontWithName:fontName size:self.fmFont_19];
        self.fmDefaultFont_20 = [UIFont fontWithName:fontName size:self.fmFont_20];
        self.fmDefaultFont_22 = [UIFont fontWithName:fontName size:self.fmFont_22];
        self.fmDefaultFont_23 = [UIFont fontWithName:fontName size:self.fmFont_23];
        self.fmDefaultFont_24 = [UIFont fontWithName:fontName size:self.fmFont_24];
        self.fmDefaultFont_27 = [UIFont fontWithName:fontName size:self.fmFont_27];
        self.fmDefaultFont_29 = [UIFont fontWithName:fontName size:self.fmFont_29];
        self.fmDefaultFont_33 = [UIFont fontWithName:fontName size:self.fmFont_33];
        self.fmDefaultFont_36 = [UIFont fontWithName:fontName size:self.fmFont_36];
        self.fmDefaultFont_55 = [UIFont fontWithName:fontName size:self.fmFont_33];
    }
    else
    {
        self.fmDefaultFont_9 = [UIFont systemFontOfSize:self.fmFont_9];
        self.fmDefaultFont_10 = [UIFont systemFontOfSize:self.fmFont_10];
        self.fmDefaultFont_11 = [UIFont systemFontOfSize:self.fmFont_11];
        self.fmDefaultFont_12 = [UIFont systemFontOfSize:self.fmFont_12];
        self.fmDefaultFont_13 = [UIFont systemFontOfSize:self.fmFont_13];
        self.fmDefaultFont_14 = [UIFont systemFontOfSize:self.fmFont_14];
        self.fmDefaultFont_15 = [UIFont systemFontOfSize:self.fmFont_15];
        self.fmDefaultFont_16 = [UIFont systemFontOfSize:self.fmFont_16];
        self.fmDefaultFont_17 = [UIFont systemFontOfSize:self.fmFont_17];
        self.fmDefaultFont_18 = [UIFont systemFontOfSize:self.fmFont_18];
        self.fmDefaultFont_19 = [UIFont systemFontOfSize:self.fmFont_19];
        self.fmDefaultFont_20 = [UIFont systemFontOfSize:self.fmFont_20];
        self.fmDefaultFont_22 = [UIFont systemFontOfSize:self.fmFont_22];
        self.fmDefaultFont_24 = [UIFont systemFontOfSize:self.fmFont_24];
        self.fmDefaultFont_27 = [UIFont systemFontOfSize:self.fmFont_27];
        self.fmDefaultFont_29 = [UIFont systemFontOfSize:self.fmFont_29];
        self.fmDefaultFont_33 = [UIFont systemFontOfSize:self.fmFont_33];
        self.fmDefaultFont_36 = [UIFont systemFontOfSize:self.fmFont_36];
        self.fmDefaultFont_55 = [UIFont systemFontOfSize:self.fmFont_33];
        
        self.fmBlodFont_9=[UIFont boldSystemFontOfSize:self.fmFont_9];
        self.fmBlodFont_10=[UIFont boldSystemFontOfSize:self.fmFont_10];
        self.fmBlodFont_11=[UIFont boldSystemFontOfSize:self.fmFont_11];
        self.fmBlodFont_12=[UIFont boldSystemFontOfSize:self.fmFont_12];
        self.fmBlodFont_13=[UIFont boldSystemFontOfSize:self.fmFont_13];
        self.fmBlodFont_14=[UIFont boldSystemFontOfSize:self.fmFont_14];
        self.fmBlodFont_15=[UIFont boldSystemFontOfSize:self.fmFont_15];
        self.fmBlodFont_16=[UIFont boldSystemFontOfSize:self.fmFont_16];
        self.fmBlodFont_17=[UIFont boldSystemFontOfSize:self.fmFont_17];
        self.fmBlodFont_18=[UIFont boldSystemFontOfSize:self.fmFont_18];
        self.fmBlodFont_20=[UIFont boldSystemFontOfSize:self.fmFont_20];
        self.fmBlodFont_22=[UIFont boldSystemFontOfSize:self.fmFont_22];
        self.fmBlodFont_23=[UIFont boldSystemFontOfSize:self.fmFont_23];
        self.fmBlodFont_24=[UIFont boldSystemFontOfSize:self.fmFont_24];
        self.fmBlodFont_27=[UIFont boldSystemFontOfSize:self.fmFont_27];
        self.fmBlodFont_30=[UIFont boldSystemFontOfSize:self.fmFont_30];

    }
    
}

@end
