//
//  FMTabBar.m
//  MeiMei
//
//  Created by 陈炜来 on 16/4/26.
//  Copyright © 2016年 MeiMei. All rights reserved.
//

#import "FMTabBar.h"
#import "FMRedPointView.h"

NSUInteger FMTabbarItemsCount = 0;
CGFloat FMTabBarItemWidth = 0.0f;

@interface FMTabBar ()
//@property (nonatomic, strong) UIButton *centerBulgeButton;//中间凸起按钮

/** 发布按钮 */
@property (nonatomic, assign) CGFloat tabBarItemWidth;

@end

@implementation FMTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [self _init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self = [self _init];
    }
    return self;
}

- (instancetype)_init  {
    CGFloat tabBarHeight = 0;
    self.height = kTabBarHeight;
    tabBarHeight = kTabBarHeight;

    //tabbar背景色
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tabBarHeight)];
    view1.backgroundColor = [FMColor hexStringToColor:@"#F2F2F2"];
    [self addSubview:view1];
    
    /** tabbar*/
    UIView *topLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    [self addSubview:topLine];
    [topLine setBackgroundColor:FMCOLOR_HEX(0xf3f4fa)];

//    [self setupBulgeButton];
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    // 把tabBarButton取出来（把tabBar的SubViews打印出来就明白了）
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    CGFloat barWidth = self.bounds.size.width;
    UIImage *centerButtonImage = [UIImage imageNamed:@"tabbar_radar"];
    CGFloat centerBtnWidth = centerButtonImage.size.width;
    CGFloat centerBtnHeight = centerButtonImage.size.height;
    // 设置中间按钮的位置，居中，凸起一丢丢
    // 逐个布局tabBarItem，修改UITabBarButton的frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat barItemWidth = (barWidth - centerBtnWidth) / (tabBarButtonArray.count-1);
        CGRect frame = view.frame;
        if (tabBarButtonArray.count / 2 == idx) {
            CGFloat heightDifference = centerBtnHeight - self.frame.size.height;
            if (IS_iPhoneX) {
                heightDifference = 83 - centerBtnHeight;
            }else {
                heightDifference = centerBtnHeight - self.frame.size.height;
            }
            CGPoint center = self.center;
            center.y = heightDifference/2.0 + 5;
            view.center = center;
        }
        if (idx > tabBarButtonArray.count / 2) {
            // 重新设置x坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = (idx-1) * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
    }];
}


/*
-(void)setupBulgeButton
{
    NSString *imageString = @"tabbar_radar";
    //  添加突出按钮
//    [self addCenterButtonWithImage:[UIImage imageNamed:imageString]
//                     selectedImage:[UIImage imageNamed:imageString]];

//    self.centerBulgeButton.selected = YES;
}

-(void)addCenterButtonWithImage:(UIImage*)buttonImage selectedImage:(UIImage*)selectedImage
{
    self.centerBulgeButton = [[UIButton alloc] init];
    [self.centerBulgeButton addTarget:self action:@selector(centerBulgeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.centerBulgeButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //  设定button大小为适应图片
    self.centerBulgeButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [self.centerBulgeButton setImage:buttonImage forState:UIControlStateNormal];
    [self.centerBulgeButton setImage:selectedImage forState:UIControlStateSelected];
    
    //  这个比较恶心  去掉选中button时候的阴影
    self.centerBulgeButton.adjustsImageWhenHighlighted=NO;
    NSLog(@"buttonheight:....%f, self.view:.....%f", buttonImage.size.height, self.frame.size.height);
    CGFloat heightDifference = buttonImage.size.height - self.frame.size.height;
    if (IS_iPhoneX) {
        heightDifference = 83 - buttonImage.size.height;
    }else {
        heightDifference = buttonImage.size.height - self.frame.size.height;
    }
    CGPoint center = self.center;
    center.y = heightDifference/2.0 + 5;
    
    self.centerBulgeButton.center = center;
    [self addSubview:self.centerBulgeButton];
}

-(void)centerBulgeButtonAction:(id)sender
{
    self.centerBulgeButton.selected = YES;
    
    if (self.centerButtonClickBlock) {
        self.centerButtonClickBlock(sender);
    }
}

*/

/**
 *  Capturing touches on a subview outside the frame of its superview
 *  解决超出部分的点击效果
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *result = [super hitTest:point withEvent:event];
        if (result) {
            return result;
        } else {
            for (UIView *subview in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [subview convertPoint:point fromView:self];
                result = [subview hitTest:subPoint withEvent:event];
                if (result) {
                    return result;
                }
            }
        }
    }
    return nil;
}


//显示小红点
- (void)showBadgeOnItemIndex:(NSInteger)index withValue:(NSInteger)value
{
    FMRedPointView *badgeView = [self viewWithTag:8888+index];
    if(!badgeView)
    {
        //新建小红点
        badgeView = [[FMRedPointView alloc]init];
        badgeView.tag = 8888 + index;
//        badgeView.backGroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"pp_tabbar_dot"] stretchableImageWithLeftCapWidth:10.5 topCapHeight:10.5]];//颜色：红色
        badgeView.backGroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
//        badgeView.badgeColor = [FMColor fmColor_343434];
        badgeView.badgeColor = [FMColor fmColor_343434];
        [self addSubview:badgeView];

//        return;
    }
    badgeView.badgeValue = value;
    badgeView.hidden = NO;

    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.55) / self.items.count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = 2;
    if (value < 0)
    {
        y = ceilf(0.2 * tabFrame.size.height);
        badgeView.frame = CGRectMake(x + 4, y, 8, 8);//圆形大小为8
//        badgeView.layer.cornerRadius = 5;//圆形
    }
    else if (value > 0)
    {
        if (value > 99)
        {
            badgeView.frame = CGRectMake(x, y, 30, 21);
        }
        else
        {
            if (value > 10)
                badgeView.frame = CGRectMake(x, y, 25, 21);
            else
                badgeView.frame = CGRectMake(x, y, 21, 21);
        }
//        badgeView.layer.cornerRadius = badgeView.height*0.5;
    }
    else
    {
        if (badgeView.superview){
            [badgeView removeFromSuperview];
            badgeView = nil;
        }
        return;
    }
    [badgeView.layer setMasksToBounds:YES];
    [badgeView.layer setCornerRadius:badgeView.frame.size.width/2];
    [badgeView setNeedsDisplay];
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index
{
    UIView *view = [self viewWithTag:8888+index];
    if(view)
        view.hidden = YES;
}


@end
