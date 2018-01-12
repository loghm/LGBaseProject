//
//  FMBasicButton.m
//  ForMan
//
//  Created by chw on 16/6/22.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMBasicButton.h"

@interface FMBasicButton ()

@property (nonatomic, strong) NSMutableDictionary *borderColorMap;
@property (nonatomic, strong) NSMutableDictionary *backgroundColorMap;

@end

@implementation FMBasicButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addObserver];
}

- (void)setFmStyle:(FMBasicButtonStyle)fmStyle
{
    _fmStyle = fmStyle;
    switch (fmStyle) {
        case FMBasicButton_BTN1:
        {
            self.layer.cornerRadius = 8;
            self.layer.masksToBounds = YES;
            [self setTitleColor:[FMColor fmColor_B4] forState:UIControlStateDisabled];
            [self setTitleColor:[FMColor fmColor_B1] forState:UIControlStateNormal];
            [self setTitleColor:[FMColor fmColor_B1] forState:UIControlStateHighlighted];
            self.titleLabel.font = FMLayoutManagerInstance.fmBlodFont_16;
            
            [self setBackgroundColor:[FMColor fmColor_Line1] forState:UIControlStateDisabled];
            [self setBackgroundColor:[FMColor fmColor_Y1] forState:UIControlStateNormal];
            [self setBackgroundColor:[FMColor fmColor_Y1] forState:UIControlStateHighlighted];
            
            
            [self setBorderColor:[FMColor fmColor_Line1] forState:UIControlStateDisabled];
            [self setBorderColor:[FMColor fmColor_B1] forState:UIControlStateNormal];
            
            self.layer.borderWidth = 1;
        }
            break;
        case FMBasicButton_BTN2:
        {
            self.layer.cornerRadius = self.height/2.0;
            self.layer.masksToBounds = YES;
            [self setTitleColor:[FMColor fmColor_B4] forState:UIControlStateDisabled];
            [self setTitleColor:[FMColor fmColor_343434] forState:UIControlStateNormal];
            [self setTitleColor:[FMColor fmColor_343434] forState:UIControlStateHighlighted];
            
            [self setBackgroundColor:[FMColor fmColor_Line1] forState:UIControlStateDisabled];
            [self setBackgroundColor:FMCOLOR_HEX(0xFBD848) forState:UIControlStateNormal];
            [self setBackgroundColor:FMCOLOR_HEX(0xFBD848) forState:UIControlStateHighlighted];
            
            
//            [self setBorderColor:[FMColor fmColor_Line1] forState:UIControlStateDisabled];
//            [self setBorderColor:[FMColor fmColor_B1] forState:UIControlStateNormal];
            
//            self.layer.borderWidth = 1;
        }
            break;
        case FMBasicButton_BTN9:
        {
            self.layer.cornerRadius = 4;
            self.layer.masksToBounds = YES;
            [self setTitleColor:[FMColor fmColor_white] forState:UIControlStateDisabled];
            [self setTitleColor:[FMColor fmColor_fed934] forState:UIControlStateNormal];
            [self setTitleColor:[FMColor fmColor_fed934] forState:UIControlStateHighlighted];
            self.titleLabel.font = FMLayoutManagerInstance.fmBlodFont_12;
            
            [self setBackgroundColor:FMCOLOR_HEX(0xdadada) forState:UIControlStateDisabled];
            [self setBackgroundColor:FMCOLOR_HEX(0xfff4bf) forState:UIControlStateNormal];
            [self setBackgroundColor:FMCOLOR_HEX(0xfff4bf) forState:UIControlStateHighlighted];
            
            
            [self setBorderColor:FMCOLOR_HEX(0xdadada) forState:UIControlStateDisabled];
            [self setBorderColor:FMCOLOR_HEX(0xfff4bf) forState:UIControlStateNormal];
            
            self.layer.borderWidth = 0.5;
        }
            break;
            

        default:
            break;
    }
    [self stateChange];
}

- (void)setBorderColor:(UIColor*)borderColor forState:(UIControlState)state
{
//    [self.borderColorMap setValue:borderColor forKey:[NSString stringWithInteger:state]];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
//    [self.backgroundColorMap setValue:backgroundColor forKey:[NSString stringWithInteger:state]];
}

#pragma - private
- (NSMutableDictionary*)borderColorMap
{
    if (!_borderColorMap)
    {
        _borderColorMap = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _borderColorMap;
}

- (NSMutableDictionary*)backgroundColorMap
{
    if (!_backgroundColorMap)
    {
        _backgroundColorMap = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _backgroundColorMap;
}

- (void)addObserver
{
//    [RACObserve(self, highlighted) subscribeNext:^(id x) {
////        NSLog(@"highlighted:%@", [NSString stringWithUInteger:self.state]);
//        [self stateChange];
//    }];
//    [RACObserve(self, selected) subscribeNext:^(id x) {
////        NSLog(@"selected:%@", [NSString stringWithUInteger:self.state]);
//        [self stateChange];
//    }];
//    [RACObserve(self, enabled) subscribeNext:^(id x) {
////        NSLog(@"enabled:%@", [NSString stringWithUInteger:self.state]);
//        [self stateChange];
//    }];
}

- (void)stateChange
{
//    NSString *key = [NSString stringWithUInteger:UIControlStateNormal];
//    if (self.state == UIControlStateDisabled)
//    {
//        key = [NSString stringWithUInteger:UIControlStateDisabled];
//    }
//    else if (self.state & UIControlStateHighlighted)
//    {
//        key = [NSString stringWithUInteger:UIControlStateHighlighted];
//    }
//    else if (self.state == UIControlStateSelected)
//    {
//        key = [NSString stringWithUInteger:UIControlStateSelected];
//    }

//    UIColor *bordorColor = [_borderColorMap valueForKey:key];
//    UIColor *backgoundColor = [_backgroundColorMap valueForKey:key];
    
//    if (bordorColor)     //不为空时才设，因为系统会有默认的
//        self.layer.borderColor = [bordorColor CGColor];
//    if (backgoundColor)
//        self.backgroundColor = backgoundColor;
}

+ (FMBasicButton*)buttonWithStyle:(FMBasicButtonStyle)style
{
    FMBasicButton *button = [FMBasicButton buttonWithType:UIButtonTypeCustom];
    button.fmStyle = style;
    return button;
}

+ (FMBasicButton*)buttonWithFrame:(CGRect)rect style:(FMBasicButtonStyle)style
{
    return [[self class] buttonWithFrame:rect style:style target:nil selector:nil];
}

+ (FMBasicButton*)buttonWithFrame:(CGRect)rect style:(FMBasicButtonStyle)style target:(id)target selector:(SEL)selector
{
    FMBasicButton *button = [FMBasicButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenDisabled = NO;
    button.frame = rect;
    button.fmStyle = style;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
