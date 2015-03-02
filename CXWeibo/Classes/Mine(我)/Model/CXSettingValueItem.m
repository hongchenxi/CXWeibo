//
//  CXSettingValueItem.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSettingValueItem.h"

@implementation CXSettingValueItem
-(NSString *)key{
    return _key ? _key : self.title;
}
@end
