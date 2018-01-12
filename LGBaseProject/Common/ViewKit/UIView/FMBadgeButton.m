//
//  FMBadgeButton.m
//  ForMan
//
//  Created by chw on 16/6/27.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMBadgeButton.h"
#import "FMRedPointView.h"
#import "UIButton+FMWebImage.h"
//#import "FMBadgeButton+ImageView.h"

@interface FMBadgeButton ()

@end

@implementation FMBadgeButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        //        self.layer.masksToBounds = YES;
        //        self.layer.cornerRadius = 25;
        self.badgeColor = [UIColor whiteColor];
        self.badgeBackColor = [FMColor fmColor_white];
        self.badgeValue = 0;
        _badgeOrigin = CGPointMake(self.frame.size.width-12, -1);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.badgeColor = [UIColor whiteColor];
        self.badgeBackColor = [FMColor fmColor_c3];
        self.badgeValue = 0;
        _badgeOrigin = CGPointMake(self.frame.size.width-12, -1);
    }
    return self;
}

- (void)setBadgeColor:(UIColor *)badgeColor
{
    _badgeColor = badgeColor;
    self.badgeView.badgeColor = badgeColor;
}

- (void)setBadgeValue:(NSInteger)badgeValue
{
    _badgeValue = badgeValue;
    self.badgeView.badgeValue = badgeValue;
    [self resetBadge];
}

- (void)setBadgeBackColor:(UIColor *)badgeBackColor
{
    _badgeBackColor = badgeBackColor;
    self.badgeView.backGroundColor = badgeBackColor;
}

- (void)setBadgeOrigin:(CGPoint)badgeOrigin
{
    _badgeOrigin = badgeOrigin;
    self.badgeView.origin = badgeOrigin;
}

- (void)resetBadge
{
    if (self.badgeValue == 0)
    {
        if (_badgeView)
        {
            _badgeView.hidden = YES;
        }
    }
    else if (self.badgeValue > 0)
    {
        if (self.badgeValue > 99)
        {
            self.badgeView.frame = CGRectMake(_badgeOrigin.x, _badgeOrigin.y, 27, 16);
        }
        else
        {
            if (self.badgeValue > 10)
                self.badgeView.frame = CGRectMake(_badgeOrigin.x, _badgeOrigin.y, 20, 16);
            else
                self.badgeView.frame = CGRectMake(_badgeOrigin.x, _badgeOrigin.y, 16, 16);
        }
        self.badgeView.hidden = NO;
    }
    else if (self.badgeValue < 0)
    {
        self.badgeView.frame = CGRectMake(self.frame.size.width-8, 3, 8, 8);
        self.badgeView.hidden = NO;
    }
    self.badgeView.layer.cornerRadius = self.badgeView.frame.size.height/2;
    [self.badgeView setNeedsDisplay];
}


- (FMRedPointView*)badgeView
{
    if (!_badgeView)
    {
        _badgeView = [[FMRedPointView alloc] initWithFrame:CGRectMake(self.frame.size.width-12, -1, 15, 15)];
        [self addSubview:_badgeView];
        [self bringSubviewToFront:_badgeView];
        
    }
    return _badgeView;
}

- (void)setImage:(id)image
{
    _image = image;
    if ([image isKindOfClass:[UIImage class]])
    {
        UIImage *img = image;
        [self setImage:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        NSString *string = (NSString*)image;
        if ([string hasPrefix:@"http://"])
        {
            [self fm_setImageWithURL:[NSURL URLWithString:string] forState:UIControlStateNormal placeholderImage:self.placeholderImage];
        }
        else
            [self setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
}

- (void)setPlaceholderImage:(NSString *)placeholderImage
{
    _placeholderImage = placeholderImage;
}

-(UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView=[[UIImageView alloc]initWithFrame:self.bounds];
        //        _backImageView.center=self.center;
        _backImageView.contentMode = UIViewContentModeScaleToFill;
        _backImageView.layer.masksToBounds=YES;
        [self insertSubview:_backImageView atIndex:0];
        _backImageView.center = self.center;

//        FM_WEAKSELF
//        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.mas_equalTo(weakSelf.center);
//        }];
    }
    return _backImageView;
}

@end
