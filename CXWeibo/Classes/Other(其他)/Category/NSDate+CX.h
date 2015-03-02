//
//  NSDate+CX.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CX)
/**
 *  是否为今天
 *
 */
-(BOOL)isToday;
/**
 *  是否为昨天
 *
 */
-(BOOL)isYesterday;
/**
 *  是否为今年
 *
 */
-(BOOL)isThisYear;

/**
 *  获得与当前时间的差距
 */
-(NSDateComponents *)deltaWithNow;

@end
