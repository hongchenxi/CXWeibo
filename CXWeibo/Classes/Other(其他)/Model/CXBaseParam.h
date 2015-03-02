//
//  CXBaseParam.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXBaseParam : NSObject
@property (nonatomic,copy) NSString *access_token;
+(instancetype)param;
@end
