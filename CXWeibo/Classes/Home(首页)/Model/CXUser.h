//
//  CXUser.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/31.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXUser : NSObject
/**
 *  用户id
 */
@property (nonatomic,copy) NSString *idstr;
/**
 *  用户名
 */
@property (nonatomic,copy) NSString *name;
/**
 *  用户头像
 */
@property (nonatomic,copy) NSString *profile_image_url;
/**
 *  会员等级
 */
@property (nonatomic, assign) int mbrank;
/**
 *  会员类型
 */
@property (nonatomic, assign) int mbtype;


//+(instancetype)userWithDict:(NSDictionary *)dict;
//-(instancetype)initWithDict:(NSDictionary *)dict;


@end
