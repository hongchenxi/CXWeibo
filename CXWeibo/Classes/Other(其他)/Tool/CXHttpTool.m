//
//  CXHttpTool.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/9.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXHttpTool.h"
#import "AFNetworking.h"
@implementation CXHttpTool
//-(void)Test{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager POST:<#(NSString *)#> parameters:<#(id)#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>];
//    [manager POST:<#(NSString *)#> parameters:<#(id)#> constructingBodyWithBlock:<#^(id<AFMultipartFormData> formData)block#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>];
//}

+(void)postWithURL:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
+(void)postWithURL:(NSString *)url parameters:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (CXFormData *datas in formDataArray) {
            [formData appendPartWithFileData:datas.data name:datas.name fileName:datas.filename mimeType:datas.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
+(void)getWithURL:(NSString *)url parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
