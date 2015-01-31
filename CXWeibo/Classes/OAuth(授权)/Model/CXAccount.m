//
//  CXAccount.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/30.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXAccount.h"

@implementation CXAccount
+(instancetype)accountWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}
/**
 *  从文件中解析对象
 *
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
        self.expires_Time = [aDecoder decodeObjectForKey:@"expires_Time"];
    }
    return  self;
}

/**
 *  将对象写入文件
 *
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_Time forKey:@"expires_Time"];
}

@end
