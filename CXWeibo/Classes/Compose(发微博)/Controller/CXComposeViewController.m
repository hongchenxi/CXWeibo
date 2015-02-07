//
//  CXComposeViewController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/8.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXComposeViewController.h"
#import "CXTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "CXAccount.h"
#import "CXAccountTool.h"
@interface CXComposeViewController ()
    @property (nonatomic, weak) CXTextView *textView;
@end

@implementation CXComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏样式
    [self setupNavBar];
    
    //添加textView
    [self setupTextView];
}

-(void)setupTextView{
    CXTextView *textView = [[CXTextView alloc]init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    self.textView = textView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length != 0 ;
}
-(void)setupNavBar{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发微博" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.title = @"发微博";
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [CXAccountTool getAccount].access_token;
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showMessage:@"发送成功！"];
        //NSLog(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败!"];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
