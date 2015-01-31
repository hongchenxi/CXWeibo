//
//  CXStatus.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/31.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXStatus.h"
#import "CXUser.h"

@implementation CXStatus
+(instancetype)statusWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.idstr = dict[@"idstr"];
        self.text = dict[@"text"];
        self.source = dict[@"source"];
        self.reposts_count = dict[@"reposts_count"];
        self.comments_count = dict[@"comments_count"];
        self.user = [CXUser userWithDict:dict[@"user"]];
    }
    return self;
}


@end
