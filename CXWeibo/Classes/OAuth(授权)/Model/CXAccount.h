//
//  CXAccount.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/30.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXAccount : NSObject<NSCoding>
@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,strong) NSDate * expires_Time;//账号过期时间
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

+(instancetype)accountWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;

@end
