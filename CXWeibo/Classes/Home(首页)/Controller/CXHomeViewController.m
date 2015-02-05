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
#import "CXStatusCell.h"
#import "CXStatusFrame.h"
@interface CXHomeViewController ()
@property (nonatomic,strong) NSArray * statusesFrames;
@end

@implementation CXHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置导航栏的内容
    [self setupNavBar];
    //2.集成下拉刷新
    [self setupRefreshView];
    
    //获取微博数据
    [self setupStatusData];
   
}
-(void)setupRefreshView{
    UIRefreshControl *refreshController = [[UIRefreshControl alloc]init];
    [refreshController addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshController];
    //自动进入刷新状态（不会触发监听方法）
    [refreshController beginRefreshing];
    
    //直接加载数据
    [self refreshControlStateChange:refreshController];
}

-(void)refreshControlStateChange:(UIRefreshControl *)refreshControl{
    
    //刷新:获取更多数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [CXAccountTool getAccount].access_token;
    params[@"count"] = @5;
    if (self.statusesFrames.count) {
        CXStatusFrame *statusFrame = self.statusesFrames[0];
        //加载ID比since_id大的微博
        params[@"since_id"] = statusFrame.status.idstr;
    }
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 将字典数组转为模型数组(里面放的就是IWStatus模型)
        NSArray *statusArray = [CXStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (CXStatus *status in statusArray) {
            CXStatusFrame *statusFrame = [[CXStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 将最新的数据追加到旧数据的最前面(旧数据：self.statusFrames;新数据：statusFrameArray)
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusesFrames];

        self.statusesFrames = tempArray;
        
        [self.tableView reloadData];
        
        // 显示最新微博的数量
        [self showNewStatusCount:statusFrameArray.count];
        
        [refreshControl endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CXLog(@"网路错误。。。%@",error);
        [refreshControl endRefreshing];
    }];
}
-(void)showNewStatusCount:(int)count{
    
    UIButton *btn = [[UIButton alloc]init];
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    btn.userInteractionEnabled = NO;
    [btn setBackgroundImage:[UIImage resizedImageName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (count) {
        NSString *title = [NSString stringWithFormat:@"%d条新微博",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有新的微博数据" forState:UIControlStateNormal];
    }
    
    CGFloat btnH = 30;
    CGFloat btnW = self.view.frame.size.width;
    CGFloat btnX = 0;
    CGFloat btnY = 64 - btnH;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    //通过动画移动按钮(按钮向下移动 btnH + 2)
    [UIView animateWithDuration:0.7 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, btnH+2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
        }];
    }];
    
    
}
-(void)setupStatusData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [CXAccountTool getAccount].access_token;
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 将字典数组转为模型数组(里面放的就是IWStatus模型)
        NSArray *statusArray = [CXStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (CXStatus *status in statusArray) {
            CXStatusFrame *statusFrame = [[CXStatusFrame alloc] init];
            // 传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        // 赋值
        self.statusesFrames = statusFrameArray;
        
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
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

    return self.statusesFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.创建cell
    CXStatusCell *cell = [CXStatusCell cellWithTableView:tableView];
    //2.传递frame模型
    cell.statusFrame = self.statusesFrames[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CXStatusFrame *statusFrame = self.statusesFrames[indexPath.row];
    
    return statusFrame.cellHeight;
}



@end
