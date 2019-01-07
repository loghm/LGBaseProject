//
//  LGSystemConfigModel.h
//  LGBaseProject
//
//  Created by loghm on 2018/10/23.
//  Copyright © 2018 loghm. All rights reserved.
//

#import "LGBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGSystemConfigModel : LGBaseModel

@property (nonatomic, copy) NSString *trade_rate;
@property (nonatomic, copy) NSString *day_recharge_denc_max;
@property (nonatomic, copy) NSString *one_step_meter;
@property (nonatomic, copy) NSString *extract_rate;
@property (nonatomic, copy) NSString *day_meter_denc_rate;
@property (nonatomic, copy) NSString *day_recharge_denc_rate;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *day_meter_denc_max;

@end

NS_ASSUME_NONNULL_END
