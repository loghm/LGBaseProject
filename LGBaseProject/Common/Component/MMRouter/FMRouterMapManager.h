//
//  FMRouterMapManager.h
//  MyStoryTest
//
//  Created by 陈炜来 on 15/11/30.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FMRouterHeader.h"


@interface FMRouterMapManager : NSObject
+ (FMRouterMapManager*)sharedInstance;

/**
 *  用json文件编辑起来太容易出错，有空改成plist文件
 *
 *  映射的格式是 meimei://docotr?param0=aValue1&param1=aValue2
 *
         "hospitallist":{
                "mapVC":"FMDoctorAndHospitalViewController",
                "mapSB":"Doctor",
                "mapParams":{
                "param0":"segmentIndex"
                },
                "localParams":{
                    "segmentIndex":"0"
                }
          },
 *  hospitallist 对应服务端给的跳转参数
 *  mapVC 对应的ViewController
 *  mapSB 对应的storyboard
 *  mapParams 对应的参数 ,拼接的URL固定用param0 param1 类推,会自动按顺序赋值，         （如果服务器开始支持多参数，参数的名和值都要进行映射）
 *  localParams 本地controller可能需要一些初始赋值
 */


@property(nonatomic,strong,readonly)NSDictionary *mapDict;


@end
