//
//  CXWeiboTool.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/30.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXWeiboTool.h"
#import "CXTabBarController.h"
#import "CXNewfeatureViewController.h"

@implementation CXWeiboTool

+(void)chooseRootController{
    NSString *key = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        //显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[CXTabBarController alloc]init];
    }else{
        //有新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[CXNewfeatureViewController alloc]init];
        //存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }

}
@end
