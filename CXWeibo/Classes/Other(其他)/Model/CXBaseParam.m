//
//  CXBaseParam.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXBaseParam.h"
#import "CXAccount.h"
#import "CXAccountTool.h"
@implementation CXBaseParam
-(id)init{
    if (self == [super init]) {
        self.access_token = [CXAccountTool getAccount].access_token;
    }
    return self;
}
+(instancetype)param{
    return [[self alloc] init];
}
@end
