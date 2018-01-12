//
//  FMGlobalManager.h
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "FMBaseManager.h"
#import "FMGlobalConfigModel.h"

#define FMGlobalManagerInstance [FMGlobalManager shareInstance]
#define FMGlobalConfigModelInstance [FMGlobalManager shareInstance].globalConfig

@interface FMGlobalManager : FMBaseManager

+ (instancetype)shareInstance;

@property (nonatomic, strong) FMGlobalConfigModel *globalConfig;

@property (nonatomic, strong) NSArray *myViewButtons;

@property (nonatomic, assign) long long sysTimeOffset;  // 本地时间 与系统时间的偏差值

//开启定位
- (void)startLocation;

//用户修改了当前城市
- (void)userSelectedCity:(NSString*)city;

//上传用户手机信息，每个新版本打开后1分钟执行
- (void)uploadUserDeviceInfo;

//获取系统时间
- (void)getSystemTime;
@end
