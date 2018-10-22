//
//  HealthKitManager.h
//  LGStepsProject
//
//  Created by loghm on 2018/7/2.
//  Copyright © 2018年 loghm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import <UIKit/UIKit.h>

#define HKVersion [[[UIDevice currentDevice] systemVersion] doubleValue]
#define CustomHealthErrorDomain @"com.denc.healthError"

@interface HealthKitManager : NSObject

@property (nonatomic, strong) HKHealthStore *healthStore;

+(id)shareInstance;
- (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))compltion;
- (void)getDistance:(void(^)(double value, NSError *error))completion;
- (void)getStepCount:(void(^)(double value, NSError *error))completion;

@end
