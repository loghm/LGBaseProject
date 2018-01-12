//
//  FMRNode.h
// 
//
//  Created by 陈炜来 on 15/11/29.
//  Copyright © 2015年 陈炜来. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef id(^FMRNodeExecutingBlock)(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject);

@interface FMRNode : NSObject

/**
 *  私有接口
 *  外部应用不能通过URL进行调用，只有应用内部可以调用
 */
@property (nonatomic, assign) BOOL isPrivate;

/**
 *  使用正则匹配
 */
@property (nonatomic, assign) BOOL usePattern;

/**
 *  xxx://yyy/ <-- xxx
 */
@property (nonatomic, copy) NSString *scheme;

/**
 *  xxx://yyy/ <-- yyy
 */
@property (nonatomic, copy) NSString *identifier;

/**
 *  路由被触发后，将执行此Block
 */
@property (nonatomic, copy) FMRNodeExecutingBlock executingBlock;


//@property (nonatomic,assign)BOOL isExcute;

- (void)setExecutingBlock:(FMRNodeExecutingBlock)executingBlock;


- (instancetype)initWithIdentifier:(NSString *)identifier
                    executingBlock:(FMRNodeExecutingBlock)executingBlock;

- (instancetype)initWithIdentifier:(NSString *)identifier
                            scheme:(NSString *)scheme
                        usePattern:(BOOL)usePattern
                    executingBlock:(FMRNodeExecutingBlock)executingBlock;


@end
