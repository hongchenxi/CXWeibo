//
//  CXNavigationController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/28.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXNavigationController.h"
#import "UIImage+CX.h"

@implementation CXNavigationController
+(void)initialize{
    
    [self setupNavBarTheme];
    
    [self setupBarButtonItemTheme];
}

+ (void)setupNavBarTheme{
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    if (!ios7) {
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
   
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    NSShadow * shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeZero;
    textAttr[NSShadowAttributeName] = shadow;
    textAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:textAttr];
    
}

+ (void)setupBarButtonItemTheme{
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    
    if (!ios7) {
        
        [barButtonItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barButtonItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [barButtonItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    
    textAttr[NSForegroundColorAttributeName] = ios7 ? [UIColor orangeColor] : [UIColor grayColor];
    NSShadow * shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeZero;
    textAttr[NSShadowAttributeName] = shadow;
    textAttr[NSFontAttributeName] = [UIFont systemFontOfSize:ios7 ? 14 : 12];
    [barButtonItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    [barButtonItem setTitleTextAttributes:textAttr forState:UIControlStateHighlighted];
}

@end
