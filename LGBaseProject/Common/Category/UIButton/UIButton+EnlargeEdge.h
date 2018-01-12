//
//  EnlargeEdge.h
//  ForManLive
//
//  Created by apple on 2016/12/21.
//  Copyright © 2016年 CHW. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <objc/runtime.h>


/**
 设置Button的响应区域
 */
@interface UIButton (EnlargeEdge)
- (void)setEnlargeEdge:(CGFloat) size;
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
@end
