//
//  CXSystemSettingViewController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSystemSettingViewController.h"
#import "UIImage+CX.h"
#import "CXSettingGroup.h"
#import "CXSettingArrowItem.h"
#import "CXGeneralViewController.h"
@interface CXSystemSettingViewController ()

@end

@implementation CXSystemSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
    [self setupFooter];
}
-(void)setupFooter{
    UIButton *logoutButton = [[UIButton alloc]init];
    CGFloat logoutX = CXStatusTableBorder + 2;
    CGFloat logoutY = 10;
    CGFloat logoutW = self.tableView.frame.size.width - 2 * logoutX;
    CGFloat logoutH = 44;
    logoutButton.frame = CGRectMake(logoutX, logoutY, logoutW, logoutH);
    
    // 背景和文字
    [logoutButton setBackgroundImage:[UIImage resizedImageName:@"common_button_red"] forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage resizedImageName:@"common_button_red_highlighted"] forState:UIControlStateHighlighted];
    [logoutButton setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // footer
    UIView *footer = [[UIView alloc] init];
    CGFloat footerH = logoutH + 20;
    footer.frame = CGRectMake(0, 0, 0, footerH);
    self.tableView.tableFooterView = footer;
    [footer addSubview:logoutButton];
}
-(void)setupGroup0{
    CXSettingGroup *group = [self addGroup];
    CXSettingArrowItem *account = [CXSettingArrowItem itemWithTitle:@"帐号管理"];
    account.badgeValue = @"1";
    group.items = @[account];
}
-(void)setupGroup1{
    CXSettingGroup *group = [self addGroup];
    
    CXSettingArrowItem *theme = [CXSettingArrowItem itemWithTitle:@"主题、背景" destVcClass:nil];
    group.items = @[theme];


}
-(void)setupGroup2{
    CXSettingGroup *group = [self addGroup];
    
    CXSettingArrowItem *notice = [CXSettingArrowItem itemWithTitle:@"通知和提醒"];
    CXSettingArrowItem *general = [CXSettingArrowItem itemWithTitle:@"通用设置" destVcClass:[CXGeneralViewController class]];
    CXSettingArrowItem *safe = [CXSettingArrowItem itemWithTitle:@"隐私与安全"];
    group.items = @[notice, general, safe];

}
-(void)setupGroup3{
    CXSettingGroup *group = [self addGroup];
    CXSettingArrowItem *cleanCache = [CXSettingArrowItem itemWithTitle:@"清除缓存"];
    CXSettingArrowItem *opinion = [CXSettingArrowItem itemWithTitle:@"意见反馈"];
    CXSettingArrowItem *about = [CXSettingArrowItem itemWithTitle:@"关于微博"];
    group.items = @[cleanCache,opinion, about];
}
@end
