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
//+(instancetype)statusWithDict:(NSDictionary *)dict{
//    
//    return [[self alloc]initWithDict:dict];
//}
//-(instancetype)initWithDict:(NSDictionary *)dict{
//    if (self = [super init]) {
//        self.idstr = dict[@"idstr"];
//        self.text = dict[@"text"];
//        self.source = dict[@"source"];
//        self.reposts_count = dict[@"reposts_count"];
//        self.comments_count = dict[@"comments_count"];
//        self.user = [CXUser userWithDict:dict[@"user"]];
//    }
//    return self;
//}

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
    }
    return @"ddd";
    
}
-(NSString *)source{
    NSUInteger loc      = [_source rangeOfString:@">"].location + 1;
    NSUInteger len      = [_source rangeOfString:@"</"].location - loc;
    NSString *newSource = [_source substringWithRange:NSMakeRange(loc,len)];
    return [NSString stringWithFormat:@"来自%@",newSource];
}


//- (void)setSource:(NSString *)source{
//    NSLog(@"%@",source);
//    
//    NSUInteger  loc = [source rangeOfString:@">"].location + 1;
//    NSUInteger  len = [source rangeOfString:@"</"].location - loc;
//    NSLog(@"----%d,%d",loc,len);
//    source = [source substringWithRange:NSMakeRange(loc,len)];
//    _source = [NSString stringWithFormat:@"来自%@",source];
//    NSLog(@"----setSource--%@", _source);
//    
//}

@end
