//
//  UIButton+EventInterval.h
//  LGBaseProject
//
//  Created by loghm on 2018/9/3.
//  Copyright © 2018年 loghm. All rights reserved.
//

//通过Runtime控制UIButton响应事件的时间间隔

#import <UIKit/UIKit.h>

@interface UIButton (EventInterval)
/** 按钮点击响应间隔时间*/
@property (nonatomic, assign) NSTimeInterval qi_eventInterval;

@end
