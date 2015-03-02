//
//  CXMineViewController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/27.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXMineViewController.h"
#import "UIBarButtonItem+CX.h"
#import "CXSettingGroup.h"
#import "CXSettingArrowItem.h"
#import "CXSystemSettingViewController.h"
@interface CXMineViewController ()

@end

@implementation CXMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}
-(void)setting{
    CXSystemSettingViewController *sys = [[CXSystemSettingViewController alloc]init];
    [self.navigationController pushViewController:sys animated:YES];
    
}
-(void)setupGroup0{
    CXSettingGroup *group = [self addGroup];
    CXSettingArrowItem *newFriend = [CXSettingArrowItem itemWithIcon:@"new_friend" title:@"新的好友" destVcClass:nil];
    newFriend.badgeValue = @"10";
    group.items = @[newFriend];
}
-(void)setupGroup1{
    CXSettingGroup *group = [self addGroup];
    CXSettingArrowItem *album = [CXSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    album.subtitle = @"(109)";
    CXSettingArrowItem *collect = [CXSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collect.subtitle = @"(0)";
    CXSettingArrowItem *like = [CXSettingArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    like.badgeValue = @"1";
    like.subtitle = @"(35)";
    group.items = @[album, collect, like];
}
-(void)setupGroup2{
    CXSettingGroup *group = [self addGroup];
    
    CXSettingArrowItem *pay = [CXSettingArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:nil];
    CXSettingArrowItem *vip = [CXSettingArrowItem itemWithIcon:@"vip" title:@"会员中心" destVcClass:nil];
    group.items = @[pay, vip];
}
-(void)setupGroup3{
    CXSettingGroup *group = [self addGroup];
    
    CXSettingArrowItem *card = [CXSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    CXSettingArrowItem *draft = [CXSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    group.items = @[card, draft];
}

@end
