//
//  NSData+FMRouterTrans.h
//  MyStoryTest
//
//  Created by 陈炜来 on 15/11/30.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FMRouterTrans)
+ (NSArray*)FM_arrayWithJSONData:(NSData*)data;
+ (NSDictionary*)FM_dictionaryWithJSONData:(NSData*)data;
@end
@interface NSObject(FMRouterDataConvert)
/**
 *  @brief  data 或者  string 转 jsonObject
 */
-(id)FM_jsonObject;

/**
 *  @brief jsonObject to json data
 */
-(NSData*)FM_jsonData;

/**
 *  @brief jsonObject  to json string
 */
-(NSString*)FM_jsonString;

@end