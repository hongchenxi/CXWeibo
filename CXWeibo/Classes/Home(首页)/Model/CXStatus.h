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
 *  微博的时间
 */
@property (nonatomic,copy) NSString *created_at;
/**
 *  微博id
 */
@property (nonatomic,copy) NSString *idstr;
/**
 *   微博配图（数组中装模型:CXPhoto）
 */
@property (nonatomic,copy) NSArray *pic_urls;
//@property (nonatomic,copy) NSString *thumbnail_pic;
/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  微博作者
 */
@property (nonatomic,strong) CXUser * user;
/**
 *  被转发的微博
 */
@property (nonatomic,strong) CXStatus * retweeted_status;

//+(instancetype)statusWithDict:(NSDictionary *)dict;
//-(instancetype)initWithDict:(NSDictionary *)dict;

@end
