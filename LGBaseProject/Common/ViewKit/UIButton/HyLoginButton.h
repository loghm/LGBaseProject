//
//  HyLoglnButton.h
//  Example
//
//  Created by  东海 on 15/9/2.
//  Copyright (c) 2015年 Jonathan Tribouharet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBasicButton.h"

typedef void(^HyAnimationCompletion)();

@interface HyLoginButton : FMBasicButton

-(void)failedAnimationWithCompletion:(HyAnimationCompletion)completion;

-(void)succeedAnimationWithCompletion:(HyAnimationCompletion)completion;

- (void)scaleAnimation;

@end
