//
//  UIView+FM_Toast.h
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright (c) 2015年 FM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMShowToastProtocol
@optional
///loading 界面会一直在  直到你调用了  hideHud
-(void)fm_showLoadingHUD;
-(void)fm_showLoadingHUDWithText:(NSString*)text,...;

///隐藏当前的hud
-(void)fm_hideHUD;

///text hud 会自动消失
-(void)fm_showTextHUD:(NSString*)text,...;
-(void)fm_showTextHUDWithDelay:(CGFloat)delay text:(NSString*)text,...;

///显示图片
-(void)fm_showTextHUDWithDelay:(CGFloat)delay image:(UIImage*)image text:(NSString*)text,...;
///中间显示自定义view
-(void)fm_showTextHUDWithDelay:(CGFloat)delay view:(UIView*)view text:(NSString*)text,...;

///静态方法 默认都加在 window 上
+(void)fm_showLoadingHUD;
+(void)fm_showLoadingHUDWithText:(NSString*)text,...;
+(void)fm_hideHUD;
+(void)fm_showTextHUD:(NSString*)text,...;
+(void)fm_showTextHUDWithDelay:(CGFloat)delay text:(NSString*)text,...;
+(void)fm_showTextHUDWithDelay:(CGFloat)delay image:(UIImage*)image text:(NSString*)text,...;
+(void)fm_showTextHUDWithDelay:(CGFloat)delay view:(UIView*)view text:(NSString*)text,...;
@end


///只对UIView 跟 UIViewController  起提示作用  NSObject 调用也不会错就是了
#pragma mark-

@interface UIView (FMToast) <FMShowToastProtocol>

@end


@interface UIViewController (FMToast) <FMShowToastProtocol>

@end