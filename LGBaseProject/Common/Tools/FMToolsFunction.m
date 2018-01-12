//
//  FMToolsFunction.m
//  ForMan
//
//  Created by chw on 16/6/6.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMToolsFunction.h"
#import "NSMutableAttributedString+FMPublic.h"
#import "pinyin.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@implementation FMToolsFunction

/**
 *  打印对象的各属性的值
 *
 *  @param cls 具体对象
 */
+ (void)printfObject:(id)cls
{
    unsigned int outCount = 0;
    
    // 属性操作
    objc_property_t * properties = class_copyPropertyList([cls class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *str = [NSString stringWithUTF8String:property_getName(property)];
        NSLog(@"%s: %@", property_getName(property), [cls valueForKey:str]);
    }
    
    free(properties);
}

/**
 *  计算字符串长度，用于显示一行的
 *
 *  @param string 要计算的字符串
 *  @param font   字体
 *
 *  @return size
 */
+ (CGSize)sizeForString:(NSString*)string withFont:(UIFont*)font
{
    CGSize size = [string sizeWithAttributes:@{NSFontAttributeName:font}];
    return size;
}

/**
 *  计算字符串显示范围高度，用于显示多行
 *
 *  @param string 要计算的字符串
 *  @param font   字体
 *  @param width  限定的宽度
 *
 *  @return size
 */
+ (CGSize)sizeForString:(NSString *)string withFont:(UIFont *)font withWidth:(CGFloat)width
{
    if (!string || string.length < 1)
        return CGSizeZero;
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}

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
+ (CGSize)sizeForString:(NSString *)string withFont:(UIFont *)font withCharacterSpacing:(CGFloat)characterSpacing withLineSpacing:(CGFloat)lineSpacing withMaxWidth:(CGFloat)width
{
    if (!string || string.length < 1)
        return CGSizeZero;
    NSMutableAttributedString *attributedString = [NSMutableAttributedString fm_AttrubutedString:string lineSpacing:lineSpacing characterSpacing:characterSpacing font:font];
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    return rect.size;
}

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
+ (CGSize)labelSizeForString:(NSString *)string withFont:(UIFont*)font withCharacterSpacing:(CGFloat)characterSpacing withLineSpacing:(CGFloat)lineSpacing withMaxWidth:(CGFloat)width
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = width;
    [label fmSetText:string withLineSpacing:lineSpacing withCharacterSpacing:characterSpacing withTextColor:[FMColor fmColor_g1] withFont:font textAligment:NSTextAlignmentCenter];
    [label sizeToFit];
    return label.size;
}

/**
 *  获取httpHead头
 *
 *  @return <#return value description#>
 */
+ (NSString *)fmHttpHeadDefaultString
{
    NSMutableString *org=[[NSMutableString alloc]init];
    [org appendString:[FMToolsFunction fmHttpHeadAppId]];
//    [org appendString:[FMToolsFunction fmHttpHeadClientId]];
    [org appendString:[FMToolsFunction fmHttpHeadVersion]];
//    [org appendString:[FMToolsFunction fmHttpHeadChannel]];
    return org;
}

/**
 *  获取http头中的id
 *
 *  @return <#return value description#>
 */
+ (NSString *)fmHttpHeadAppId
{
    return @"01";
}

/**
 *  @return 获取平台Id
 */
//+ (NSString *)fmHttpHeadClientId
//{
//    if ([MobClick isJailbroken]) {
//        return @"11";//越狱包
//    }
//    return @"10";//iOS普通包
//}
/**
 *  @return 标识应用的版本号
 */
+ (NSString *)fmHttpHeadVersion
{
    NSString *version=  APPVersion;
    
    NSCharacterSet *cs=[NSCharacterSet characterSetWithCharactersInString:@"." ];
    NSArray *sepArray= [version componentsSeparatedByCharactersInSet:cs];
    NSMutableArray *finalArray=[sepArray mutableCopy];
    
    if (sepArray.count>0) {
        NSString *str= [sepArray firstObject];
        if (str.length==1) {//首位大本号是 两位，所以不足要补零
            str=[NSString stringWithFormat:@"0%@",str];
            [finalArray replaceObjectAtIndex:0 withObject:str];
        }
    }
    
    for (int i=0 ;i<(3-finalArray.count);i++) {//不足3阶 版本号补零
        [finalArray addObject:@"0"];
    }
    
    //4.3.6=>0436
    NSString *filtered = [finalArray componentsJoinedByString:@""];
    //4.3.6.11=>加上两位Build号
    //    NSString *buildVersion=APPBuildVersion;
    //    filtered =[filtered stringByAppendingString:buildVersion];
    return filtered;
}
/**
    渠道号 0001 牛牛 福利0002  黑牛0012
 *
 *  临时写死
 */
//+(NSString *)fmHttpHeadChannel
//{
//    /**
//     *  0012 appstore
//     *  0001 同步推
//     */
//    return FMHTTPHEAD_CHANNEL;
//}

+ (NSString *)getImageUploadUUid
{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    uuid=  [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuid;
}

+ (UIImage*)screenShotWithView:(UIView*)view
{
    NSLog(@"截屏的view大小:%@", NSStringFromCGRect(view.frame));
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);     //设置截屏大小
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

/**
 *  验证手机号是否有效
 *
 *  @param phone 输入的手机号
 *
 *  @return YES 有效\NO 无效
 */
+ (BOOL)verifyMobilePhone:(NSString*)phone
{
    phone = [phone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *regex = @"^((13[0-9])|(14[5,7])|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL res = [pred evaluateWithObject:phone];
    return res;
}

/**
 *  验证身份证是否有效
 *
 *  @param phone 输入的身份证
 *
 *  @return YES 有效\NO 无效
 */
+ (BOOL)verifyCardId:(NSString*)cardId
{
    cardId = [cardId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *regex = @"\\d{15}|\\d{17}[0-9Xx]";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL res = [pred evaluateWithObject:cardId];
    return res;
}

/**
 *  获取汉字的首拼
 *
 *  @param chinese 汉字
 *
 *  @return 首拼(获取不到拼音则返回"*")
 */
+ (NSString*)getSpellForChinese:(NSString*)chinese
{
    if(![chinese isEqualToString:@""]){
        //join the pinYin
        NSString *pinYinResult = [NSString string];
        for(int j = 0;j < chinese.length; j++) {
            NSString *singlePinyinLetter = [[NSString stringWithFormat:@"%c",
                                             pinyinFirstLetter([chinese characterAtIndex:j])]uppercaseString];
            
            pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
        }
        if (pinYinResult)
            return pinYinResult;
        else
            return @"*";
    } else {
        return @"";
    }
}

/**
 *  拼接web用的url
 *
 *  @param host   <#host description#>
 *  @param suffix <#suffix description#>
 *  @param params <#params description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)componentUrlWithPrefix:(NSString *)prefix params:(NSDictionary *)params
{
    NSMutableString *componentUrl=[NSMutableString new];
    //    [componentUrl appendString:host];
    [componentUrl appendString:prefix];
    [componentUrl appendString:@"?"];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [componentUrl appendFormat:@"%@=%@&",key,obj];
    }];
    NSString *url= [componentUrl substringToIndex:componentUrl.length-1];
    return url;
}

/**
 *  显示时间间隔，带几点几分。如x年x月x日 hh：mm
 *
 *  @param time         时间
 *  @param have         YES 带具体时间， NO 不带具体时间  (几点几分)
 *
 *  @return 刚刚 \ x分钟前 \ x小时前 \ 昨天 hh：mm \ 前天 hh：mm \ x月x日 hh：mm \ x年x月x日 hh：mm
 */
+ (NSString*)stringTimeInterValWith:(NSTimeInterval)time haveHourMinutes:(BOOL)have
{
    NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:time];
    return [self stringTimeForDate:fromDate haveHourMunite:have];
}

//+ (NSString*)stringTimeForString:(NSString*)dateString haveHourMunite:(BOOL)have
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *date=[formatter dateFromString:dateString];
//    return [self stringTimeForDate:date haveHourMunite:have canShowSinceTime:YES];
//}
//+ (NSString*)stringTimeForDate:(NSDate*)date haveHourMunite:(BOOL)have
//{
//    return  [self stringTimeForDate:date haveHourMunite:have canShowSinceTime:NO];
//}

/**
 *  显示时间间隔，带几点几分。如x年x月x日 hh：mm
 *
 *  @param date         NSDate时间
 *  @param have         YES 带具体时间， NO 不带具体时间  (几点几分)
 *
 *  @return 刚刚 \ x分钟前 \ x小时前 \ 昨天 hh：mm \ 前天 hh：mm \ x月x日 hh：mm \ x年x月x日 hh：mm
 */

/*
+ (NSString*)stringTimeForDate:(NSDate*)date haveHourMunite:(BOOL)have canShowSinceTime:(BOOL)sinceTime
{
    if (!date)
        return nil;
    NSDate *fromDate = date;
    NSTimeInterval time = [fromDate timeIntervalSince1970];
    NSDate *nowDate = [NSDate date];
    if (!sinceTime) {
        if (time > [nowDate timeIntervalSince1970])   //超过当前时间显示未知
            return @"未知时间";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeInterval temp = [nowDate timeIntervalSinceDate:fromDate];
    if (temp < 60)              //小于60秒
        return @"刚刚";
    else if (temp < 60*60)      //小于1小时
        return [NSString stringWithFormat:@"%d分钟前", ((int)temp)/60];
    else if (temp < 24*60*60)   //小于1天
        return [NSString stringWithFormat:@"%d小时前", ((int)temp)/(60*60)];
    else
    {
        NSTimeInterval t = [[NSDate mt_startOfYesterday] timeIntervalSince1970];
        if (time > t)     //昨天
        {
            [formatter setDateFormat:@"HH:mm"];
            NSString *str = [formatter stringFromDate:fromDate];
            if (have)
                return [NSString stringWithFormat:@"昨天 %@", str];
            else
                return @"昨天";
        }
        t -= 24*60*60;   //前天开始时间
        if (time > t)   //大于前天开始时间，即是前天
        {
            [formatter setDateFormat:@"HH:mm"];
            NSString *str = [formatter stringFromDate:fromDate];
            if (have)
                return [NSString stringWithFormat:@"前天 %@", str];
            else
                return @"前天";
        }
        else    //前天之前
        {
            if (fromDate.mt_year != nowDate.mt_year) //不是今年
            {
                if (have)
                    [formatter setDateFormat:@"y年M月d日 HH:mm"];
                else
                    [formatter setDateFormat:@"y年M月d日"];
                return [formatter stringFromDate:fromDate];
            }
            else    //今年
            {
                if (have)
                    [formatter setDateFormat:@"M月d日 HH:mm"];
                else
                    [formatter setDateFormat:@"M月d日"];
                return [formatter stringFromDate:fromDate];
            }
        }
    }
    return @"未知时间";
}

*/

///获取iphone几代
+ (NSString*)getDeviceVersion
{
    NSDictionary* deviceNamesByCode = @{
                                        //iPhones
                                        @"iPhone3,1" :@"iPhone4",
                                        @"iPhone3,3" :@"iPhone4",
                                        @"iPhone4,1" :@"iPhone4S",
                                        @"iPhone5,1" :@"iPhone5",
                                        @"iPhone5,2" :@"iPhone5",
                                        @"iPhone5,3" :@"iPhone5C",
                                        @"iPhone5,4" :@"iPhone5C",
                                        @"iPhone6,1" :@"iPhone5S",
                                        @"iPhone6,2" :@"iPhone5S",
                                        @"iPhone7,2" :@"iPhone6",
                                        @"iPhone7,1" :@"iPhone6Plus",
                                        @"iPhone8,1" :@"iPhone6S",
                                        @"iPhone8,2" :@"iPhone6SPlus",
                                        @"i386"      :@"simulator",
                                        @"x86_64"    :@"simulator",
                                        
                                        
                                        //iPads
                                        @"iPad1,1" :@"iPad1",
                                        @"iPad2,1" :@"iPad2",
                                        @"iPad2,2" :@"iPad2",
                                        @"iPad2,3" :@"iPad2",
                                        @"iPad2,4" :@"iPad2",
                                        @"iPad2,5" :@"iPadMini",
                                        @"iPad2,6" :@"iPadMini",
                                        @"iPad2,7" :@"iPadMini",
                                        @"iPad3,1" :@"iPad3",
                                        @"iPad3,2" :@"iPad3",
                                        @"iPad3,3" :@"iPad3",
                                        @"iPad3,4" :@"iPad4",
                                        @"iPad3,5" :@"iPad4",
                                        @"iPad3,6" :@"iPad4",
                                        @"iPad4,1" :@"iPadAir",
                                        @"iPad4,2" :@"iPadAir",
                                        @"iPad4,4" :@"iPadMiniRetina",
                                        @"iPad4,5" :@"iPadMiniRetina"
                                        
                                        
                                        };
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return [deviceNamesByCode objectForKey:code];
}


///获取网络类型
+ (NSString*)getNetworkType
{
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *subviews = [[[application valueForKey:@"statusBar"] valueForKey:@"foregroundView"]subviews];
    NSNumber *dataNetWorkItemView = nil;
    for (id subView in subviews) {
        if ([subView isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetWorkItemView = subView;
            break;
        }
    }
    
    NSInteger type = [[dataNetWorkItemView valueForKey:@"dataNetworkType"]integerValue];
    switch (type) {
        case 0:
            return nil;
            break;
            
        case 1:
            return @"2G";
            break;
            
        case 2:
            return @"3G";
            break;
        case 3:
            return @"4G";
            break;
        case 4:
            return @"5G";
            break;
        default:
            return @"Wifi";
            break;
    }
}
//获取idafa
+ (NSString*)getIDFAString
{
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}

//获取等级图片
+ (UIImage*)getLevelImage:(NSInteger)level
{
    UIImage *myImage = nil;
    if (level < 2)
        myImage = [UIImage imageNamed:@"LV1"];
    else if (level < 10)
        myImage = [UIImage imageNamed:@"lv2"];
    else if (level < 20)
        myImage = [UIImage imageNamed:@"lv10"];
    else if (level < 30)
        myImage = [UIImage imageNamed:@"lv20"];
    else if (level < 40)
        myImage = [UIImage imageNamed:@"lv30"];
    else if (level < 50)
        myImage = [UIImage imageNamed:@"lv40"];
    else if (level < 60)
        myImage = [UIImage imageNamed:@"lv50"];
    else if (level < 70)
        myImage = [UIImage imageNamed:@"lv60"];
    else if (level < 80)
        myImage = [UIImage imageNamed:@"lv70"];
    else if (level < 90)
        myImage = [UIImage imageNamed:@"lv80"];
    else if (level < 100)
        myImage = [UIImage imageNamed:@"lv90"];
    else
        myImage = [UIImage imageNamed:@"lv100"];
    
    NSString *myWatermarkText = [NSString stringWithFormat:@"Lv%ld", level];
    UIImage *watermarkedImage = nil;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:myWatermarkText attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:12], NSParagraphStyleAttributeName:paragraphStyle}];
    
    CGFloat x = 8;
    if (level > 99)
        x = 2.5;
    else if (level > 9)
        x = 4.5;
    if (level < 99)
    {
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, myWatermarkText.length)];
        [string addAttribute:NSKernAttributeName value:[NSNumber numberWithInt:-1] range:NSMakeRange(0, myWatermarkText.length)];
    }
    else
    {
        [string addAttribute:NSForegroundColorAttributeName value:[FMColor fmColor_B1] range:NSMakeRange(0, myWatermarkText.length)];
        [string addAttribute:NSKernAttributeName value:[NSNumber numberWithInt:-1] range:NSMakeRange(0, myWatermarkText.length-2)];
        [string addAttribute:NSKernAttributeName value:[NSNumber numberWithInt:-2] range:NSMakeRange(myWatermarkText.length-3, 2)];
    }
    
    UIGraphicsBeginImageContextWithOptions(myImage.size, NO, 2);
    [myImage drawAtPoint: CGPointZero];
    [string drawAtPoint:CGPointMake(x, -1)];
    watermarkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return watermarkedImage;
}

//播放音效
+ (void)playSoundWithFileName:(NSString*)fileName
{
//    SystemSoundID soundID;
//    // 加载文件
//    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"]];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileURL), &soundID);
//
//    // 播放短频音效
//    AudioServicesPlaySystemSound(soundID);
}

//播放进房间音效
+ (void)playIntoRoom
{
//    [self playSoundWithFileName:@"live_room_start"];
}
//播放游戏开局音效
+ (void)playGameStart
{
//    [self playSoundWithFileName:@"live_room_start"];
}
//播放游戏赢了的音效
+ (void)playGameWin
{
    [self playSoundWithFileName:@"竞猜成功"];
}
//播放游戏输了的音效
+ (void)playGameLose
{
    [self playSoundWithFileName:@"竞猜失败"];
}
//播放领取钻石的音效
+ (void)playGetDiamond
{
    [self playSoundWithFileName:@"live_room_receive"];
}

//+ (BOOL)isAppStoreInReview {
//    NSDate *nowDate = [NSDate date];
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
////    NSDate *checkDeadlineDate = [dateFormatter dateFromString:APP_STORE_CHECK_DEADLINE];
//
////    if ([nowDate compare:checkDeadlineDate] == NSOrderedDescending) {
////        return NO;
////    }
////    else {
////        return YES;
////    }
//}

/*
+ (NSString*)exchangeShowTimeStringFrom:(NSString*)dateString
{
    if (dateString.length < 1)
        return nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:dateString];
    
    NSDate *fromDate = date;
    NSTimeInterval time = [fromDate timeIntervalSince1970];
    
//    if (time > [[NSDate mt_endOfToday] timeIntervalSince1970])   //超过当前时间显示未知
//        return nil;
    
    NSDate *nowDate = [NSDate date];
    
//    if ([date mt_isWithinSameDay:nowDate])   //今天
//        return @"今天";
    else
    {
        NSDate *yesterday = [NSDate mt_startOfYesterday];
        if ([date mt_isWithinSameDay:yesterday])
        {
            return @"昨天";
        }
        NSTimeInterval t = [yesterday timeIntervalSince1970];
        t -= 24*60*60;   //前天开始时间
        if (time > t)   //大于前天开始时间，即是前天
        {
            return @"前天";
        }
        else    //前天之前
        {
            [formatter setDateFormat:@"yyyy-mm-dd"];
            return [formatter stringFromDate:fromDate];
        }
    }
    return nil;
}

*/

@end
