//
//  LGNetWorkAction.h
//  LGBaseProject
//
//  Created by loghm on 2017/12/14.
//  Copyright © 2017年 loghm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LGRequestSuccess)(id requestTask, id responseObject);
typedef void(^LGRequestFailure)(id requestTask,  NSError *error);

@interface LGNetWorkAction : NSObject

+ (LGNetWorkAction *)shareInstance;



@end
