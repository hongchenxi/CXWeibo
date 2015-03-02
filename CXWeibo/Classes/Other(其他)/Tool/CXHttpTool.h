//
//  CXHttpTool.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/9.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//  封装了整个项目的GET/POST请求

#import <Foundation/Foundation.h>
@interface CXHttpTool : NSObject
/**
 *  发送一个post请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)postWithURL:(NSString *)url parameters:(NSDictionary *)params
           success:(void(^)(id json))success
           failure:(void(^)(NSError *error))failure;

//- (AFHTTPRequestOperation *)POST:(NSString *)URLString
//                      parameters:(id)parameters
//                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
/**
 *  发送一个post请求（上传文件数据）
 *
 *  @param url           请求路径
 *  @param params        请求参数
 *  @param formDataArray 文件参数
 *  @param success       请求成功后的回调
 *  @param failure       请求失败后的回调
 */
+(void)postWithURL:(NSString *)url parameters:(NSDictionary *)params
            formDataArray:(NSArray *)formDataArray success:(void (^)(id))success
           failure:(void (^)(NSError *))failure;

//- (AFHTTPRequestOperation *)POST:(NSString *)URLString
//                      parameters:(id)parameters
//       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
//                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

/**
 *  发送一个get请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+(void)getWithURL:(NSString *)url parameters:(NSDictionary *)params
           success:(void(^)(id json))success
           failure:(void(^)(NSError *error))failure;
@end

//封装文件数据模型
@interface CXFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic,strong) NSData * data;
/**
 *  参数名
 */
@property (nonatomic,copy) NSString *name;
/**
 *  文件名
 */
@property (nonatomic,copy) NSString *filename;
/**
 *  文件类型
 */
@property (nonatomic,copy) NSString *mimeType;


@end

