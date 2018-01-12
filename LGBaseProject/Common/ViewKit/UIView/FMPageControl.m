//
//  FMPageControl.m
//  ForMan
//
//  Created by CHW on 2016/11/15.
//  Copyright © 2016年 RuiBao. All rights reserved.
//

#import "FMPageControl.h"

@implementation FMPageControl

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    [self updateDots];
}

- (void)updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView* dot = [self.subviews objectAtIndex:i];
        //添加imageView
        if ([dot.subviews count] == 0) {
            UIImageView * view = [[UIImageView alloc]initWithFrame:dot.bounds];
            [dot addSubview:view];
        };
        
        //配置imageView
        UIImageView * view = dot.subviews[0];
        
        if (i==self.currentPage)
        {
            view.image = self.selectedDot;
            dot.backgroundColor = [UIColor clearColor];
        }
        else
        {
            view.image = self.unSelectedDot;
            dot.backgroundColor = [UIColor clearColor];
        }
    }
}

@end
