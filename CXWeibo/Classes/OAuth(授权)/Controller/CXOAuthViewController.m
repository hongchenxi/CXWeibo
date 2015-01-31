//
//  CXOAuthViewController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/30.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXOAuthViewController.h"
#import "AFNetworking.h"
#import "CXAccount.h"
#import "CXTabBarController.h"
#import "CXNewfeatureViewController.h"
#import "CXAccountTool.h"
#import "CXWeiboTool.h"
#import "MBProgressHUD+MJ.h"
@interface CXOAuthViewController()<UIWebViewDelegate>
@end

@implementation CXOAuthViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=824965798&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"努力加载中..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

//#pragma mark - webView代理方法
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        int loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        [self accessTokenWithCode:code];
    }
    return  YES;
}

-(void)accessTokenWithCode:(NSString *)code{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"824965798";
    params[@"client_secret"]= @"b5dd2c233ffa313d7dfadea27c55b6b1";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"www.baidu.com";
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        CXAccount *account = [CXAccount accountWithDict:responseObject];
        [CXAccountTool saveAccount:account];
        [CXWeiboTool chooseRootController];
        [MBProgressHUD hideHUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CXLog(@"%@",error);
        [MBProgressHUD hideHUD];
    }];
    
}






@end
