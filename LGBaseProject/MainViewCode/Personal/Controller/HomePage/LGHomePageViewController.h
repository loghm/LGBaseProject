//
//  LGHomePageViewController.h
//  LGBaseProject
//
//  Created by loghm on 2018/10/23.
//  Copyright © 2018 loghm. All rights reserved.
//

//个人主页

#import "LGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGHomePageViewController : LGBaseViewController

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, readonly, assign) BOOL isBacking;

@end

NS_ASSUME_NONNULL_END
