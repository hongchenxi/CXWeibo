//
//  CXHomeViewController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/27.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXHomeViewController.h"
#import "UIBarButtonItem+CX.h"
#import "CXTitleButton.h"
#import "UIImage+CX.h"
#import "AFNetworking.h"
#import "CXAccountTool.h"
#import "CXAccount.h"
#import "UIImageView+WebCache.h"
#import "CXStatus.h"
#import "CXUser.h"
#import "MJExtension.h"
@interface CXHomeViewController ()
@property (nonatomic,strong) NSArray * statuses;
@end

@implementation CXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    //获取微博数据
    [self setupStatusData];
   
}
-(void)setupStatusData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [CXAccountTool getAccount].access_token;
    params[@"total_number"] = @2;
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSArray *dictArray =  responseObject[@"statuses"];
//        NSMutableArray *statusArray = [NSMutableArray array];
//        for (NSDictionary *dict in dictArray) {
//            CXStatus *status = [CXStatus statusWithDict:dict];
//            [statusArray addObject:status];
//        }
//        self.statuses = statusArray;
        self.statuses = [CXStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CXLog(@"网路错误。。。%@",error);
    }];
}

-(void)setupNavBar{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    //中间按钮
    CXTitleButton *titleButton = [CXTitleButton titleButton];
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    // 文字
    [titleButton setTitle:@"晨希" forState:UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 100, 40);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;

    
    
}


- (void)findFriend{
    NSLog(@"---------");
}
-(void)pop{
    NSLog(@"ppppppppppp");
}
- (void)titleClick:(CXTitleButton *)titleButton
{
    if (titleButton.currentImage == [UIImage imageWithName:@"navigationbar_arrow_up"]) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    }else{
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    CXStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.text;
    
    CXUser *user = status.user;
    cell.detailTextLabel.text = user.name;
    
    NSString *iconUrl = user.profile_image_url;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageWithName:@"tabbar_compose_button"]];
    
    return cell;
}




@end
