//
//  CXGeneralViewController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXGeneralViewController.h"
#import "CXSettingGroup.h"
#import "CXSettingArrowItem.h"
#import "CXSettingSwitchItem.h"
#import "CXSettingLabelItem.h"

@interface CXGeneralViewController ()

@end

@implementation CXGeneralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
    
}
- (void)setupGroup0
{
    CXSettingGroup *group = [self addGroup];
    
    CXSettingLabelItem *read = [CXSettingLabelItem itemWithTitle:@"阅读模式" destVcClass:nil];
    read.defaultText = @"有图模式";
    read.readyForDestVc = ^(CXSettingLabelItem *item ,CXReadModeViewController *destVc){
        destVc.sourceItem = item;
    }
    
    CXSettingArrowItem *font = [CXSettingArrowItem itemWithTitle:@"字号大小" destVcClass:nil];
    
    CXSettingSwitchItem *mark = [CXSettingSwitchItem itemWithTitle:@"显示备注"];
    
    group.items = @[read, font, mark];
}

- (void)setupGroup1
{
    CXSettingGroup *group = [self addGroup];
    
    CXSettingArrowItem *picture = [CXSettingArrowItem itemWithTitle:@"图片质量设置" destVcClass:nil];
    group.items = @[picture];
}

- (void)setupGroup2
{
    CXSettingGroup *group = [self addGroup];
    
    CXSettingSwitchItem *voice = [CXSettingSwitchItem itemWithTitle:@"声音"];
    group.items = @[voice];
}

- (void)setupGroup3
{
    CXSettingGroup *group = [self addGroup];
    
    CXSettingArrowItem *language = [CXSettingArrowItem itemWithTitle:@"多语言环境"];
    group.items = @[language];
}


@end
