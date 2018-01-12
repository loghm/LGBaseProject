//
//  FMEmptyView.m
//  ForMan
//
//  Created by slj on 16/8/03.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMEmptyView.h"
//#import "FMViewConstructUtil.h"
#import "FMStringUtil.h"
#import "FMBasicButton.h"

const static CGFloat kDefaultLabelPadding = 25.f;//文本距离图标间距
const static CGFloat kDefaultSubLabelPadding = 8.f;//第一文本 和第二文本 间距
const static CGFloat kDefaultButtongPadding = 14.f;//文本和按钮 间距
//const static CGFloat kDefaultButtonWidth = 226.f;//按钮宽度
const static CGFloat kDefaultButtonHeight = 50.f;//按钮高度

#define kDefaultButtonWidth SCREEN_WIDTH * 0.84
@implementation FMEmptyView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    _hadSetBaseYPadding = NO;
    [self constructSubView];
    return self;
}

- (void)constructSubView{
    _baseView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_baseView];
    
    //imageView
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.userInteractionEnabled = NO;
    [_baseView addSubview:_imageView];
    
    
    //label
//    _label = [FMViewConstructUtil constructLabel:CGRectZero
//                                          text:nil
//                                          font:[FMLayoutManagerInstance fmBlodFont_15]
//                                     textColor:[FMColor fmColor_B4]];
    _label.numberOfLines = 2;
    _label.lineBreakMode = NSLineBreakByCharWrapping;
    [_baseView addSubview:_label];
    
    //subLabel
//    _subLabel = [FMViewConstructUtil constructLabel:CGRectZero
//                                          text:nil
//                                          font:[FMLayoutManagerInstance fmDefaultFont_12]
//                                     textColor:[FMColor fmColor_g3]];
    
    [_baseView addSubview:_subLabel];
    
    
    _button = [FMBasicButton buttonWithStyle:FMBasicButton_BTN1];
    _button.titleLabel.font = [FMLayoutManagerInstance fmBlodFont_18];
    [_baseView addSubview:_button];
    _button.layer.cornerRadius = kDefaultButtonHeight/2;
    _button.layer.borderWidth = 0;
    _button.layer.masksToBounds = YES;
    
//    [_baseView setBackgroundColor:[FMColor fmColor_white]];
//    [self setBackgroundColor:[FMColor fmColor_white]];
}

-(void)setBaseYPadding:(CGFloat)baseYPadding{
    _baseYPadding = baseYPadding;
    _hadSetBaseYPadding = YES;
}

- (void)setImage:(UIImage *)image{
    [self setImage:image
         labelText:nil
     labelYPadding:0];
}

//设置文本
- (void)setLabelText:(NSString *)labelText{
    [self setImage:nil
         labelText:labelText
     labelYPadding:0];
}

//设置图片和文本
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText{
    [self setImage:image
         labelText:labelText
     labelYPadding:kDefaultLabelPadding];
}

//设置图片和文本，以及文本位置
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText
   labelYPadding:(CGFloat)labelPadding{
    [self setImage:image
         labelText:labelText
     labelYPadding:labelPadding
      subLabelText:@""
   subLabelPadding:kDefaultSubLabelPadding
        buttonText:@""
      buttonTarget:nil
      buttonAction:nil
       btnYPadding:0];
}

//设置图片，文本和按钮，
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText
      buttonText:(NSString *)buttonText
    buttonTarget:(id)buttonTarget
    buttonAction:(SEL)buttonAction{
    [self setImage:image
         labelText:labelText
     labelYPadding:kDefaultLabelPadding
      subLabelText:@""
   subLabelPadding:kDefaultSubLabelPadding
        buttonText:buttonText
      buttonTarget:buttonTarget
      buttonAction:buttonAction
       btnYPadding:kDefaultButtongPadding];
}

//设置图片，文本，子文本和按钮
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText
    subLabelText:(NSString *)subLabelText
      buttonText:(NSString *)buttonText
    buttonTarget:(id)buttonTarget
    buttonAction:(SEL)buttonAction{
    [self setImage:image
         labelText:labelText
     labelYPadding:kDefaultLabelPadding
      subLabelText:subLabelText
   subLabelPadding:kDefaultSubLabelPadding
        buttonText:buttonText
      buttonTarget:buttonTarget
      buttonAction:buttonAction
       btnYPadding:kDefaultButtongPadding];
}

//设置图片，文本和按钮，以及文本，按钮位置
- (void)setImage:(UIImage *)image
       labelText:(NSString *)labelText
   labelYPadding:(CGFloat)labelPadding
    subLabelText:(NSString *)subLabelText
 subLabelPadding:(CGFloat)subLabelPadding
      buttonText:(NSString *)buttonText
    buttonTarget:(id)buttonTarget
    buttonAction:(SEL)buttonAction
     btnYPadding:(CGFloat)btnYPadding{
    if (!image) {//图标
        _imageView.frame = CGRectZero;
    }
    else{
        CGSize size = CGSizeMake(FMFixWidthFloat(image.size.width), FMFixHeightFloat(image.size.height) );
        _imageView.size = size;
        [_imageView setImage:image];
    }
    
    if ([FMStringUtil isEmpty:labelText]) {//第一行文本
        _label.frame = CGRectZero;
        labelPadding = 0.f;
    }
    else{
        _label.text = labelText;
        _label.numberOfLines = 2;
        _label.size = CGSizeMake(SCREEN_WIDTH *0.69, kDefaultButtonHeight);
        [_label sizeToFit];
    }
    
    if ([FMStringUtil isEmpty:subLabelText]) {//子文本
        _subLabel.frame = CGRectZero;
        subLabelPadding = 0.f;
    }
    else{
        _subLabel.text = subLabelText;
        _subLabel.numberOfLines = 0;
        [_subLabel sizeToFit];
    }
    
    if ([FMStringUtil isEmpty:buttonText]) {//按钮
        _button.frame = CGRectZero;
        btnYPadding = 0.f;
    }
    else {
        _button.size = CGSizeMake(kDefaultButtonWidth, kDefaultButtonHeight);
        [_button setTitle:buttonText forState:UIControlStateNormal];
        [_button addTarget:buttonTarget action:buttonAction forControlEvents:UIControlEventTouchUpInside];
    }
    
    CGFloat baseHeight = _imageView.height + _label.height + _subLabel.height + _button.height + FMFixHeightFloat(labelPadding + btnYPadding);
    _baseView.size = CGSizeMake(self.width, baseHeight);
    if (_hadSetBaseYPadding) {
        _baseView.origin = CGPointMake(self.width * 0.5 - _baseView.width * 0.5, FMFixHeightFloat(self.baseYPadding));
    }else{
        _baseView.origin = CGPointMake(self.width * 0.5 - _baseView.width * 0.5, SCREEN_HEIGHT/5 - FMLayoutManagerInstance.fmTopBarHeight);
    }

    
    CGFloat nextY = 0.f;
    [UIView setSubviewCenterOnHorizontal:_imageView AtY:nextY superView:_baseView];
    nextY += _imageView.height + FMFixHeightFloat(labelPadding);
    
    
    [UIView setSubviewCenterOnHorizontal:_label AtY:nextY superView:_baseView];
    nextY += _label.height + FMFixHeightFloat(subLabelPadding);
    
    [UIView setSubviewCenterOnHorizontal:_subLabel AtY:nextY superView:_baseView];
    nextY += _subLabel.height + FMFixHeightFloat(btnYPadding);
    
    [UIView setSubviewCenterOnHorizontal:_button AtY:nextY superView:_baseView];
    
    self.size = CGSizeMake(self.width, _baseView.bottom + _baseView.origin.y);
}

@end
