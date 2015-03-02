//
//  CXStatusCacheTool.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXHomeStatusesParam.h"
@class CXStatus;

@interface CXStatusCacheTool : NSObject
/**
 *  缓存一条微博
 *
 *  @param dict 需要缓存的微博数据
 */
+(void)addStatus:(CXStatus *)status;
/**
 *  缓存多条微博
 *
 *  @param dictArray 需要缓存的微博数据
 */
+(void)addStatues:(NSArray *)statusArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *
 *  @return 字典数组
 */
+(NSArray *)statuesWithParam:(CXHomeStatusesParam *)param;

@end
