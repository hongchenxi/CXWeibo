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
#import "CXComposeToolbar.h"
#import "CXComposePhotosView.h"

@interface CXComposeViewController ()<CXComposeToolbarDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) CXTextView *textView;
@property (nonatomic, weak) CXComposeToolbar *toolbar;
@property (nonatomic, weak) CXComposePhotosView *photosView;

@end

@implementation CXComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏样式
    [self setupNavBar];
    
    //添加textView
    [self setupTextView];
    
    //添加toolbar
    [self setupToolbar];
    
    //添加photoView
    [self setupPhotosView];
}
-(void)setupPhotosView{
    CXComposePhotosView *photosView = [[CXComposePhotosView alloc]init];
    CGFloat photosViewW = self.textView.frame.size.width;
    CGFloat photosViewH = self.textView.frame.size.height;
    CGFloat photosViewY = 80;
    photosView.frame = CGRectMake(0, photosViewY, photosViewW, photosViewH);
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

-(void)setupToolbar{
    
    CXComposeToolbar *toolbar = [[CXComposeToolbar alloc]init];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
}
#pragma mark - toolbar代理方法
-(void)composeToolbar:(CXComposeToolbar *)toolbar didClickedButton:(CXComposeToolbarButtonType)buttonType{
    switch (buttonType) {
        case CXComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case CXComposeToolbarButtonTypePicture:
            [self openPicture];
            break;
        default:
            break;
    }
}
-(void)openCamera{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
-(void)openPicture{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark - 图片选择控制器的代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
}

-(void)setupTextView{
    CXTextView *textView = [[CXTextView alloc]init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    textView.alwaysBounceVertical = YES;//垂直方向上支持拖拽
    textView.placeholder = @"分享新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    //监听textView文字改变的通知
    [CXNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    //监听键盘的通知
    [CXNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [CXNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)keyboardWillShow:(NSNotification *)note{
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }];
}
-(void)keyboardWillHide:(NSNotification *)note{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

-(void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length != 0 ;
}

-(void)dealloc{
    [CXNotificationCenter removeObserver:self];
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
    if (self.photosView.totalImages.count) {
        [self sendWithImage];
    }else{
        [self sendWithOutImage];
    }
    
}
-(void)sendWithImage{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [CXAccountTool getAccount].access_token;

    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSArray *images = [self.photosView totalImages];
        for (UIImage *image in images) {
            NSData *datas = UIImageJPEGRepresentation(image, 0.75);
            [formData appendPartWithFileData:datas name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败!"];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)sendWithOutImage{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [CXAccountTool getAccount].access_token;
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败!"];
    }];
        [self dismissViewControllerAnimated:YES completion:nil];
}

@end
