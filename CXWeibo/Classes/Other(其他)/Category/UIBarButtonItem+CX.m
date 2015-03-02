//
//  UIBarButtonItem+CX.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/29.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "UIBarButtonItem+CX.h"
#import "UIImage+CX.h"

@implementation UIBarButtonItem (CX)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    
     [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};   
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    
}
@end
