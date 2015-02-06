//
//  CXStatus.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/31.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXStatus.h"
#import "CXUser.h"
#import "NSDate+CX.h"
#import "MJExtension.h"
#import "CXPhoto.h"

@implementation CXStatus

/**
 *  模型转数组
 *
 */
-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[CXPhoto class]};
}

-(NSString *)created_at{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createDate = [fmt dateFromString:_created_at];
    if (createDate.isToday) {
        if (createDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前",createDate.deltaWithNow.hour];
        }else if(createDate.deltaWithNow.minute >= 1){
            return [NSString stringWithFormat:@"%d分钟前",createDate.deltaWithNow.minute];
        }else{
            return @"刚刚";
        }
    }else if (createDate.isYesterday){//昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    }else if (createDate.isThisYear){
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
}
-(NSString *)source{
    NSUInteger loc      = [_source rangeOfString:@">"].location + 1;
    NSUInteger len      = [_source rangeOfString:@"</"].location - loc;
    NSString *newSource = [_source substringWithRange:NSMakeRange(loc,len)];
    return [NSString stringWithFormat:@"来自%@",newSource];
}

@end
