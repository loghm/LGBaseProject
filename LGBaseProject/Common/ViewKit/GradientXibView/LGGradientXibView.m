//
//  LGGradientXibView.m
//  LGBaseProject
//
//  Created by loghm on 2019/1/9.
//  Copyright © 2019 loghm. All rights reserved.
//

#import "LGGradientXibView.h"

@implementation LGGradientXibView

/**
 XIB创建会掉用
 */
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUI];
    }
    return self;
}

/**
 代码创建会掉用
 */
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

/**
 初始化
 */
- (void)setUI{
    [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
}

/**
 自动适配大小
 */
- (void)drawRect:(CGRect)rect{
    self.view.frame = self.bounds;
    [self gradientView];
}

/**
 设置渐变色
 */
- (void)gradientView {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.bounds = self.view.bounds;
    gradientLayer.borderWidth = 0;
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects: (id)[[UIColor colorWithHexString:@"#A1CBFF"] CGColor],
                            (id)[[UIColor colorWithHexString:@"#8FA7FF"] CGColor], nil, nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
