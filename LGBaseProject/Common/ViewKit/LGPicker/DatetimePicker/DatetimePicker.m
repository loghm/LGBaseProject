//
//  DatePicker.m
//  HybridApp
//
//  Created by iOSgo on 2017/9/8.
//  Copyright © 2017年 iOSgo. All rights reserved.
//

#import "DatetimePicker.h"

#define MAINSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define MAINSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define DEFAULT_HEIGHT (260)

@interface DatetimePicker ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation DatetimePicker {
    
    UIControl *_overView;
    
}


+ (DatetimePicker *)createDatetimePicker {
    
    DatetimePicker *datePicker = [[[NSBundle mainBundle] loadNibNamed:@"DatetimePicker" owner:nil options:nil] lastObject];
    
    [datePicker initDatas];
    [datePicker setup];
    
    return datePicker;
    
}

- (void)setup {
    
    self.frame=CGRectMake(0, MAINSCREEN_HEIGHT, MAINSCREEN_WIDTH, DEFAULT_HEIGHT);
    self.backgroundColor = [UIColor whiteColor];
    
    _overView=[[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _overView.backgroundColor=[UIColor colorWithWhite:0.6 alpha:0.3];
    
    [_overView addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}


- (void)initDatas {
    
    NSString *dateTime = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    NSString *dateStr = [HelpManager getDate:dateTime With:@"yyyy-MM-dd HH:mm"];
    NSArray *dateAry = [dateStr componentsSeparatedByString:@" "];
    [self.dateButton setTitle:[dateAry firstObject] forState:UIControlStateNormal];
    [self.timeButton setTitle:[dateAry lastObject] forState:UIControlStateNormal];
    
}


- (void)show
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:_overView];
    [keyWindow addSubview:self];
    
    CGRect frameContent =  self.frame;
    frameContent.origin.y -= self.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:1.0];
        self.frame = frameContent;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)remove
{
    CGRect frameContent =  self.frame;
    frameContent.origin.y += self.frame.size.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:0.0];
        self.frame = frameContent;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_overView removeFromSuperview];
    }];
}



- (IBAction)dissmissBtnAction:(id)sender {
    
    [self remove];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
}
- (IBAction)switchDatetimeAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    if ([button isEqual:self.dateButton]) {
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        [self.dateButton setSelected:YES];
        [self.timeButton setSelected:NO];
    } else {
        self.datePicker.datePickerMode = UIDatePickerModeTime;
        //NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
        //self.datePicker.locale = locale;
        //self.datePicker.minimumDate = [NSDate date]; // 最小时间
        [self.dateButton setSelected:NO];
        [self.timeButton setSelected:YES];
    }
    
}

- (IBAction)comfirmBtnAction:(id)sender {
    
    [self remove];
    if (self.dateBlock) {
        self.dateBlock(self.dateButton.titleLabel.text,self.timeButton.titleLabel.text);
    }
    
}
- (IBAction)datePickerChange:(UIDatePicker *)sender {
    
    NSLog(@"%@",sender.date);
    if (self.dateButton.selected) {
        NSString *tempStr = [NSString stringWithFormat:@"%f",sender.date.timeIntervalSince1970];
        NSString *dateStr =[HelpManager getDate:tempStr With:@"yyyy-MM-dd"];
        [self.dateButton setTitle:dateStr forState:UIControlStateNormal];
    }
    if (self.timeButton.selected) {
        NSString *tempStr = [NSString stringWithFormat:@"%f",sender.date.timeIntervalSince1970];
        NSString *dateStr =[HelpManager getDate:tempStr With:@"HH:mm"];
        [self.timeButton setTitle:dateStr forState:UIControlStateNormal];
    }
    
}

//setter
- (void)setFontColor:(UIColor *)fontColor {
    
    _fontColor = fontColor;

    [self.confirmButton setTitleColor:_fontColor forState:UIControlStateNormal];
    
}


@end
