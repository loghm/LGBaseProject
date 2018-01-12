//
//  FMBaseRouterModel.h
//  ForManLive
//
//  Created by apple on 2016/12/21.
//  Copyright © 2016年 CHW. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 路由跳转
 */
@interface FMBaseRouterModel : NSObject

@property (nonatomic, copy  ) NSString *href;//路由参数
@property (nonatomic, assign) FMHomeStyle2 style2;//0不跳转 1内嵌网页 2外链   //当style=3此字段未用
@property (nonatomic, copy  ) NSString *url;//路由名称

@end
