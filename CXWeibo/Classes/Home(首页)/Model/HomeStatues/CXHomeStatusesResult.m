//
//  CXHomeStatusesResult.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXHomeStatusesResult.h"
#import "MJExtension.h"
#import "CXStatus.h"

@implementation CXHomeStatusesResult
-(NSDictionary *)objectClassInArray{
    return @{@"statues" :[CXStatus class]};
}

@end
