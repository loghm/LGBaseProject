//
//  FMDataBaseManager.m
//  ForMan
//
//  Created by chw on 16/9/08.
//  Copyright © 2016年 RuiBao. All rights reserved.
//
#import "FMDataBaseManager.h"
#import "SandboxFile.h"

@implementation FMDataBaseManager

+ (void)constructDataBase {
    //拷贝地址信息数据库
    NSString *documentsDirectory = [SandboxFile GetDocumentPath];
    NSString *dbPath =[documentsDirectory stringByAppendingPathComponent:@"addressInfo.db"];

    BOOL isExit = [SandboxFile IsFileExists:dbPath];
//    if (FMUserDefault.isNeedRecreateAddressDB && [SandboxFile IsFileExists:dbPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:dbPath error:nil];
//    }
    if (![SandboxFile IsFileExists:dbPath]) {
        NSString *addressInfoPath = [[NSBundle mainBundle] pathForResource:@"addressInfo" ofType:@"db"];
        if (!addressInfoPath) {
            NSLog(@"读取地址信息数据失败");
        }
        else {
            NSError *error = nil;
            [[NSFileManager defaultManager] copyItemAtPath:addressInfoPath toPath:dbPath error:&error];
            if (error) {
                NSLog(@"拷贝地址信息数据库失败，错误信息：%@",error);
            }
            else {
                NSLog(@"拷贝地址信息：%@",dbPath);

                //创建索引
//                NSString * sql = @"CREATE INDEX Index_Id_FMAreaModel ON FMAreaModel(areaID)";
//                [[FMAreaModel getUsingLKDBHelper] executeSQL:sql arguments:nil];

//                FMUserDefault.isNeedRecreateAddressDB = NO;
            }
        }
    }
}

@end
