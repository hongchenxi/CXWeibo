//
//  CXSettingViewController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSettingViewController.h"
#import "CXSettingGroup.h"
#import "CXSettingCell.h"
#import "CXSettingItem.h"
#import "CXSettingArrowItem.h"
@interface CXSettingViewController ()

@end

@implementation CXSettingViewController

-(NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

-(CXSettingGroup *)addGroup{
    CXSettingGroup *group = [CXSettingGroup group];
    [self.groups addObject:group];
    return group;
    
}

-(instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:style];
}

-(instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

-(void)viewDidAppear:(BOOL)animated{}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = CXColor(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.sectionHeaderHeight = 5;
    
    if (ios7) {
        self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CXSettingGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CXSettingCell *cell = [CXSettingCell cellWithTableView:tableView];
    CXSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CXSettingGroup *group = self.groups[section];
    return group.header;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    CXSettingGroup *group = self.groups[section];
    return group.footer;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //1.取出模型
    CXSettingGroup *group = self.groups[indexPath.section];
    CXSettingItem *item = group.items[indexPath.row];
    
    //2.操作
    if (item.operation) {
        item.operation();
    }
    
    //3.跳转
    if ([item isKindOfClass:[CXSettingArrowItem class]]) {
        CXSettingArrowItem *arrrowItem = (CXSettingArrowItem *)item;
        if (arrrowItem.destVcClass) {
            UIViewController *destVc = [[arrrowItem.destVcClass alloc]init];
            destVc.title = arrrowItem.title;
            [self.navigationController pushViewController:destVc animated:YES];
        }
        
    }
}



@end
