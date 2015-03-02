//
//  IWStatusTool.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXStatusTool.h"
#import "CXHttpTool.h"
#import "CXStatusCacheTool.h"
#import "MJExtension.h"

@implementation CXStatusTool
+(void)homeStatuesWithParam:(CXHomeStatusesParam *)param success:(void (^)(CXHomeStatusesResult *))success failure:(void (^)(NSError *))failure{
    //1.先从缓存里面加载
    NSArray *statusArray = [CXStatusCacheTool statuesWithParam:param];
    if (statusArray.count) {//有缓存
        //传递block
        if (success) {
            CXHomeStatusesResult *result = [[CXHomeStatusesResult alloc]init];
            result.statues = statusArray;
            success(result);
        }
    }else{
        [CXHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:param.keyValues success:^(id json) {
            CXHomeStatusesResult *result = [CXHomeStatusesResult objectWithKeyValues:json];
            //缓存起来
            [CXStatusCacheTool addStatues:result.statues];
            
            //传递block
            if (success) {
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}
@end
