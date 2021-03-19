//
//  UIImage+LGFoundation.m
//  LGBaseProject
//
//  Created by 黄明族 on 2020/7/6.
//  Copyright © 2020 loghm. All rights reserved.
//

#import "UIImage+LGFoundation.h"

@implementation UIImage (LGFoundation)

#pragma mark - scale

- (UIImage *)lg_scaledImageByFactorX:(CGFloat)factorX factorY:(CGFloat)factorY {
    CGSize newSize = CGSizeMake(ceil(self.size.width * factorX), ceil(self.size.height * factorY));

    UIGraphicsBeginImageContextWithOptions(newSize, NO, self.scale);

    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

- (UIImage *)lg_scaledImageByFactor:(CGFloat)factor {
    return [self lg_scaledImageByFactorX:factor factorY:factor];
}

- (UIImage *)imy_scaledImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);

    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

- (UIImage *)lg_scaledImageWithMaxSize:(CGSize)maxSize {
    CGSize size = self.size;
    if (size.width > maxSize.width || size.height > maxSize.height) {
        CGFloat factor1 = maxSize.width / size.width;
        CGFloat factor2 = maxSize.height / size.height;
        UIImage *newImage = [self lg_scaledImageByFactor:MIN(factor1, factor2)];
        return newImage;
    } else {
        // 如果小于maxSize，返回原图
        return self;
    }
}

@end
