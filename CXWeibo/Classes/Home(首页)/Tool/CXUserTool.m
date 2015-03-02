//
//  CXUserTool.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXUserTool.h"
#import "CXHttpTool.h"
#import "MJExtension.h"
@implementation CXUserTool

+(void)userInfoWithParam:(CXUserInfoParam *)param success:(void (^)(CXUserInfoResult *))success failure:(void (^)(NSError *))failure{
    
    [CXHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id json) {
        if (success) {
            CXUserInfoResult *result = [CXUserInfoResult objectWithKeyValues:json];
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)userUnreadCountWithParam:(CXUserUnreadCountParam *)param success:(void (^)(CXUserUnreadCountResult *))success failure:(void (^)(NSError *))failure{
    [CXHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id json) {
        CXUserUnreadCountResult *result = [CXUserUnreadCountResult objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
