//
//  UIImage+Sub.h
//  ForManLive
//
//  Created by apple on 2017/1/20.
//  Copyright © 2017年 CHW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Sub)

//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect;

-(UIImage*)scaleToSize:(CGSize)size;
@end
