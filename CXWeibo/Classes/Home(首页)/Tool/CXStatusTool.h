//
//  IWStatusTool.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXHomeStatusesParam.h"
#import "CXHomeStatusesResult.h"
@interface CXStatusTool : NSObject
/**
 *  加载首页微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功之后的回调
 *  @param failure 请求失败之后的回调
 */
+(void)homeStatuesWithParam:(CXHomeStatusesParam *)param success:(void(^)(CXHomeStatusesResult *result))success failure:(void(^)(NSError *error))failure;
@end
