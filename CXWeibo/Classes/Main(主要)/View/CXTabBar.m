//
//  CXTabBar.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/28.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXTabBar.h"
#import "CXTabBarButton.h"

@implementation CXTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {//非ios7，设置tabbar背景
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        }
    }
    return self;
}
- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    CXTabBarButton *button = [[CXTabBarButton alloc]init];
    [self addSubview:button];
    
    button.item = item;
    
    
}

@end
