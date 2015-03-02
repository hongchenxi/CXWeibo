//
//  CXSettingSwitchItem.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSettingSwitchItem.h"

@implementation CXSettingSwitchItem
-(instancetype)init{
    if (self = [super init]) {
        self.defaultOn = YES;
    }
    return self;
}

-(BOOL)isOn{
    id value = [CXUserDefaults objectForKey:self.key];
    if (value == nil) {
        return self.isDefaultOn;
    }else{
        return [value boolValue];
    }
}

-(void)setOn:(BOOL)on{
    [CXUserDefaults setBool:on forKey:self.key];
    [CXUserDefaults synchronize];
}
@end
