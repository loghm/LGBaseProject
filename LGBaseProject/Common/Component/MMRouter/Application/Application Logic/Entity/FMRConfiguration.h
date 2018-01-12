//
//  FMRConfiguration.h
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FMRURLStyle) {
    FMRURLStylePathInfo,
    FMRURLStyleQueryString
};

@interface FMRConfiguration : NSObject

@property (nonatomic, copy) NSArray *schemes;

@property (nonatomic, assign) FMRURLStyle URLStyle;

+ (FMRConfiguration *)defaultConfiguration;

@end
