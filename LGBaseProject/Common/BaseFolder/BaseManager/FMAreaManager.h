//
//  FMAreaManager.h
//  MeiMei
//
//  Created by chw on 15/11/27.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "FMAreaManager.h"
#import "FMAreaModel.h"

UIKIT_EXTERN NSString *const FMAreaPickerSecrectString; // 保密选项


@interface FMAreaManager : FMBaseManager

+ (instancetype)shareInstance;
/**
 *  下载所有的地区数据
 */
- (void)downloadAreaTable;

/**
 *  获取所有的国家
 *
 *  @return FMAreaModel国家数组
 */
- (NSMutableArray*)getCountries;

/**
 *  根据国家获取所有的省份
 *
 *  @param country 国家FMAreaModel，空的默认为中国
 *
 *  @return FMAreaModel省份数组
 */
- (NSMutableArray*)getProvincesByCountry:(FMAreaModel*)country;
//带筛选条件
- (NSMutableArray*)getProvincesByCountry:(FMAreaModel*)country condition:(NSString *)condition;

/**
 *  根据省份获取其下所有的城市
 *
 *  @param province 省份FMAreaModel
 *
 *  @return FMAreaModel城市数组
 */
- (NSMutableArray*)getCityByProvinces:(FMAreaModel*)province;
- (NSMutableArray*)getCityByProvinces:(FMAreaModel*)province condition:(NSString *)condition;

/**
 *  根据城市获取旗下所有的区域
 *
 *  @param city 城市FMAreaModel
 *
 *  @return FMAreaModel区域数组
 */
- (NSMutableArray*)getCityAreaByCity:(FMAreaModel*)city;
- (NSMutableArray*)getCityAreaByCity:(FMAreaModel*)city condition:(NSString *)condition;

/**
 *  根据代码获取地区字符串 例如:0,1=中国 北京
 *
 *  @param code 代码
 *
 *  @return 地区字符串
 */
- (NSString*)getNameByCode:(NSNumber*)code;

/**
 *  获取首字母索引数组
 *
 *  @return 索引数组
 */
- (NSMutableArray*)getIndexs;

/**
 *  按照首个字母分组获取所有城市
 *
 *  @return 分组后的城市数组
 */
- (NSMutableArray*)getAllCityGroupByFirstSpell;



/**
 *  根据城市名字获取ID
 *
 *  @param name 城市名字
 *
 *  @return 区域id
 */
- (NSInteger)getCodeByCityName:(NSString*)name;

/**
 *  根据城市名字获取省份ID
 *
 *  @param name 城市名字
 *
 *  @return 省份id
 */
- (FMAreaModel*)getProvinceByCityName:(NSString*)name;


/**
 *  <#Description#>
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
- (FMAreaModel*)getAreaByCityName:(NSString*)name;



/**
 *  获取所有的城市 根据首字符排序
 *
 *  @return <#return value description#>
 */
- (NSMutableArray*)getAllCityOrderByFirstSpell;
@end
