//
//  CXAuthTool.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/30.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXAccount;
@interface CXAccountTool: NSObject

+(void)saveAccount:(CXAccount *)account;

+(CXAccount *)getAccount;

@end
