//
//  CXTabBar.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/28.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXTabBar.h"
#import "CXTabBarButton.h"
#import "UIImage+CX.h"
@interface CXTabBar()
@property (nonatomic, weak) CXTabBarButton *selectedButton;
@property (nonatomic,strong) NSMutableArray * tabBarButtons;
@property (nonatomic, weak) UIButton *centerButton;

@end
@implementation CXTabBar
-(NSMutableArray *)tabBarButtons{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!ios7) {//非ios7，设置tabbar背景
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        }
        
        //添加中间那个加号按钮
        UIButton * centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [centerButton setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [centerButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [centerButton setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        centerButton.bounds = CGRectMake(0, 0, centerButton.currentBackgroundImage.size.width, centerButton.currentBackgroundImage.size.height);
        [centerButton addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centerButton];
        self.centerButton = centerButton;
        
    }
    return self;
}
-(void)centerButtonClick{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickedCenterButton:)]) {
        [self.delegate tabBarDidClickedCenterButton:self];
    }
}
- (void)addTabBarButtonWithItem:(UITabBarItem *)item{
    
    CXTabBarButton *button = [[CXTabBarButton alloc]init];
    [self addSubview:button];
    
    [self.tabBarButtons addObject:button];
    
    
    button.item = item;
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
    
}

- (void)buttonClick:(CXTabBarButton *)button{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    self.centerButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.tabBarButtons.count; index++) {
        
        CXTabBarButton *button = self.tabBarButtons[index];
        
        CGFloat buttonX = index * buttonW;
        if (index > 1) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        button.tag = index;
        
        
    }
    
}

@end
