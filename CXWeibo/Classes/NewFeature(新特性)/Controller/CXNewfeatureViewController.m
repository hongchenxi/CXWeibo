//
//  CXNewfeatureViewController.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/29.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXNewfeatureViewController.h"
#import "UIImage+CX.h"
#import "CXTabBarController.h"
#define CXNewfeatureImageCount 3

@interface CXNewfeatureViewController()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end
@implementation CXNewfeatureViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setupScrollView];
    
    [self setupPageControl];
    
}

-(void)setupScrollView{
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    
    for (int index = 0 ; index < CXNewfeatureImageCount; index++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",index + 1];
        imageView.image = [UIImage imageWithName:name];
        
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        
        if (index == CXNewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
        
    }
    
    scrollView.contentSize = CGSizeMake(imageW * CXNewfeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    
    
}
-(void)setupPageControl{
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = CXNewfeatureImageCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    pageControl.currentPageIndicatorTintColor = CXColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = CXColor(189, 189, 189);
    
    
    
}

-(void)setupLastImageView:(UIImageView *)imageView{
    
    imageView.userInteractionEnabled = YES;
    
    UIButton * startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startBtn.center = CGPointMake(centerX, centerY);
    startBtn.bounds = (CGRect){CGPointZero,startBtn.currentBackgroundImage.size};
    
    
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    
    UIButton *checkbox = [[UIButton alloc]init];
    checkbox.selected = YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = imageView.frame.size.height * 0.5;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    [checkbox addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [imageView addSubview:checkbox];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}



-(void)start{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    self.view.window.rootViewController = [[CXTabBarController alloc]init];
}

-(void)share:(UIButton *)checkbox{
    
    checkbox.selected = !checkbox.isSelected;
    

}


@end
