
//
//  FMBadgeButton+ImageView.m
//  ForManLive
//
//  Created by apple on 2017/3/31.
//  Copyright © 2017年 CHW. All rights reserved.
//

#import "FMBadgeButton+ImageView.h"

@implementation FMBadgeButton(ImageView)

- (void)resetBadge
{
    //36 23
    if (self.badgeValue == 0)
    {
        if (self.badgeView)
        {
            self.badgeView.hidden = YES;
        }
    }
    else if (self.badgeValue > 0)
    {
        if (self.badgeValue > 99)
        {
            self.badgeView.frame = CGRectMake(self.badgeOrigin.x, self.badgeOrigin.y, 36, 23);
            self.backImageView.frame = CGRectMake(-3,0, 36, 23);
        }
        else
        {
            if (self.badgeValue > 10){
                self.badgeView.frame = CGRectMake(self.badgeOrigin.x, self.badgeOrigin.y, 20, 23);
                self.backImageView.frame = CGRectMake(3 , 0, self.badgeView.width + 5, 23);
                
            }
            else{
                self.badgeView.frame = CGRectMake(self.badgeOrigin.x, self.badgeOrigin.y, 16, 23);
//                [self.backImageView setImage:[UIImage imageNamed:@"pp_tabbar_dot"]];
                self.backImageView.frame = CGRectMake(6 , 2, 21, 23);
            }
        }
        self.badgeView.hidden = NO;
    }
    else if (self.badgeValue < 0)
    {
        self.badgeView.frame = CGRectMake(self.frame.size.width-8, 3, 8, 8);
        self.backImageView.frame = CGRectMake(0,0, 13, 13);
        
        self.badgeView.hidden = NO;
    }
    self.badgeView.center = self.backImageView.center;
    self.badgeView.layer.cornerRadius = self.badgeView.frame.size.height/2;
    [self.badgeView setNeedsDisplay];
    
}


@end
