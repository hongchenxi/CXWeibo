//
//  CXSettingSwitchItem.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSettingValueItem.h"

@interface CXSettingSwitchItem : CXSettingValueItem
@property (nonatomic, assign,getter=isOn) BOOL on;
@property (nonatomic, assign,getter=isDefaultOn) BOOL defaultOn;
@end
