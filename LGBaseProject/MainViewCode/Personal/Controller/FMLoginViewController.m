//
//  FMLoginViewController.m
//  ForMan
//
//  Created by chw on 16/6/27.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMLoginViewController.h"
#import "FMTextField.h"
#import "FMBasicButton.h"
//#import "FMQQSdkManager.h"
//#import "FMWeiboSdkManager.h"
//#import "FMWeChatSdkManager.h"
#import "FMUserManager.h"
//#import <UINavigationController+FDFullscreenPopGesture.h>
#import "HyLoginButton.h"
//#import "FMKWebViewController.h"
//#import "FMLoginPhoneViewController.h"

#define RESEND_VCODE_TIME   60

@interface FMLoginViewController ()

@property (nonatomic, strong) FMTextField *phoneField;          //手机号
@property (nonatomic, strong) FMTextField *validCodeField;      //验证码
@property (nonatomic, strong) FMBasicButton *vcButton;          //获取验证码
@property (nonatomic, strong) HyLoginButton *loginButton;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int seconds;

@property (nonatomic, strong) UIImageView *backView;

@end

@implementation FMLoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isUserAnimate = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.needShowNavBarBackGround = NO;
//    self.fd_interactivePopDisabled = YES;
    _backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.image = [UIImage imageNamed:@"login_bg"];
    _backView.userInteractionEnabled = YES;
    [self.view addSubview:_backView];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(FMFixWidthFloat(10), 20, FMFixWidthFloat(44), FMFixHeightFloat(44));
    [backButton setImage:[UIImage imageNamed:@"Top_Close"] forState:UIControlStateNormal];
    
    [_backView addSubview:backButton];
    
//    CGFloat height = 0;
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-FMFixWidthFloat(90))*0.5, FMFixWidthFloat2(133), FMFixWidthFloat2(90), FMFixWidthFloat2(90))];
    logoView.centerX = SCREEN_WIDTH*0.5;
    logoView.image = [UIImage imageNamed:@"login_logo"];
    [_backView addSubview:logoView];
    
    UILabel *logoLabel = [[UILabel alloc] init];
    logoLabel.frame = CGRectMake(0, logoView.bottom + FMFixHeightFloat2(20), SCREEN_WIDTH, 20);
    logoLabel.text = APPName;
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.textColor = [FMColor fmColor_white];
    logoLabel.font = FMLayoutManagerInstance.fmDefaultFont_16;
    [_backView addSubview:logoLabel];
    
//    height +=  CGRectGetMaxY(logoLabel.frame) ;
//    
//    bool isPhone5 = NO;
//    if ([UIScreen mainScreen].bounds.size.height <= 568) {
//        isPhone5 = YES;
//        height -= 15;
//    }
//    
//    _phoneField = [[FMTextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /10,
//                                                                height+FMFixHeightFloat2(26),
//                                                                SCREEN_WIDTH *0.8,
//                                                                FMFixHeightFloat2(53))];
//    _phoneField.textColor = [FMColor fmColor_white];
//    _phoneField.font = FMLayoutManagerInstance.fmDefaultFont_15;
//    _phoneField.keyboardType = UIKeyboardTypeNumberPad;
//    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:@"使用手机号码可以直接登录"];
//    [attributedStr addAttribute:NSFontAttributeName
//                          value:FMLayoutManagerInstance.fmDefaultFont_15
//                          range:NSMakeRange(0, attributedStr.length)];
//    [attributedStr addAttribute:NSForegroundColorAttributeName
//                          value:FMCOLOR_HEX(0x616262)
//                          range:NSMakeRange(0, attributedStr.length)];
//    _phoneField.attributedPlaceholder = attributedStr;
//    [_backView addSubview:_phoneField];
//    
//    //设置手机号输入最大长度11
//    [[self.phoneField.rac_textSignal filter:^BOOL(NSString*text){
//        return text.length > 9;
//    }] subscribeNext:^(id x){
//        if (weakSelf.phoneField.text.length == 11)
//        {
//            weakSelf.vcButton.enabled = YES;
//        }
//        else if (weakSelf.phoneField.text.length < 11)
//        {
//            weakSelf.vcButton.enabled = NO;
//        }
//        else
//        {
//            UITextRange *selectedRange = [weakSelf.phoneField markedTextRange];
//            if (!selectedRange || selectedRange.isEmpty)
//            {
//                weakSelf.phoneField.text = [x substringToIndex:11];
//            }
//        }
//    }];
//    
//    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /10,
//                                                             height+FMFixHeightFloat2(70),
//                                                             SCREEN_WIDTH*0.8,
//                                                             1)];
//    line1.backgroundColor = [FMColor fmColor_B1];
//    [_backView addSubview:line1];
//    height += FMFixHeightFloat2(60);
//    
//    _validCodeField = [[FMTextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /10,
//                                                                    height+FMFixHeightFloat2(35),
//                                                                    SCREEN_WIDTH*0.8,
//                                                                    FMFixHeightFloat2(53))];
//    _validCodeField.textColor = [UIColor whiteColor];
//    [_backView addSubview:_validCodeField];
//    _validCodeField.keyboardType = UIKeyboardTypeNumberPad;
//    _validCodeField.font = FMLayoutManagerInstance.fmDefaultFont_15;
//    
//    NSMutableAttributedString *attributedStr2 = [[NSMutableAttributedString alloc]initWithString:@"填写验证码"];
//    [attributedStr2 addAttribute:NSFontAttributeName
//                          value:FMLayoutManagerInstance.fmDefaultFont_15
//                          range:NSMakeRange(0, attributedStr2.length)];
//    [attributedStr2 addAttribute:NSForegroundColorAttributeName
//                          value:FMCOLOR_HEX(0x616262)
//                          range:NSMakeRange(0, attributedStr2.length)];
//    _validCodeField.attributedPlaceholder = attributedStr2;
//    
//    //设置验证码输入最大长度4
//    [[self.validCodeField.rac_textSignal filter:^BOOL(NSString*text){
//        return text.length > 4;
//    }] subscribeNext:^(id x){
//        UITextRange *selectedRange = [weakSelf.validCodeField markedTextRange];
//        if (!selectedRange || selectedRange.isEmpty)
//        {
//            weakSelf.validCodeField.text = [x substringToIndex:4];
//        }
//    }];
//    
//    _vcButton = [FMBasicButton buttonWithFrame:CGRectMake(SCREEN_WIDTH-FMFixWidthFloat2(32+95),
//                                                          height+FMFixHeightFloat2(38),
//                                                          FMFixWidthFloat2(95),
//                                                          FMFixHeightFloat2(32))
//                                         style:FMBasicButton_BTN1
//                                        target:self
//                                      selector:@selector(getValidCode)];
//    
//    _vcButton.layer.cornerRadius = FMFixHeightFloat2(32)/2.0;
//    _vcButton.layer.masksToBounds = YES;
//    [_vcButton setBackgroundColor:FMCOLOR_HEXAndAlpha(0xffffff, 0.17) forState:UIControlStateDisabled];
//    [_vcButton setBackgroundColor:FMCOLOR_HEXAndAlpha(0xffffff, 0.17) forState:UIControlStateNormal];
//    [_vcButton setBackgroundColor:FMCOLOR_HEXAndAlpha(0xffffff, 0.17) forState:UIControlStateHighlighted];
//    [_vcButton setTitleColor:[FMColor fmColor_white] forState:UIControlStateDisabled];
//    [_vcButton setTitleColor:[FMColor fmColor_fed934] forState:UIControlStateNormal];
//    [_vcButton setTitleColor:[FMColor fmColor_fed934] forState:UIControlStateHighlighted];
//    _vcButton.titleLabel.font = FMLayoutManagerInstance.fmBlodFont_12;
//    _vcButton.layer.borderWidth = 0;
//    _vcButton.layer.borderColor = [UIColor clearColor].CGColor;
//    
//    [_vcButton setTitle:FMString(@"FMString_Login_GetValidCode") forState:UIControlStateNormal];
//    _vcButton.titleLabel.font = FMLayoutManagerInstance.fmDefaultFont_12;
//    _vcButton.enabled = NO;
//    [_backView addSubview:_vcButton];
//    
//    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /10,
//                                                             height+FMFixHeightFloat2(80),
//                                                             SCREEN_WIDTH *0.8,
//                                                             1)];
//    line2.backgroundColor = [FMColor fmColor_B1];
//    [_backView addSubview:line2];
//    height += FMFixHeightFloat2(60);
//    
//    if (isPhone5) {
//        height -= 20;
//    }
//    
//    _loginButton = [[HyLoginButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /10,
//                                                                   height + FMFixHeightFloat2(56),
//                                                                   SCREEN_WIDTH *0.8,
//                                                                   FMFixHeightFloat2(44))];
//    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//    [_loginButton setTitle:FMString(@"FMString_Login_Login") forState:UIControlStateNormal];
//    [_backView addSubview:_loginButton];
//    _loginButton.layer.cornerRadius = FMFixHeightFloat2(44)/2;
//    _loginButton.layer.masksToBounds = YES;
//    [_loginButton setTitleColor:[FMColor fmColor_343434] forState:UIControlStateNormal];
//    _loginButton.titleLabel.font = FMLayoutManagerInstance.fmDefaultFont_16;
//    _loginButton.backgroundColor = FMCOLOR_HEX(0xFBD848);
//
//    if (self.viewType == FMLoginViewControllerTypeLogin/* && FMGlobalConfigModelInstance.showThirdLogin*/)
//    {
        [self initBottom];
//    }
    
    [backButton setHidden:(!self.isUserAnimate)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

}
- (void)fmViewDidAppear:(BOOL)animated
{
    if (self.isUserAnimate) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.image = self.lastViewImage;
        [self.view insertSubview:imageView belowSubview:_backView];
        FM_WEAKSELF
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            
        }];
    }
    else{
        self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
}

- (void)initBottom
{
    
//    int count = 3;
//
//    if (![FMWeChatSdkManager isWeChatInstall]) {
//        count = 2;
//    }
//#if TARGET_BANLV
//    count = 2;
//    if (![FMWeChatSdkManager isWeChatInstall]) {
//        count = 2;
//    }
//#endif
    NSInteger buttonMargin = 26;
    CGFloat buttonWidth = 36;
//    int width = FMFixWidthFloat(buttonWidth)*count+FMFixWidthFloat(buttonMargin);
    
//    CGFloat x = (SCREEN_WIDTH-width)*0.5;
//    if (x > 72) {
//        x = 72;
//    }
    

    CGFloat offsetY = FMFixHeightFloat(158);
    if ([UIScreen mainScreen].bounds.size.height <= 568) {

        offsetY -= 20;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [FMColor fmColor_white];
    label.font = FMLayoutManagerInstance.fmDefaultFont_14;
    label.text = LGLocalString(@"FMString_Login_ThirdType");
    [label sizeToFit];
    label.center = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT-offsetY);
    [_backView addSubview:label];

    UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [button0 setImage:[UIImage imageNamed:@"Login_Phone"] forState:UIControlStateNormal];
    [button0 addTarget:self action:@selector(phoneLogin) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:button0];
    [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(buttonWidth));
        make.height.mas_equalTo(@(buttonWidth));
        make.centerX.equalTo(_backView);
        make.top.equalTo(label.mas_bottom).offset(27);
    }];
    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button1.frame = CGRectMake(CGRectGetMaxX(button0.frame)+FMFixWidthFloat(buttonMargin), label.bottom + FMFixHeightFloat(27), FMFixWidthFloat(buttonWidth), FMFixHeightFloat(buttonWidth));
//    [button1 setImage:[UIImage imageNamed:@"Login_QQ"] forState:UIControlStateNormal];
//    [button1 addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
//    [_backView addSubview:button1];
    
#pragma mark - 隐藏微博登录
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.frame = CGRectMake(CGRectGetMaxX(button1.frame)+FMFixWidthFloat(buttonMargin), label.bottom + FMFixHeightFloat(27), FMFixWidthFloat(buttonWidth), FMFixHeightFloat(buttonWidth));
//    [button2 setImage:[UIImage imageNamed:@"Login_Weibo"] forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(weiboLogin) forControlEvents:UIControlEventTouchUpInside];
//    [_backView addSubview:button2];
    
//#if TARGET_BANLV
//    [button2 removeFromSuperview];
//    button2 = button1;
//#endif
//    if (count > 2)
//    {
//        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
//        button3.frame = CGRectMake(CGRectGetMaxX(button1.frame)+FMFixWidthFloat(buttonMargin), label.bottom + FMFixHeightFloat(27), FMFixWidthFloat(buttonWidth), FMFixHeightFloat(buttonWidth));
//        [button3 setImage:[UIImage imageNamed:@"Login_Wechat"] forState:UIControlStateNormal];
//        [button3 addTarget:self action:@selector(weiChatLogin) forControlEvents:UIControlEventTouchUpInside];
//        [_backView addSubview:button3];
//    }
    
    YYLabel *labe2 = [[YYLabel alloc] init];
    labe2.textColor = [FMColor fmColor_B1];
    labe2.font = FMLayoutManagerInstance.fmDefaultFont_12;
//    [labe2 sizeToFit];
    labe2.textAlignment = NSTextAlignmentCenter;
    labe2.lineBreakMode = 0;
    labe2.numberOfLines = NSLineBreakByWordWrapping;
//    if ([UIScreen mainScreen].bounds.size.height <= 568) {
//        labe2.frame = CGRectMake(0 , button1.bottom + FMFixHeightFloat(15), SCREEN_WIDTH, 15);
//    }
//    else{
//        labe2.frame = CGRectMake(0 , button1.bottom + FMFixHeightFloat(22), SCREEN_WIDTH, 15);
//
//    }
    [_backView addSubview:labe2];
    [labe2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(button0.mas_bottom).offset(15);
    }];
    
    [self setLabelString:labe2];


}
#pragma mark - 条款label
- (void)setLabelString:(YYLabel *)label
{
    NSString *protocolString = [NSString stringWithFormat:@"%@条款和隐私条款",APPName];
    NSMutableAttributedString *linkString = [[NSMutableAttributedString alloc] initWithString:protocolString];
    linkString.font = [FMLayoutManagerInstance fmDefaultFont_11];
    linkString.underlineStyle = NSUnderlineStyleSingle;
    linkString.color = [FMColor fmColor_fed934];
    
    FM_WEAKSELF
    [linkString setTextHighlightRange:linkString.rangeOfAll
                                color:[FMColor fmColor_fed934]
                      backgroundColor:[UIColor clearColor]
                            tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect)
     {
//         NSString *urlString= [FMToolsFunction componentUrlWithPrefix:FM_URL_TERM_GET_1 params:nil];
//         FMKWebViewController *web=[FMKWebViewController webWithURLString:urlString];
//         web.title=@"用户使用协议";
//         [weakSelf fm_push:web];
     }];
    
    NSMutableAttributedString *preString = [[NSMutableAttributedString alloc] initWithString:@"登录即代表你同意"];
    preString.font = [FMLayoutManagerInstance fmDefaultFont_11];
    preString.underlineStyle = NSUnderlinePatternDot;
    preString.color = [FMColor fmColor_999999];

    
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    [text appendAttributedString:preString];
    [text appendAttributedString:linkString];
    
    label.attributedText = text;
    label.textAlignment = NSTextAlignmentCenter;

}


- (void)close
{
    FM_WEAKSELF
    [weakSelf fm_pop:NO];
    if ([FMUserManager isLogin] && weakSelf.onComplete) //因为都是在登录后才需要做一些操作的，所以未登录不回调
    {
        weakSelf.onComplete();
    }
    
}


- (void)phoneLogin
{
//    FMLoginPhoneViewController *VC = [[FMLoginPhoneViewController alloc] init];
//    FM_WEAKSELF
//    VC.onCloseBlock = ^(){
//        [weakSelf close];
//    };
//    [self presentViewController:VC animated:YES completion:^{
//
//    }];
}

- (void)qqLogin
{
    NSLog(@"qqLogin");
    FM_WEAKSELF
    [_loginButton scaleAnimation];
    [[FMUserManager shareInstance] qqLoginComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
        [UIView fm_hideHUD];
        if (status == FMBaseManagerReturnInfoSuccess)
        {
            FM_POST_NOTIFY(FMUserLoginNotification);
            FM_POST_NOTIFY(FMPersonalNeedRequestNotification);
            [UIView fm_showTextHUD:LGLocalString(@"FMString_Login_LoginSuccess")];
            [weakSelf close];
        }
        else
        {
            [weakSelf.loginButton failedAnimationWithCompletion:^{
                
            }];
            [weakSelf fm_showTextHUD:blockInfo ];
        }
        
    }];
}

- (void)weiboLogin
{
    NSLog(@"weiboLogin");
    FM_WEAKSELF
    [_loginButton scaleAnimation];
    [[FMUserManager shareInstance] weiboLoginComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
        [UIView fm_hideHUD];
        if (status == FMBaseManagerReturnInfoSuccess)
        {
            FM_POST_NOTIFY(FMUserLoginNotification);
            FM_POST_NOTIFY(FMPersonalNeedRequestNotification);
            [UIView fm_showTextHUD:LGLocalString(@"FMString_Login_LoginSuccess")];
            [weakSelf close];
        }
        else
        {
            [weakSelf.loginButton failedAnimationWithCompletion:^{
                
            }];
            [weakSelf fm_showTextHUD:blockInfo ];
        }
    }];
}

- (void)weiChatLogin
{
    NSLog(@"weiChatLogin");
    [UIView fm_showLoadingHUD];
    FM_WEAKSELF
    [_loginButton scaleAnimation];
    [[FMUserManager shareInstance] wechatLoginComplete:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
        
        [UIView fm_hideHUD];
        if (status == FMBaseManagerReturnInfoSuccess)
        {
            FM_POST_NOTIFY(FMUserLoginNotification);
            FM_POST_NOTIFY(FMPersonalNeedRequestNotification);
            [UIView fm_showTextHUD:LGLocalString(@"FMString_Login_LoginSuccess")];
            [weakSelf close];
        }
        else
        {
            [weakSelf.loginButton failedAnimationWithCompletion:^{
                
            }];
            [weakSelf fm_showTextHUD:blockInfo ];
        }
    }];
}

- (void)startCountDown
{
    //    self.vCodeButton.enabled = NO;
    [self.timer invalidate];
    self.seconds = RESEND_VCODE_TIME;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

- (void)countDown
{
    NSString *title = nil;
    if (self.seconds > -1)
    {
        title = [NSString stringWithFormat:@"%d s", self.seconds];
        self.seconds--;
        self.vcButton.enabled = NO;
        //        [self.vCodeButton.titleLabel setText:title];
        [self.vcButton setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        title = LGLocalString(@"FMString_Login_RegetValidCode");
        [self.vcButton setTitle:title forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.vcButton.enabled = YES;
    }
}

@end
