//
//  CXTabBarController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/27.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXTabBarController.h"
#import "CXHomeViewController.h"
#import "CXMessageViewController.h"
#import "CXDiscoverViewController.h"
#import "CXMineViewController.h"

@interface CXTabBarController ()

@end

@implementation CXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化所有子控制器
    [self setupAllChildViewControllers];
    
}


- (void)setupAllChildViewControllers{
    //1.首页
    CXHomeViewController *home = [[CXHomeViewController alloc]init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedName:@"tabbar_home_selected"];
    //2.消息
    CXMessageViewController *message = [[CXMessageViewController alloc]init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedName:@"tabbar_message_center_selected"];
    //3.发现
    CXDiscoverViewController *diccover = [[CXDiscoverViewController alloc]init];
    [self setupChildViewController:diccover title:@"广场" imageName:@"tabbar_discover" selectedName:@"tabbar_discover_selected"];
    //4.我
    CXMineViewController *mine = [[CXMineViewController alloc]init];
    [self setupChildViewController:mine title:@"我" imageName:@"tabbar_profile" selectedName:@"tabbar_profile_selected"];
    
}


- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedName:(NSString *)selectedName{
    
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
    
    
}


@end
