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
#import "CXNavigationController.h"
#import "CXComposeViewController.h"
#import "CHTumblrMenuView.h"
#import "CXUserUnreadCountParam.h"
#import "CXUserUnreadCountResult.h"
#import "CXAccount.h"
#import "CXAccountTool.h"
#import "CXUserTool.h"

@interface CXTabBarController ()<CXTabBarDelegate>
@property (nonatomic, weak) CXTabBar *customTabBar;

@property (nonatomic, strong) CXHomeViewController *home;
@property (nonatomic, strong) CXMessageViewController *message;
@property (nonatomic, strong) CXDiscoverViewController *discover;
@property (nonatomic, strong) CXMineViewController *mine;


@end

@implementation CXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupTabBar];

    //初始化所有子控制器
    [self setupAllChildViewControllers];
    
    //定时检查未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
}
-(void)checkUnreadCount{
    //1.请求参数
    CXUserUnreadCountParam *param = [CXUserUnreadCountParam param];
    param.uid = @([CXAccountTool getAccount].uid);
    //2.发送请求
    [CXUserTool userUnreadCountWithParam:param success:^(CXUserUnreadCountResult *result) {
        //设置badgeValue
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        self.mine.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        //设置桌面图标上面的的数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
    } failure:^(NSError *error) {
        
    }];
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
#pragma mark - tabBar 代理方法
-(void)tabBar:(CXTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to{
//    NSLog(@"%d %d",from,to);
    self.selectedIndex = to;
}

-(void)tabBarDidClickedCenterButton:(CXTabBar *)tabBar{
    CXComposeViewController *compse = [[CXComposeViewController alloc]init];
    CXNavigationController *nav = [[CXNavigationController alloc]initWithRootViewController:compse];
    [self presentViewController:nav animated:YES completion:nil];
//    CHTumblrMenuView *menu = [[CHTumblrMenuView alloc]init];
//    [menu addMenuItemWithTitle:@"文字" andIcon:[UIImage imageNamed:@"tabbar_compose_idea"] andSelectedBlock:^{
//        NSLog(@"文字");
//    }];
//    [menu addMenuItemWithTitle:@"相册" andIcon:[UIImage imageNamed:@"tabbar_compose_photo"] andSelectedBlock:^{
//        NSLog(@"相册");
//    }];
//    [menu addMenuItemWithTitle:@"拍摄" andIcon:[UIImage imageNamed:@"tabbar_compose_camera"] andSelectedBlock:^{
//        NSLog(@"拍摄");
//    }];
//    [menu addMenuItemWithTitle:@"签到" andIcon:[UIImage imageNamed:@"tabbar_compose_lbs"] andSelectedBlock:^{
//        NSLog(@"签到");
//    }];
//    [menu addMenuItemWithTitle:@"点评" andIcon:[UIImage imageNamed:@"tabbar_compose_review"] andSelectedBlock:^{
//        NSLog(@"点评");
//    }];
//    [menu addMenuItemWithTitle:@"更多" andIcon:[UIImage imageNamed:@"tabbar_compose_more"] andSelectedBlock:^{
//        NSLog(@"更多");
//    }];
//    [menu show];
}
- (void)setupAllChildViewControllers{
    //1.首页
    CXHomeViewController *home = [[CXHomeViewController alloc]init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedName:@"tabbar_home_selected"];
    self.home = home;
    
    //2.消息
    CXMessageViewController *message = [[CXMessageViewController alloc]init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedName:@"tabbar_message_center_selected"];
    self.message = message;
    
    //3.发现
    CXDiscoverViewController *diccover = [[CXDiscoverViewController alloc]init];
    [self setupChildViewController:diccover title:@"广场" imageName:@"tabbar_discover" selectedName:@"tabbar_discover_selected"];
    self.discover = diccover;
    
    //4.我
    CXMineViewController *mine = [[CXMineViewController alloc]init];
    [self setupChildViewController:mine title:@"我" imageName:@"tabbar_profile" selectedName:@"tabbar_profile_selected"];
    self.mine = mine;
    
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
 
    CXNavigationController *nav = [[CXNavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
    
}


@end
