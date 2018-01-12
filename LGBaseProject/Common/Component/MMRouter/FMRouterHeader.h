//
//  FMRouterHeader.h
//  MeiMei
//
//  Created by 陈炜来 on 15/12/7.
//  Copyright © 2015年 MeiMei. All rights reserved.
//



#ifndef FMRouterHeader_h
#define FMRouterHeader_h


#define FM_Router_Suffix_OutMeimei @"FM_router_suffix_string=outForMan"

typedef NS_ENUM(NSUInteger, FMHomeStyle2) {
    // 0不跳转 1内链 2外链
    kFMHomeStyle2None=0,
    kFMHomeStyle2AppLinks=1,
    kFMHomeStyle2OutLinks=2,
    kFMHomeStyle2Max=10000
};

@protocol FMRouterModelProtocol <NSObject>

@property (nonatomic ,copy)NSString *url; //路由名称
@property (nonatomic ,copy)NSString *href;//路由参数
@property (nonatomic ,assign)FMHomeStyle2 style2; //0:不跳转 1:内嵌网页 2:外链接

@end
#endif /* FMRouterHeader_h */
