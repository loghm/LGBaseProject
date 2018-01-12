//
//  FMToolsFunction.h
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMToolsFunction : NSObject

/**
 *  打印对象的各属性的值
 *
 *  @param cls 具体对象
 */
+ (void)printfObject:(id)cls;

/**
 *  计算字符串长度，用于显示一行的
 *
 *  @param string 要计算的字符串
 *  @param font   字体
 *
 *  @return size
 */
+ (CGSize)sizeForString:(NSString*)string withFont:(UIFont*)font;

/**
 *  计算字符串显示范围高度，用于显示多行
 *
 *  @param string 要计算的字符串
 *  @param font   字体
 *  @param width  限定的宽度
 *
 *  @return size
 */
+ (CGSize)sizeForString:(NSString *)string withFont:(UIFont *)font withWidth:(CGFloat)width;

/**
 *  计算字符串显示范围高度，用于显示多行
 *
 *  @param string           要计算的字符串
 *  @param font             字体
 *  @param characterSpacing 字间距
 *  @param lineSpacing      行间距
 *  @param width            限定的宽度
 *
 *  @return size
 */
+ (CGSize)sizeForString:(NSString *)string withFont:(UIFont*)font withCharacterSpacing:(CGFloat)characterSpacing withLineSpacing:(CGFloat)lineSpacing withMaxWidth:(CGFloat)width;

/**
 *  用于一些使用以上方法计算出的size有问题的，本方法使用uilabel来自动计算
 *
 *  @param string           要计算的字符串
 *  @param font             字体
 *  @param characterSpacing 字间距
 *  @param lineSpacing      行间距
 *  @param width            限定的宽度
 *
 *  @return size
 */
+ (CGSize)labelSizeForString:(NSString *)string withFont:(UIFont*)font withCharacterSpacing:(CGFloat)characterSpacing withLineSpacing:(CGFloat)lineSpacing withMaxWidth:(CGFloat)width;

/**
 *  获取httpHead头
 *
 *  @return <#return value description#>
 */
+ (NSString *)fmHttpHeadDefaultString;

+ (NSString *)getImageUploadUUid;

///截屏
+ (UIImage*)screenShotWithView:(UIView*)view;

/**
 *  验证手机号是否有效
 *
 *  @param phone 输入的手机号
 *
 *  @return YES 有效\NO 无效
 */
+ (BOOL)verifyMobilePhone:(NSString*)phone;

/**
 *  验证身份证是否有效
 *
 *  @param cardId 输入的身份证
 *
 *  @return YES 有效\NO 无效
 */
+ (BOOL)verifyCardId:(NSString*)cardId;

/**
 *  获取汉字的首拼
 *
 *  @param chinese 汉字
 *
 *  @return 首拼(获取不到拼音则返回"#")
 */
+ (NSString*)getSpellForChinese:(NSString*)chinese;

/**
 *  拼接web用的url
 *
 *  @param prefix url
 *  @param params 参数
 *
 *  @return 带参的url
 */
+(NSString *)componentUrlWithPrefix:(NSString *)prefix params:(NSDictionary *)params;

/**
 *  显示时间间隔，带几点几分。如x年x月x日 hh：mm
 *
 *  @param time         时间
 *  @param have         YES 带具体时间， NO 不带具体时间  (几点几分)
 *
 *  @return 刚刚 \ x分钟前 \ x小时前 \ 昨天 hh：mm \ 前天 hh：mm \ x月x日 hh：mm \ x年x月x日 hh：mm
 */
+ (NSString*)stringTimeInterValWith:(NSTimeInterval)time haveHourMinutes:(BOOL)have;

/**
 *  显示时间间隔，带几点几分。如x年x月x日 hh：mm
 *
 *  @param date         NSDate时间
 *  @param have         YES 带具体时间， NO  不带具体时间  (几点几分)
 *
 *  @return 刚刚 \ x分钟前 \ x小时前 \ 昨天 hh：mm \ 前天 hh：mm \ x月x日 hh：mm \ x年x月x日 hh：mm
 */
+ (NSString*)stringTimeForDate:(NSDate*)date haveHourMunite:(BOOL)have;

+ (NSString*)stringTimeForString:(NSString*)dateString haveHourMunite:(BOOL)have;

///获取iphone几代
+ (NSString*)getDeviceVersion;
///获取网络类型
+ (NSString*)getNetworkType;


//获取idafa
+ (NSString *)getIDFAString;


//获取等级图片
+ (UIImage*)getLevelImage:(NSInteger)level;

//播放音效
+ (void)playSoundWithFileName:(NSString*)fileName;

//播放进房间音效
+ (void)playIntoRoom;
//播放游戏开局音效
+ (void)playGameStart;
//播放游戏赢了的音效
+ (void)playGameWin;
//播放游戏输了的音效
+ (void)playGameLose;
//播放领取钻石的音效
+ (void)playGetDiamond;

+ (BOOL)isAppStoreInReview ;

//兑换记录显示的时间
+ (NSString*)exchangeShowTimeStringFrom:(NSString*)dateString;
@end
