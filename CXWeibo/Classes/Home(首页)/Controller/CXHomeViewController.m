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
#import "CXAccountTool.h"
#import "CXAccount.h"
#import "UIImageView+WebCache.h"
#import "CXStatus.h"
#import "CXUser.h"
#import "MJExtension.h"
#import "CXStatusCell.h"
#import "CXStatusFrame.h"
#import "CXAccount.h"
#import "CXAccountTool.h"
#import "MJRefresh.h"
#import "CXHttpTool.h"
#import "CXUserTool.h"
#import "CXStatusTool.h"
@interface CXHomeViewController ()<MJRefreshBaseViewDelegate>
@property (nonatomic, weak) CXTitleButton *titleButton;
@property (nonatomic,strong) NSMutableArray * statusesFrames;
@property (nonatomic, weak) MJRefreshHeaderView *header;
@property (nonatomic, weak) MJRefreshFooterView *footer;
@end

@implementation CXHomeViewController
-(NSMutableArray *)statusesFrames{
    if (_statusesFrames == nil) {
        _statusesFrames = [NSMutableArray array];
    }return _statusesFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0.集成刷新控件
    [self setupRefreshView];
    
    //1.设置导航栏的内容
    [self setupNavBar];
   
    //2.获取用户数据
    [self setupUserData];
   
}
-(void)setupUserData{
    //1.封装请求参数
    CXUserInfoParam *param = [CXUserInfoParam param];
    param.uid = @([CXAccountTool getAccount].uid);
    
    //2.封装请求参数
    [CXUserTool userInfoWithParam:param success:^(CXUserInfoResult *result) {
        //设置标题文字
        [self.titleButton setTitle:result.name forState:UIControlStateNormal];
        //保存昵称
        CXAccount *account = [CXAccountTool getAccount];
        account.name = result.name;
        [CXAccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        CXLog(@"网路错误。。。%@",error);
    }];
}
-(void)setupRefreshView{
    //下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    
    //自动进入刷新状态
    [header beginRefreshing];
    self.header = header;
    
    //2.上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
}
-(void)dealloc{
    //释放内存
    [self.header free];
    [self.footer free];
}
/**
 * 刷新控件进入开始刷新状态的时候调用
 */

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]]) {//上拉刷新
        [self loadMoreData];
    }else{
        //下拉刷新
        [self loadNewData];
    }
}
-(void)refresh{
    if ([self.tabBarItem.badgeValue intValue] != 0) {
        [self.header beginRefreshing];
    }
}

/**
 *  发送请求加载更多的微博数据
 */
-(void)loadMoreData{
    
        //1.封装请求参数
    CXHomeStatusesParam *param = [CXHomeStatusesParam param];
    param.access_token = [CXAccountTool getAccount].access_token;
    if (self.statusesFrames.count) {
        CXStatusFrame *statusFrame = [self.statusesFrames lastObject];
        //加载ID <= max_id的微博
        param.max_id = @([statusFrame.status.idstr longLongValue] - 1);
    }
    
    //2.发送请求
    [CXStatusTool homeStatuesWithParam:param success:^(CXHomeStatusesResult *result) {
        //创建frame模型对象
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        for (CXStatus *status in result.statues) {
            CXStatusFrame *statusFrame = [[CXStatusFrame alloc]init];
            //传递微博模型数据
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        //添加新数据到旧数据的后面
        [self.statusesFrames addObjectsFromArray:statusFrameArray];
        
        //刷新表格
        [self.tableView reloadData];
        
        [self.footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.footer endRefreshing];
    }];
    
    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [CXAccountTool getAccount].access_token;
//    params[@"count"] = @5;
//    
//    if (self.statusesFrames.count) {
//        CXStatusFrame *statusFrame = [self.statusesFrames lastObject];
//        long long maxId = [statusFrame.status.idstr longLongValue] - 1;
//        //加载ID <= max_id的微博
//        params[@"max_id"] = @(maxId);
//    }
//    
//    [CXHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(id json) {
//        
//        // 将字典数组转为模型数组(里面放的就是IWStatus模型)
//        NSArray *statusArray = [CXStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
//        
//        // 创建frame模型对象
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        for (CXStatus *status in statusArray) {
//            CXStatusFrame *statusFrame = [[CXStatusFrame alloc] init];
//            // 传递微博模型数据
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        //添加新数据到旧数据的后面
//        [self.statusesFrames addObjectsFromArray:statusFrameArray];
//        [self.tableView reloadData];
//        [self.footer endRefreshing];
//    } failure:^(NSError *error) {
//        CXLog(@"网路错误。。。%@",error);
//        [self.footer endRefreshing];
//        
//    }];
    
}

/**
 *  // 刷新数据(向新浪获取更新的微博数据)
 */
-(void)loadNewData{
    //1.消除提醒数字
    self.tabBarItem.badgeValue = nil;
    
    //2.封装请求参数
    CXHomeStatusesParam *param = [CXHomeStatusesParam param];
    if (self.statusesFrames.count) {
        CXStatusFrame *statusFrame = self.statusesFrames[0];
        param.since_id = @([statusFrame.status.idstr longLongValue]);
        
    }
    
    //3.发送请求
    [CXStatusTool homeStatuesWithParam:param success:^(CXHomeStatusesResult *result) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        NSLog(@"%@",result.statues);
        for (CXStatus *status in result.statues) {
            CXStatusFrame *statusFrame = [[CXStatusFrame alloc]init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
         //将最新的数据追加到旧数据的最前面(旧数据：self.statusFrames;新数据：statusFrameArray)
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:statusFrameArray];
        [tempArray addObjectsFromArray:self.statusesFrames];

        self.statusesFrames = tempArray;

        [self.tableView reloadData];

        // 显示最新微博的数量
        [self showNewStatusCount:statusFrameArray.count];
        
        [self.header endRefreshing];
    } failure:^(NSError *error) {
        // 让刷新控件停止显示刷新状态
        [self.header endRefreshing];
    }];
    
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [CXAccountTool getAccount].access_token;
//    params[@"count"] = @5;
//    if (self.statusesFrames.count) {
//        CXStatusFrame *statusFrame = self.statusesFrames[0];
//        //加载ID比since_id大的微博
//        params[@"since_id"] = statusFrame.status.idstr;
//    }
//    
//    [CXHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(id json) {
//        // 将字典数组转为模型数组(里面放的就是IWStatus模型)
//        NSArray *statusArray = [CXStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
//        
//        // 创建frame模型对象
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        for (CXStatus *status in statusArray) {
//            CXStatusFrame *statusFrame = [[CXStatusFrame alloc] init];
//            // 传递微博模型数据
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        
//        // 将最新的数据追加到旧数据的最前面(旧数据：self.statusFrames;新数据：statusFrameArray)
//        NSMutableArray *tempArray = [NSMutableArray array];
//        [tempArray addObjectsFromArray:statusFrameArray];
//        [tempArray addObjectsFromArray:self.statusesFrames];
//        
//        self.statusesFrames = tempArray;
//        
//        [self.tableView reloadData];
//        
//        // 显示最新微博的数量
//        [self showNewStatusCount:statusFrameArray.count];
//        
//        [self.header endRefreshing];
//    } failure:^(NSError *error) {
//        CXLog(@"网路错误。。。%@",error);
//        [self.header endRefreshing];
//    }];

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
//-(void)setupStatusData{
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [CXAccountTool getAccount].access_token;
//    [CXHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(id json) {
//        // 将字典数组转为模型数组(里面放的就是IWStatus模型)
//        NSArray *statusArray = [CXStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
//        
//        // 创建frame模型对象
//        NSMutableArray *statusFrameArray = [NSMutableArray array];
//        for (CXStatus *status in statusArray) {
//            CXStatusFrame *statusFrame = [[CXStatusFrame alloc] init];
//            // 传递微博模型数据
//            statusFrame.status = status;
//            [statusFrameArray addObject:statusFrame];
//        }
//        
//        // 赋值
//        self.statusesFrames = statusFrameArray;
//        
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        CXLog(@"网路错误。。。%@",error);
//    }];
//}

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
    if ([CXAccountTool getAccount].name) {
        [titleButton setTitle:[CXAccountTool getAccount].name forState:UIControlStateNormal];
    }else{
        [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    }

    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 0, 40);
    self.titleButton = titleButton;
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    self.tableView.backgroundColor = CXColor(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CXStatusTableBorder, 0);
    
    
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
