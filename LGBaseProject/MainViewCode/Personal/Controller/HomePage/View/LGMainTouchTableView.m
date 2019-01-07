//
//  LGMainTouchTableView.m
//  LGBaseProject
//
//  Created by loghm on 2018/10/24.
//  Copyright © 2018 loghm. All rights reserved.
//

#import "LGMainTouchTableView.h"
#import "LGSegmentHeaderView.h"

@implementation LGMainTouchTableView

//是否让外层tableView的手势透传到子视图
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    CGFloat segmentViewContentScrollViewHeight = SCREEN_HEIGHT - STATUS_HEIGHT - [FMLayoutManager shareInstance].dtNavBarHeight - SegmentHeaderViewHeight;
    CGPoint currentPoint = [gestureRecognizer locationInView:self];
    if (CGRectContainsPoint(CGRectMake(0, self.contentSize.height - segmentViewContentScrollViewHeight, SCREEN_WIDTH, segmentViewContentScrollViewHeight), currentPoint) ) {
        return YES;
    }
    return NO;
}

@end
