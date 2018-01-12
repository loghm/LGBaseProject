//
//  FMAreaModel.h
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMAreaModel : NSObject

@property (nonatomic, assign) NSInteger areaID;     //区域id
@property (nonatomic, strong) NSString *areaName;   //区域名称
@property (nonatomic, assign) NSInteger pID;        //父节点对应的areaID
@property (nonatomic, strong) NSString *spelling;   //每个字的首拼
@property (nonatomic, strong) NSString *firstSpell; //第一个字的首拼
@property (nonatomic,strong)NSString *pinyinStrig;  //所有的拼音
@property (nonatomic, assign) NSInteger rank;       //行政等级 0国，1省，2市，3区
@property (nonatomic, strong) NSString *zip;        //邮编


@property (nonatomic, copy) NSString  *project_type1;//该地区一级分类id 逗号分隔
@property (nonatomic, copy) NSString  *project_type2;//该地区项目二级分类


-(NSArray *)getProject_type1Array;
-(NSArray *)getProject_type2Array;
@end
