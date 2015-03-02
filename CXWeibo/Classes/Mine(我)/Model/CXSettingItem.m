//
//  CXSettingItem.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSettingItem.h"

@implementation CXSettingItem
+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title{
    CXSettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}
+(instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithIcon:nil title:title];
}
+(instancetype)item{
    return [[self alloc]init];
}

@end
