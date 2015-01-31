//
//  CXStatus.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/31.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXUser;
@interface CXStatus : NSObject
/**
 *  微博内容
 */
@property (nonatomic,copy) NSString *text;
/**
 *  微博来源
 */
@property (nonatomic,copy) NSString *source;
/**
 *  微博id
 */
@property (nonatomic,copy) NSString *idstr;
/**
 *  转发数
 */
@property (nonatomic,copy) NSString *reposts_count;
/**
 *  评论数
 */
@property (nonatomic,copy) NSString *comments_count;

@property (nonatomic,strong) CXUser * user;

+(instancetype)statusWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
