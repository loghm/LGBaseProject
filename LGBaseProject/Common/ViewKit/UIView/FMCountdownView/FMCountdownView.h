//
//  SFCountdownView.h
//  ForManLive
//
//  Created by apple on 2016/12/20.
//  Copyright © 2016年 CHW. All rights reserved.
//

#import <UIKit/UIKit.h>

static const int kDefaultCountdownFrom = 5;

@class FMCountdownView;

@protocol FMCountdownViewDelegate <NSObject>

@required
- (void) countdownFinished:(FMCountdownView *)view;

@end

@interface FMCountdownView : UIView

@property (nonatomic) int countdownFrom;
@property (nonatomic) NSString* finishText;

// appearance settings
@property (nonatomic) UIColor* countdownColor;
@property (nonatomic) NSString* fontName;
@property (nonatomic) float backgroundAlpha;

@property (nonatomic, weak) id<FMCountdownViewDelegate> delegate;

- (void) updateAppearance;
- (void) start;
- (void) stop;

@end
