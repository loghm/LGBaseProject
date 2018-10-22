//
//  HelpManager.m
//  AHXRingApp
//
//  Created by 敲代码mac1号 on 16/8/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "HelpManager.h"
#import "ShareView.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"
#import <AddressBookUI/AddressBookUI.h>

@implementation HelpManager

+ (HelpManager *)shareFMDBHelper {
    static HelpManager *helpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helpManager = [[HelpManager alloc] init];
    });
    return helpManager;
}

- (NSMutableArray *)teamClassArray {
    if (!_teamClassArray) {
        self.teamClassArray = [NSMutableArray array];
    }
    return _teamClassArray;
}


//MD5加密算法
+ (NSString *)md5HexDigest:(NSString *)url
{
    const char *original_str = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


+ (void)changeBtnNOenabled:(UIButton *)sender {
//    [sender setBackgroundImage:[UIImage imageNamed:@"bg_nextN"] forState:UIControlStateNormal];
//    sender.enabled = NO;
}

+ (void)changeBtnenabled:(UIButton *)sender {
//    [sender setBackgroundImage:[UIImage imageNamed:@"bg_next"] forState:UIControlStateNormal];
//    sender.enabled = YES;
}

+ (BOOL)isHaveIllegalChar:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location < str.length;
}

//判断是否有中文
+ (BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}



//获取时间差(当前, 几分钟前, 几小时前)
static NSDateFormatter* formater = nil;

+ (NSString*)stringFromDateString:(NSString*)dates {
    
    NSString *date = [self gettttDate:dates];
    NSLog(@"%@", date);//2016-06-30 17:06 //2016-06-30 17:25:41
    
    if(!formater) {
        formater = [[NSDateFormatter alloc]init];
        [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    //获得现在的年月日,小时，分钟
    NSDate* nowDate = [NSDate date];
    
    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //发布时间
    NSLog(@"%@", date);
    NSLog(@"%@", formater);
    NSDate* pubDate = [formater dateFromString:date];
    NSLog(@"%@", pubDate);
    //如果发布时间比现在的时间还大，直接显示刚刚
    if ([pubDate compare:nowDate] == NSOrderedDescending)
        return @"刚刚";

    //时间差
    NSTimeInterval delta = [nowDate timeIntervalSinceDate:pubDate];
    
    if(delta<60){
        //小于60秒
        return @"刚刚";
    }else if (delta < 3600){
        //一小时以内
        return [NSString stringWithFormat:@"%.0f分钟前",delta/60.0f];
    }else if (delta < 3600 * 24){
        //24小时内
        return [NSString stringWithFormat:@"%.0f小时前",delta/3600.0f ];
    }else{
        [formater setDateFormat:@"MM/dd"];
        return [formater stringFromDate:pubDate];
    }
    
}

+ (NSString *)gettttDate:(NSString *)dateStrr {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStrr doubleValue] / 1000];
    NSDateFormatter *DATEFormatter = [[NSDateFormatter alloc] init];
    [DATEFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *getdateStr = [DATEFormatter stringFromDate:confromTimesp];
    return getdateStr;
}



//按比例缩小图片
+ (UIImage *)scaleImage:(UIImage *)img toScale:(CGFloat )scale {
    CGSize imgSize = img.size;
    CGSize scaleSize = CGSizeMake(imgSize.width*scale, imgSize.height*scale);
    
    UIGraphicsBeginImageContext(scaleSize);
    [img drawInRect:CGRectMake(0, 0, imgSize.width*scale, imgSize.height*scale)];
    
    UIImage * scaleImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImg;
}



+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >>16) &0xFF;
    int g = (hex >>8) &0xFF;
    int b = (hex) &0xFF;
    return[UIColor colorWithRed:r /255.0f
                          green:g /255.0f
                           blue:b /255.0f
                          alpha:1.0f];
}

/**
 * 将UIColor变换为UIImage
 *
 **/

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



/**
 *  上传多张图片
 *  @param url     接口地址
 *  @param params  上传的参数
 *  @param file    图片数组
 *  @param name    图片传@"image"/
 *  @param success 成功block
 *  @param failure 失败block
 */
+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSArray *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
{
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //发起请求
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSInteger ID = 100;
        //将UIImage转换为NSData
        for (UIImage *images in file) {
            //压缩比例
            NSData *data = UIImageJPEGRepresentation(images, 0.01);
            [formData appendPartWithFileData:data name:name fileName:[NSString stringWithFormat:@"%ld.jpg",(long)ID] mimeType:@"image/jpeg"];
            ID++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        NSLog(@"%lld", uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if (success) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(result);
            } else {
                success(responseObject);
            }
        }
        //上传成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        if (failure) {
            failure(error);
        }
    }];
    //添加到操作队列
}


+ (NSString *)getDate:(NSString *)dateStr {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue] / 1000];
    NSDateFormatter *DATEFormatter = [[NSDateFormatter alloc] init];
    [DATEFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *getdateStr = [DATEFormatter stringFromDate:confromTimesp];
    return getdateStr;
}

//图片模糊处理
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    
    if (!image) {
        return nil;
    }
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    
    return returnImage;
}


+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         if (error)
                                                         {
                                                             NSLog(@"Error: %@", (__bridge NSError *)error);
                                                         }
                                                         else if (!granted)
                                                         {
                                                             
                                                             block(NO);
                                                         }
                                                         else
                                                         {
                                                             block(YES);
                                                         }
                                                     });
                                                 });
    }
    else
    {
        block(YES);
    }
    
}



+ (void)clispView:(UIView *)custView With:(float)cornerRadius {
    
    custView.layer.cornerRadius = cornerRadius;
    custView.layer.masksToBounds = YES;
}


+ (NSString *)getDate:(NSString *)dateStr With:(NSString *)formatStr {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]];
    NSDateFormatter *DATEFormatter = [[NSDateFormatter alloc] init];
    [DATEFormatter setDateFormat:formatStr];
    NSString *getdateStr = [DATEFormatter stringFromDate:confromTimesp];
    return getdateStr;
}

+(NSString *)imageToBase64String:(UIImage *)image {
    return [self imageToBase64String:image headerSign:YES];
}

+ (NSString *)imageToBase64String:(UIImage *)image headerSign:(BOOL)headerSign {
    
    if (image) {
        NSData *data = UIImagePNGRepresentation(image);
        NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        if (headerSign) {
            base64String = [@"data:image/png;base64," stringByAppendingString:base64String];
        }
        return base64String;
        
    } else {
        return nil;
    }
    
}

+ (UIImage *)base64StringToUIImage:(NSString *)base64String {
    
    NSString *tempString = base64String;
    
    if ([base64String hasPrefix:@"data:image"]) {
        tempString = [[tempString componentsSeparatedByString:@","] lastObject];
    }
    
    NSData *imageData = [[NSData alloc]
                                
                                initWithBase64EncodedString:tempString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *decodedImage = [UIImage imageWithData:imageData];
    
    return decodedImage;
}

//剔除卡号里的非法字符
-(NSString *)getDigitsOnly:(NSString*)s
{
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < s.length; i++)
    {
        c = [s characterAtIndex:i];
        //isdigit是计算机C(C++)语言中的一个函数，主要用于检查其参数是否为十进制数字字符
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    return digitsOnly;
}


//检验银行卡号的有效性 Luhn算法
+ (BOOL)isValidCardNumber:(NSString *)cardNumber {
    NSString *digitsOnly = [[HelpManager shareFMDBHelper] getDigitsOnly:cardNumber];
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (int i = (int)(digitsOnly.length - 1); i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}



@end
