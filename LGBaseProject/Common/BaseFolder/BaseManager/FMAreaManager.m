//
//  FMAreaManager.m
//  MeiMei
//
//  Created by chw on 15/11/27.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "FMAreaManager.h"
//#import "POAPinyin.h"
#import "FMDataBaseManager.h"

NSString *const FMAreaPickerSecrectString = @"保密";

@interface FMAreaManager()

@end

@implementation FMAreaManager

+ (instancetype)shareInstance
{
    static FMAreaManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FMAreaManager alloc] init];
    });
    return instance;
}
/**
 *  下载所有的地区数据
 */
- (void)downloadAreaTable
{
    
//    FMUserDefault.isNeedRecreateAddressDB = YES;
    [FMDataBaseManager constructDataBase];

//    NSMutableArray *searchResultArray = [FMAreaModel searchWithWhere:nil];
//    if (searchResultArray.count > 0)
//        return;
    
//    [super GetAsync:NO URLString:FM_URL_GLOBAL_DOWNLOAD_AREA_TABLE parameters:nil block:^(FMBaseManagerReturnInfoStatus status, id blockInfo) {
//        if (status == FMBaseManagerReturnInfoSuccess)
//        {
//            [FMAreaModel deleteWithWhere:@"areaID > 0"];
//            NSArray *array = (NSArray *)blockInfo;
//            FMAreaModel *area = [[FMAreaModel alloc] init];
//            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSDictionary *dic = (NSDictionary*)obj;
//                area.areaID = [[dic objectForKey:@"id"] integerValue];
//                area.areaName = [dic objectForKey:@"name"];
//                area.pID = [[dic objectForKey:@"f_id"] integerValue];
//                NSString *spelling = [FMToolsFunction getSpellForChinese:area.areaName];
//                area.spelling = spelling;
//                area.firstSpell = [spelling substringToIndex:1];
//                area.rank = [[dic objectForKey:@"rank"] integerValue];
////                area.hot =[[dic objectForKey:@"hot"] integerValue];
//                
//                if (area.areaName) {
//                    NSMutableString *ms = [[NSMutableString alloc] initWithString:area.areaName];
//                    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
////                        NSLog(@"pinyin: %@", ms);//带音标
//                    }
//                    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
//                    }
//                    area.pinyinStrig = [ms stringByReplacingOccurrencesOfString:@" " withString:@""];//去除字之间的空格
//                }
//                 area.project_type1 =[dic objectForKey:@"project_type1"];
//                 area.project_type2 =[dic objectForKey:@"project_type2"] ;
//                [area saveToDB];
//            }];
//        }
//    }];
}

/**
 *  获取所有的国家
 *
 *  @return FMAreaModel国家数组
 */
- (NSMutableArray*)getCountries
{
    NSMutableArray *searchResultArray = [FMAreaModel searchWithWhere:@"pID=0" orderBy:nil offset:0 count:0];
    return searchResultArray;
}

/**
 *  根据国家获取所有的省份
 *
 *  @param country 国家FMAreaModel，空的默认为中国
 *
 *  @return FMAreaModel省份数组
 */
- (NSMutableArray*)getProvincesByCountry:(FMAreaModel*)country
{
    NSString *where = nil;
    if (country)
        where = [NSString stringWithFormat:@"pID=%ld", (long)country.areaID];
    else
        where = [NSString stringWithFormat:@"pID=0"];   //中国的id为0
    NSMutableArray *array = [FMAreaModel searchWithWhere:where orderBy:nil offset:0 count:0];;
    return array;
}
- (NSMutableArray*)getProvincesByCountry:(FMAreaModel*)country condition:(NSString *)condition
{
    NSString *where = nil;
    if (country)
        where = [NSString stringWithFormat:@"pID=%ld", (long)country.areaID];
    else
        where = [NSString stringWithFormat:@"pID=0"];   //中国的id为0
     if(condition && ![condition isEqualToString:@""])
     {
            where=[NSString stringWithFormat:@"%@ and %@",where,condition];
     }

    NSMutableArray *array = [FMAreaModel searchWithWhere:where orderBy:nil offset:0 count:0];
    return array;

}



/**
 *  根据省份获取其下所有的城市
 *
 *  @param province 省份FMAreaModel
 *
 *  @return FMAreaModel城市数组
 */
- (NSMutableArray*)getCityByProvinces:(FMAreaModel*)province
{
    NSString *where = [NSString stringWithFormat:@"pID=%ld", (long)province.areaID];
    return [FMAreaModel searchWithWhere:where orderBy:nil offset:0 count:0];
}
- (NSMutableArray*)getCityByProvinces:(FMAreaModel*)province condition:(NSString *)condition
{
    NSString *where = [NSString stringWithFormat:@"pID=%ld", (long)province.areaID];
    if(condition && ![condition isEqualToString:@""])
    {
        where=[NSString stringWithFormat:@"%@ and %@",where,condition];
    }
  
    NSMutableArray *array= [FMAreaModel searchWithWhere:where orderBy:nil offset:0 count:0];
    return array;
}

/**
 *  根据城市获取旗下所有的区域
 *
 *  @param city 城市FMAreaModel
 *
 *  @return FMAreaModel区域数组
 */
- (NSMutableArray*)getCityAreaByCity:(FMAreaModel*)city
{
    NSString *where = [NSString stringWithFormat:@"pID=%ld", (long)city.areaID];
    return [FMAreaModel searchWithWhere:where orderBy:nil offset:0 count:0];
}

- (NSMutableArray*)getCityAreaByCity:(FMAreaModel*)city condition:(NSString *)condition
{
    NSString *where = [NSString stringWithFormat:@"pID=%ld", (long)city.areaID];
    if(condition && ![condition isEqualToString:@""])
    {
        where=[NSString stringWithFormat:@"%@ and %@",where,condition];
    }
    
    NSMutableArray *array= [FMAreaModel searchWithWhere:where orderBy:nil offset:0 count:0];
    return array;
}

/**
 *  根据地区id获取地区名字
 *
 *  @param code 地区id
 *
 *  @return 地区字符串
 */
- (NSString*)getNameByCode:(NSNumber*)code
{
    if ([code integerValue] == -1)
    {
        return FMAreaPickerSecrectString;
    }
    NSMutableArray *array = [FMAreaModel searchColumn:@"areaName" where:[NSString stringWithFormat:@"areaID=%@", code] orderBy:nil offset:0 count:0];
    if (array.count > 0) {
        NSString *string = [NSString stringWithFormat:@"%@", [array firstObject]];
        return string;
    }
    return @"";
}

/**
 *  获取首字母索引数组
 *
 *  @return 索引数组
 */
- (NSMutableArray*)getIndexs
{
    NSMutableArray *array = [FMAreaModel searchColumn:@"firstSpell" where:@"pID != 0 group by firstSpell" orderBy:@"firstSpell" offset:0 count:0];
    [array insertObject:@"*" atIndex:0];
    [array insertObject:@"$" atIndex:0];
    [array insertObject:@"#" atIndex:0];
    return array;
}

/**
 *  按照首个字母分组获取所有城市
 *
 *  @return 分组后的城市数组
 */
- (NSMutableArray*)getAllCityGroupByFirstSpell
{
    NSArray *indexs = [FMAreaModel searchColumn:@"firstSpell" where:@"pID != 0 group by firstSpell" orderBy:@"firstSpell" offset:0 count:0];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < indexs.count; i++)
    {
        NSString *where = [NSString stringWithFormat:@"firstSpell='%@' and rank=2", indexs[i]];
        NSMutableArray *temp = [FMAreaModel searchWithWhere:where orderBy:@"spelling" offset:0 count:0];
        if (temp)
            [array addObject:temp];
    }
    return array;
}

/**
 *  根据城市名字获取ID
 *
 *  @param name 城市名字
 *
 *  @return 区域id
 */
- (NSInteger)getCodeByCityName:(NSString*)name
{
    NSString *where = [NSString stringWithFormat:@"areaName='%@'", name];
    if ([name isEqualToString:@"全国"])
        where = [NSString stringWithFormat:@"areaName='%@'", @"中国"];
    NSMutableArray *array = [FMAreaModel searchWithWhere:where];
    if (array.count > 0)
    {
        FMAreaModel *model = [array firstObject];
        return model.areaID;
    }
    else
        return 0;
}

/**
 *  根据城市名字获取省份ID(如果是中国或者省份，直接返回id)，用于筛选界面，有全部字段的
 *
 *  @param name 城市名字
 *
 *  @return 省份
 */
- (FMAreaModel*)getProvinceByCityName:(NSString*)name
{
    NSString *where = [NSString stringWithFormat:@"areaName='%@'", name];
    if ([name isEqualToString:@"全国"])
        where = [NSString stringWithFormat:@"areaName='%@'", @"中国"];
    NSMutableArray *array = [FMAreaModel searchWithWhere:where];
    if (array.count > 0)
    {
        FMAreaModel *model = [array firstObject];
        if (model.areaID == 1 || model.pID == 1)
        {
            return model;
        }
        else
        {
            where = [NSString stringWithFormat:@"areaID=%@", [NSNumber numberWithInteger:model.pID].stringValue];
            NSMutableArray *ret = [FMAreaModel searchWithWhere:where];
            FMAreaModel *re = [ret firstObject];
            return re;
        }
    }
    else
        return nil;
}


- (FMAreaModel*)getAreaByCityName:(NSString*)name
{
    NSString *where = [NSString stringWithFormat:@"areaName='%@'", name];
    if ([name isEqualToString:@"全国"])
        where = [NSString stringWithFormat:@"areaName='%@'", @"中国"];
    NSMutableArray *array = [FMAreaModel searchWithWhere:where];
    if (array.count > 0)
    {
        FMAreaModel *model = [array firstObject];
        return model;
    }
    return nil;
}
- (NSMutableArray*)getAllCityOrderByFirstSpell
{
    NSMutableArray *array =[FMAreaModel searchWithWhere:@"rank >1 order by firstSpell"];
    return array;
}


@end
