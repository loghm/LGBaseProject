//
//  FMGlobalConfig.m
//  MeiMei
//
//  Created by chw on 15/12/4.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "FMGlobalConfigModel.h"
//#import "FMAreaManager.h"


@interface FMGlobalConfigModel ()
/**
 *  最近访问的城市
 */
@property(nonatomic,strong)NSMutableSet *recentlyCity;
@end

@implementation FMGlobalConfigModel

- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init])
    {
        if (decoder == nil)
        {
            return self;
        }
        [NSObject fmCodingObject:self withCOder:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)coder
{
    [NSObject fmEncodingObject:self WithCoder:coder];
}

- (BOOL)showThirdLogin {
    return FALSE;
}
//- (NSString*)getNowCity
//{
//    if (self.selectedCity)
//        return self.selectedCity;
//    else if (self.locationCity)
//        return self.locationCity;
//    else
//        return @"全国";
//}
//
///**
// *  获取当前定位的ID
// *
// *  @return 区域id
// */
//- (NSInteger)getNowCityID
//{
//    return [[FMAreaManager shareInstance] getCodeByCityName:[self getNowCity]];
//}
//
//
//-(void)setSelectedCity:(NSString *)selectedCity
//{
//    _selectedCity=selectedCity;
//    if(selectedCity)
//    {
//        [self.recentlyCity addObject:selectedCity];
//        [self saveRecentlyCity];
//    }
//}
//
//-(NSMutableSet *)recentlyCity
//{
//    if (!_recentlyCity) {
//        NSArray *array=[[TMCache sharedCache]objectForKey:@"FM_recentlyCity"];
//        _recentlyCity=[NSMutableSet setWithArray:array];
//        if (!_recentlyCity) {
//            _recentlyCity=[NSMutableSet new];
//        }
//    }
//    return _recentlyCity;
//}
////获取三个最近的城市
//-(NSArray *)getRecentlyCityArray
//{
//    NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
//    NSArray *sortSetArray = [self.recentlyCity sortedArrayUsingDescriptors:sortDesc];
//    NSArray *temp;
//    if (sortSetArray.count>3)
//    {
//      temp  =  [sortSetArray subarrayWithRange:NSMakeRange(sortSetArray.count-3, 3)];
//
//    }
//    else
//    {
//        temp= [sortSetArray subarrayWithRange:NSMakeRange(0, sortSetArray.count)];
//    }
//    return temp;
//}
//-(void)saveRecentlyCity
//{
//    NSArray *temp= [self getRecentlyCityArray];
//    [[TMCache sharedCache] setObject:temp forKey:@"FM_recentlyCity"];
//}
@end

