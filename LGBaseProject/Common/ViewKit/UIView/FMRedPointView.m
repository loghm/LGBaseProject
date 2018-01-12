//
//  FMRedPointView.m
//  ForMan
//
//  Created by chw on 16/6/27.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMRedPointView.h"

@interface FMRedPointView()


@end

@implementation FMRedPointView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.badgeColor = [UIColor whiteColor];
        self.badgeValue = 0;
        self.backGroundColor = [FMColor fmColor_c3];
        self.badgeFont = 12;
        [self setContent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.backgroundColor = [UIColor clearColor];
        self.badgeColor = [UIColor whiteColor];
        self.badgeValue = 0;
        self.backGroundColor = [FMColor fmColor_c3];
        self.badgeFont = 12;
        [self setContent];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.badgeLabel.frame=self.bounds;
 
}

- (void)setContent
{
    [self setUserInteractionEnabled:NO];
    self.clipsToBounds = YES;
    
    _badgeLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _badgeLabel.font = [UIFont systemFontOfSize:self.badgeFont];
//    _label.textColor = self.badgeColor;
    _badgeLabel.textColor = [FMColor fmColor_g1];
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_badgeLabel];
}

- (void)setBadgeValue:(NSInteger)badgeValue
{
    _badgeValue = badgeValue;
    [self resetBadge];
}

- (void)resetBadge
{
  
    if (self.badgeValue <= 0)
    {
        self.badgeLabel.text = nil;
        if (self.badgeValue == 0)
            self.badgeLabel.hidden = YES;
    }
    else if ((NSInteger)self.badgeValue < 100)
    {
        self.badgeLabel.text = [NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:(NSInteger)self.badgeValue]];
        self.badgeLabel.hidden = NO;
    }
    else
    {
        self.badgeLabel.text = @"99+";
        self.badgeLabel.hidden = NO;
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.badgeLabel.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
}

- (void)setBackGroundColor:(UIColor *)backGroundColor
{
    _backGroundColor = backGroundColor;
    self.badgeLabel.backgroundColor = backGroundColor;
    self.backgroundColor = backGroundColor;
}

- (void)setBadgeColor:(UIColor *)badgeColor
{
    _badgeColor = badgeColor;
    _badgeLabel.textColor = badgeColor;
}

@end
