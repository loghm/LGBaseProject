//
//  NSObject+FMPublic.h
//  ForManLive
//
//  Created by 陈慧伟 on 2017/1/22.
//  Copyright © 2017年 陈慧伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FMPublic)

/*
 performSelector 带多个参数
 */
- (id)performSelector:(SEL)aSelector withObjects:(id)object,...;

@end

@interface GKEndMark : NSObject
+ (instancetype)end;
@end
