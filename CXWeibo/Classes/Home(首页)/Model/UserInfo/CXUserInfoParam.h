//
//  CXUserInfoParam.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXBaseParam.h"

@interface CXUserInfoParam :CXBaseParam
/**
 *  需要查询的用户id
 */
@property (nonatomic,strong) NSNumber * uid;
/**
 *  需要查询的用户昵称
 */
@property (nonatomic,copy) NSString *screen_name;

@end
