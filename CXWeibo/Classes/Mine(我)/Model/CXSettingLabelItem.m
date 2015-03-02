//
//  CXSettingLabel.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSettingLabelItem.h"

@implementation CXSettingLabelItem
-(NSString *)text{
    id value = [CXUserDefaults objectForKey:self.key];
    if (value == nil) {
        return self.defaultText;
    }else{
        return value;
    }
}
-(void)setText:(NSString *)text{
    [CXUserDefaults setObject:text forKey:self.key];
    [CXUserDefaults synchronize];
}
@end
