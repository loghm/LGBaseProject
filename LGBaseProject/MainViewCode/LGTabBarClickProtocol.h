//
//  LGTabBarClickProtocol.h
//  LGBaseProject
//
//  Created by 黄明族 on 2019/11/19.
//  Copyright © 2019 loghm. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LGTabBarClickProtocol <NSObject>

@optional;

/** 双击 */
- (void)tabBarItemDidDoubleClick;

@end

NS_ASSUME_NONNULL_END
