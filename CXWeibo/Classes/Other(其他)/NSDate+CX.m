//
//  NSDate+CX.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "NSDate+CX.h"

@implementation NSDate (CX)
/**
 *  是否为今天
 *
 */
-(BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    //1.获得当前时间的年月日
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self的年月日
    NSDateComponents *selfComps = [calendar components:unit fromDate:self];
    return
    (selfComps.year == nowComps.year)&&(selfComps.month == nowComps.month)&&(selfComps.day == nowComps.day);
    
}
/**
 *  是否为昨天
 *
 */
-(BOOL)isYesterday{
    return NO;
}
/**
 *  是否为今年
 *
 */
-(BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;

}

/**
 *  获得与当前时间的差距
 */
-(NSDateComponents *)deltaWithNow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int uint = NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    return [calendar components:uint fromDate:self toDate:[NSDate date] options:0];
    
}
@end
