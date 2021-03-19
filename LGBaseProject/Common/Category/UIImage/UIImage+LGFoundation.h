//
//  UIImage+LGFoundation.h
//  LGBaseProject
//
//  Created by 黄明族 on 2020/7/6.
//  Copyright © 2020 loghm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LGFoundation)

#pragma mark - scale
// 等比 缩放
- (UIImage *)lg_scaledImageByFactor:(CGFloat)factor;
- (UIImage *)imy_scaledImageWithSize:(CGSize)size;
- (UIImage *)lg_scaledImageWithMaxSize:(CGSize)maxSize;

@end
