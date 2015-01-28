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
#import "UIImage+CX.h"
#import "CXTabBar.h"

@interface CXTabBarController ()<CXTabBarDelegate>
@property (nonatomic, weak) CXTabBar *customTabBar;
@end

@implementation CXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTabBar];

    //初始化所有子控制器
    [self setupAllChildViewControllers];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (void)setupTabBar{
    
    CXTabBar *customTabBar = [[CXTabBar alloc]init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    
    self.customTabBar = customTabBar;
}

-(void)tabBar:(CXTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
//    NSLog(@"%d %d",from,to);
    self.selectedIndex = to;
}

- (void)setupAllChildViewControllers{
    //1.首页
    CXHomeViewController *home = [[CXHomeViewController alloc]init];
    home.tabBarItem.badgeValue = @"new";
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedName:@"tabbar_home_selected"];
    
    //2.消息
    CXMessageViewController *message = [[CXMessageViewController alloc]init];
     message.tabBarItem.badgeValue = @"18";
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedName:@"tabbar_message_center_selected"];
    
    //3.发现
    CXDiscoverViewController *diccover = [[CXDiscoverViewController alloc]init];
     diccover.tabBarItem.badgeValue = @"2";
    [self setupChildViewController:diccover title:@"广场" imageName:@"tabbar_discover" selectedName:@"tabbar_discover_selected"];
    
    //4.我
    CXMineViewController *mine = [[CXMineViewController alloc]init];
    mine.tabBarItem.badgeValue = @"999";
    [self setupChildViewController:mine title:@"我" imageName:@"tabbar_profile" selectedName:@"tabbar_profile_selected"];
    
}


- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedName:(NSString *)selectedName{
    
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    UIImage *selectedImage = [UIImage imageWithName:selectedName];
    if (ios7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        childVc.tabBarItem.selectedImage = selectedImage;
    }
 
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
    
}


@end
