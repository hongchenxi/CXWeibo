//
//  CXUserUnreadCountResult.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXUserUnreadCountResult.h"

@implementation CXUserUnreadCountResult
-(int)messageCount{
    return self.cmt +self.mention_cmt+ self.mention_status+self.dm;
}
-(int)count{
    return self.messageCount + self.status + self.follower;
}
@end
