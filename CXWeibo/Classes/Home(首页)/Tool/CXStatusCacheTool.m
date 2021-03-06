//
//  CXStatusCacheTool.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXStatusCacheTool.h"
#import "FMDB.h"
#import "CXAccount.h"
#import "CXAccountTool.h"
#import "CXStatus.h"

@implementation CXStatusCacheTool

static FMDatabaseQueue *_queue;
+(void)initialize{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"statues.sqlite"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    NSLog(@"路径：%@",path);
    
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,access_token text,idstr text,dict blob);"];
    }];
}
+(void)addStatues:(NSArray *)dictArray{
    for (CXStatus *status in dictArray) {
        [self addStatus:status];
    }
}
+(void)addStatus:(CXStatus *)status{
    [_queue inDatabase:^(FMDatabase *db) {
        //获取需要缓存的数据
        NSString *accessToken = [CXAccountTool getAccount].access_token;
        NSString *idstr = status.idstr;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        //存储数据
        [db executeUpdate:@"insert into t_status (access_token,idstr,dict) values(?,?,?)",accessToken,idstr,data];
        
    }];
}
+(NSArray *)statuesWithParam:(CXHomeStatusesParam *)param{
    //定义数组
    __block NSMutableArray *statusArray = nil;
    
    [_queue inDatabase:^(FMDatabase *db) {
        statusArray = [NSMutableArray array];
        NSString *accessToken = [CXAccountTool getAccount].access_token;
        
        FMResultSet *rs = nil;
        if (param.since_id) {
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;",accessToken,param.since_id,param.count];
        }else if(param.max_id){
            rs = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr desc limit 0,?;",accessToken,param.max_id,param.count];
        }else{
            rs = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0,?;",accessToken,param.count];
        }
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"dict"];
            NSDictionary * dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [statusArray addObject:dict];
        }
    }];
    return statusArray;
}



@end
