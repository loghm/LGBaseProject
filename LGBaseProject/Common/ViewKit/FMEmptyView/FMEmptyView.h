//
//  FMEmptyView.h
//  ForMan
//
//  Created by slj on 16/8/03.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

@class FMBasicButton;
@interface FMEmptyView : UIView{
    UIView *_baseView; //底座
    UILabel *_label; //基本文本
    FMBasicButton *_button; //基本按钮
    UILabel *_subLabel; //子文本
    BOOL _hadSetBaseYPadding;
}

@property(nonatomic, strong)UIImageView *imageView; //基本图片

@property(nonatomic, readonly)UILabel *label;

@property(nonatomic, assign) CGFloat baseYPadding;  //设置背景与顶部间距 如果设置，必须在底下的方法之前设置。

//设置图片
- (void)setImage:(UIImage *)image;

//设置文本
- (void)setLabelText:(NSString *)labelText;

//设置图片和文本
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText;

//设置图片和文本，以及文本位置
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText
   labelYPadding:(CGFloat)labelPadding;

//设置图片，文本和按钮，
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText
      buttonText:buttonText
    buttonTarget:(id)buttonTarget
    buttonAction:(SEL)buttonAction;

//设置图片，文本，子文本和按钮，
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText
    subLabelText:(NSString *)subLabelText
      buttonText:buttonText
    buttonTarget:(id)buttonTarget
    buttonAction:(SEL)buttonAction;


//设置图片，文本和按钮，以及文本，按钮位置
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText
   labelYPadding:(CGFloat)labelPadding
    subLabelText:(NSString *)subLabelText
 subLabelPadding:(CGFloat)subLabelPadding
      buttonText:(NSString *)buttonText
    buttonTarget:(id)buttonTarget
    buttonAction:(SEL)buttonAction
     btnYPadding:(CGFloat)btnYPadding;

@end
