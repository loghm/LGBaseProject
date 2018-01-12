//
//  FMCaptionView.m
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright (c) 2015年 MeiMei. All rights reserved.
//

#import "FMCaptionView.h"
//#import "FMNetWorkingAction.h"
#import "LGNetWorkAction.h"
//#import <UIImage+GIF.h>
//#import "FMReachabilityHelper.h"
#import "FMBasicButton.h"
//#import "FMRefreshPointView.h"

static Class FMCaptionStyleViewClass = nil;

#define FMCAPTIONVIEW_BACKGROUNDCOLOR [FMColor fmColor_Controller_View_Background]
#define FMCAPTIONVIEW_TITLECOLOR [UIColor grayColor]


#define MC_Request_NoNet        FMString(@"Oh！网络不见了，请检查网络连接")
#define MC_Request_NoNetToast   FMString(@"Oh！网络不见了，请检查网络连接")
#define MC_Request_NoResult     FMString(@"请求没有结果")
#define MC_Request_Retry        FMString(@"哦啊~手机网络不太顺畅哦！")
#define MC_Request_Low          FMString(@"哦啊~手机网络不太顺畅哦！")
#define MC_Request_Loading      FMString(@"请求中..")
#define MC_Request_UserNoData   FMString(@"你还没有自己的数据")

@interface FMCaptionView()
@property(strong,nonatomic)NSMutableDictionary* titleMap;
@property(strong,nonatomic)NSMutableDictionary* imageMap;
//@property(nonatomic,strong)UIImageView *juHuaView;
@property(nonatomic,strong)FMBasicButton *retryButton;
//@property(nonatomic,strong)UIImageView *juHuaCircle;

//@property(nonatomic, strong) FMRefreshPointView *animationView;
@end

@implementation FMCaptionView

+(void)fm_setCaptionViewClass:(Class)captionViewClass
{
    if (captionViewClass) {
        FMCaptionStyleViewClass = captionViewClass;
    }
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _initMyself];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initMyself];
    }
    return self;
}
+(instancetype)addToView:(UIView *)view
{
    return [self addToView:view show:YES];
}
+(instancetype)addToView:(UIView *)view show:(BOOL)show
{
    if (FMCaptionStyleViewClass) {
        return [FMCaptionStyleViewClass addToView:view show:show];
    }
    
    FMCaptionView* captionView = [[self alloc] initWithFrame:CGRectMake(0, 64, view.width, view.height-64)];
//    [view addSubview:captionView];
    if (show)
    {
        [captionView show];
    }
    else
    {
        [captionView hide];
    }
    return captionView;
}
+(instancetype)captionFromView:(UIView *)view
{
    FMCaptionView* captionView = nil;
    for (UIView* subview in view.subviews) {
        if([subview isKindOfClass:self])
        {
            captionView = (id)subview;
            break;
        }
    }
    return captionView;
}
+(BOOL)removeFromView:(UIView *)view
{
    UIView* captionView = nil;
    for (UIView* subview in view.subviews) {
        if([subview isKindOfClass:self])
        {
            captionView = subview;
            break;
        }
    }
    if(captionView)
    {
        [captionView removeFromSuperview];
    }
    return YES;
}

-(void)_initMyself
{
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    
    [self setBackgroundColor:FMCAPTIONVIEW_BACKGROUNDCOLOR];
    
    //    [self addToThemeChangeObserver];
    self.state = FMCaptionViewStateHidden;
    
    self.titleMap = [NSMutableDictionary dictionary];
     self.imageMap = [NSMutableDictionary dictionary];
    FM_WEAKSELF;
//    [[RACObserve(self.layer, bounds) skip:1] subscribeNext:^(id x) {
//        [weakSelf refreshView];
//    }];
    
    //    //1.3临时替换菊花
    //    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //    juhua.color=FMColor_Black_Text_Color;
    //    juhua.center=self.imageView.center;
    //    juhua.hidesWhenStopped=YES;
    //    [juhua startAnimating];
    //    [self.imageView addSubview:juhua];
    
    //1.5换成手帕
    //    _juHuaView=juhua;
    
//    _juHuaView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
//    _juHuaView.image=[UIImage imageNamed:@"refresh_circle"];
//    _juHuaView.contentMode=UIViewContentModeCenter;
//    _juHuaView.center=CGPointMake(self.width/2, self.height/2);
//    [self addSubview:_juHuaView];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_logo"]];
//    imageView.center = CGPointMake(self.width/2, self.height/2);
//    [self addSubview:imageView];
//    self.juHuaCircle=imageView;
//    
////    CATransform3D rotationTransform = CATransform3DIdentity;
////    rotationTransform.m34 = 1.0/-900;
////    //带点缩小的效果
////    rotationTransform = CATransform3DScale(rotationTransform, 0.7, 0.7, 1);
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
////    animation.fromValue = [NSValue valueWithCATransform3D:rotationTransform];
////    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
////    animation.duration  =  0.8;
////    animation.autoreverses = YES;
////    animation.cumulative = NO;
////    animation.fillMode = kCAFillModeForwards;
////    animation.repeatCount = MAXFLOAT;
////    animation.delegate = self;
////    [_juHuaView.layer addAnimation:animation forKey:@"rotationAnimation"];
////    //    transform.scale
//    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    animation.fromValue = 0;
//    animation.toValue = [NSNumber numberWithFloat:M_PI*2];
//    animation.duration = 1;
//    CAMediaTimingFunction *linearCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    animation.timingFunction = linearCurve;
//    animation.removedOnCompletion = NO;
//    animation.repeatCount = INFINITY;
//    animation.fillMode = kCAFillModeForwards;
//    animation.autoreverses = NO;
//    [_juHuaView.layer addAnimation:animation forKey:@"transform.rotation"];
    
//    _animationView =[[FMRefreshPointView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
//    _animationView.center=CGPointMake(self.width/2, self.height/2);
//    _animationView.isShowTitle = NO;
//    [self addSubview:_animationView];
    
}
-(void)handleTap:(id)sender
{
    if(!self.retryBlock)
    {
        return;
    }
    if(_state == FMCaptionViewStateLoading || _state == FMCaptionViewStateHidden)
    {
        return;
    }
    if(_allTapToRetry == NO && _state != FMCaptionViewStateRetry&&_state!=FMCaptionViewStateNoUserData)
    {
        return;
    }
//    _animationView.isRefreshing = YES;
    self.state = FMCaptionViewStateLoading;
    self.retryBlock();
}

-(void)setTitle:(NSString *)title andState:(FMCaptionViewState)state
{
    [self setState:state andTitle:title];
}
-(void)setState:(FMCaptionViewState)state andTitle:(NSString *)title
{
    [self setTitle:title forState:state];
    if(_state != state)
    {
        [self setState:state];
    }
}
-(void)setTitle:(NSString *)title forState:(FMCaptionViewState)state
{
    _titleMap[@(state)] = title;
    if (_state == state) {
        _titleLabel.text = title;
        [self refreshView];
        if(self.superview.subviews.lastObject != self)
        {
            [self.superview bringSubviewToFront:self];
        }
    }
}
-(NSString *)titleForState:(FMCaptionViewState)state
{
    return _titleMap[@(state)];
}
- (void)setImage:(UIImage *)image forState:(FMCaptionViewState)state{
    _imageMap[@(state)]=image;
}
- (UIImage *)imageForState:(FMCaptionViewState)state
{
     return _imageMap[@(state)];
}
-(void)setState:(FMCaptionViewState)state
{
    _state = state;
    
    [self setImageView:nil titleLabel:_titleLabel state:state];
    
    [self refreshView];
    if(self.superview.subviews.lastObject != self)
    {
        [self.superview bringSubviewToFront:self];
    }
}

-(void)setImageView:(UIImageView *)imageView titleLabel:(UILabel *)titleLabel state:(FMCaptionViewState)state {
//    BOOL hasNetwork = [FMReachabilityHelper networkEnable];
    NSString* title = [self titleForState:state];
    switch (state) {
        case FMCaptionViewStateNoResult:
//        {
//            if(hasNetwork)
//            {
//                self.imageView.image = [UIImage imageNamed:@"icon_net_slow"];
//                self.titleLabel.text = title?:MC_Request_NoResult;
//                _animationView.hidden=YES;
//                titleLabel.hidden=NO;
//                self.retryButton.hidden = NO;
//            }
//            else
//            {
//                self.imageView.image = [UIImage imageNamed:@"icon_net_disable"];
//                self.titleLabel.text = title?:MC_Request_NoNet;
//                _animationView.hidden = YES;
//                titleLabel.hidden=NO;
//                self.retryButton.hidden = NO;
//            }
//            break;
//        }
        case FMCaptionViewStateRetry:
//        {
//            if(hasNetwork)
//            {
//                self.imageView.image = [UIImage imageNamed:@"icon_net_slow"];
//                self.titleLabel.text = title?:MC_Request_Retry;
//                _animationView.hidden = YES;
//                self.titleLabel.hidden=NO;
//                 self.retryButton.hidden = NO;
//            }
//            else
//            {
//                self.imageView.image = [UIImage imageNamed:@"icon_net_disable"];
//                self.titleLabel.text = title?:MC_Request_NoNet;
//                _animationView.hidden=YES;
//                self.titleLabel.hidden=NO;
//                self.retryButton.hidden = NO;
//            }
//            break;
//        }
        case FMCaptionViewStateHidden:
        {
//            _animationView.hidden=YES;
            _titleLabel.hidden=YES;
            break;
        }
        case FMCaptionViewStateLoading:
        {
//            titleLabel.text = title?:MC_Request_Loading;
            self.imageView.image=nil;
//            _animationView.isRefreshing = YES;
//            _animationView.hidden=NO;
            _titleLabel.hidden=YES;
            if (_retryButton)
                _retryButton.hidden = YES;
            break;
        }
        case FMCaptionViewStateNoUserData:
//        {
//            UIImage *image=[self imageForState:state];
//            self.imageView.image = image;
////            self.titleLabel.text = title?:MC_Request_UserNoData;
//            _animationView.isRefreshing = NO;
//            _animationView.hidden=YES;
//            self.titleLabel.hidden = NO;
//            _retryButton.hidden = YES;
//        }
            break;
    }
}

- (UIImageView*)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width-FMFixWidthFloat(124))*0.5, FMFixHeightFloat(118), FMFixWidthFloat(124), FMFixHeightFloat(115))];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel)
    {
        CGFloat y=CGRectGetMaxY(self.imageView.frame)+FMFixHeightFloat(17);
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,y, SCREEN_WIDTH, 18)];
        _titleLabel.textColor = [FMColor fmColor_cfcfcf];
        _titleLabel.font = FMLayoutManagerInstance.fmDefaultFont_15;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (FMBasicButton*)retryButton
{
    if (!_retryButton)
    {
          CGFloat y=CGRectGetMaxY(self.titleLabel.frame)+FMFixHeightFloat(20);
        _retryButton = [FMBasicButton buttonWithFrame:CGRectMake((self.width-FMFixWidthFloat(155))*0.5, y, FMFixWidthFloat(155), FMFixHeightFloat(43)) style:FMBasicButton_BTN2 target:self selector:@selector(handleTap:)];
        _retryButton.titleLabel.font = FMLayoutManagerInstance.fmDefaultFont_17;
        [_retryButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [self addSubview:_retryButton];
    }
    return _retryButton;
}

-(void)refreshView
{
    if(_state == FMCaptionViewStateHidden)
    {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
//        _imageView.center = CGPointMake(self.width/2, self.height/2 -  60);
//        
//        if(_imageView.top < 20)
//        {
//            _imageView.top = (self.height - (_imageView.height + 15 + 15))/2;
//        }
//        
//        _titleLabel.width = self.width - 20;
//        [_titleLabel sizeToFit];
//        _titleLabel.top = _imageView.bottom -15; //15;
//        _titleLabel.centerX = self.width/2;
//        
//        if(_state == FMCaptionViewStateLoading)
//        {
//            _button.hidden = YES;
//        }
//        else
//        {
//            _button.hidden = NO;
//            
//            _button.centerX = self.width/2;
//            _button.top = _titleLabel.bottom + 15;
//        }
    }
}

-(void)show
{
    self.state = FMCaptionViewStateLoading;
}
-(void)hide
{
    self.state = FMCaptionViewStateHidden;
}
-(void)fm_themeChanged
{
    self.state = _state;
}
-(void)setButtonTitle:(NSString *)title
{
    if(title.length)
    {
        self.button.hidden = NO;
        [_button setTitle:title forState:UIControlStateNormal];
        [_button sizeToFit];
        _button.centerX = self.width/2;
        _button.top = self.titleLabel.bottom + 15;
    }
    else
    {
        _button.hidden = YES;
    }
}
-(UIButton *)button
{
    if(_button == nil)
    {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:button];
        
        _button = button;
    }
    return _button;
}





//暂停layer上面的动画
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//继续layer上面的动画
- (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)drawRect:(CGRect)rect
{
//    _animationView.center = CGPointMake(self.width*0.5, self.height-SCREEN_HEIGHT*0.5);
}
@end
