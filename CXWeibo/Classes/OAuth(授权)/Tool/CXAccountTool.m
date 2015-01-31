//
//  CXAuthTool.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/30.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXAccountTool.h"
#import "CXAccount.h"
#define CXAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation CXAccountTool

+(void)saveAccount:(CXAccount *)account{
    
    NSDate *now = [NSDate date];
    account.expires_Time = [now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:CXAccountFile];
}

+(CXAccount *)getAccount{
   
    CXAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:CXAccountFile];
    NSDate *now = [NSDate date];
    //判断账号是否过期
    if ([now compare:account.expires_Time] == NSOrderedAscending) {//还没有过期
        return account;
    }else{//过期
        return nil;
    }
}
@end
