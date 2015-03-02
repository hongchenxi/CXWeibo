//
//  UIBarButtonItem+CX.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/29.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CX)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;

@end
