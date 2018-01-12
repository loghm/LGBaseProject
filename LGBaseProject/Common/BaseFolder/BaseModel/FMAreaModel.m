//
//  FMAreaModel.m
//  MeiMei
//
//  Created by chw on 15/11/26.
//  Copyright © 2015年 MeiMei. All rights reserved.
//

#import "FMAreaModel.h"

@implementation FMAreaModel


+ (LKDBHelper *)getUsingLKDBHelper {
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* documentsDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentsDirectory stringByAppendingPathComponent:@"addressInfo.db"];
        db = [[LKDBHelper alloc] initWithDBPath:dbPath];
    });
    return db;
}

+(NSString *)getPrimaryKey
{
    return @"areaID";
}

+ (NSString*)getTableName
{
    return @"FMAreaModel";
}


-(NSArray *)getProject_type1Array
{
    if (self.project_type1&&![self.project_type1 isEqualToString:@""]) {
        NSArray *array=  [self.project_type1 componentsSeparatedByString:@","];
       return  array;
    }
    return nil;
}
-(NSArray *)getProject_type2Array
{
    if (self.project_type2&&![self.project_type2 isEqualToString:@""]) {
        NSArray *array=  [self.project_type2 componentsSeparatedByString:@","];
        return  array;
    }
    return nil;
}
@end
