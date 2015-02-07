//
//  CXTabBar.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/28.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXTabBar;
@protocol CXTabBarDelegate <NSObject>

@optional
- (void)tabBar:(CXTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
- (void)tabBarDidClickedCenterButton:(CXTabBar *)tabBar;

@end


@interface CXTabBar : UIView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<CXTabBarDelegate> delegate;
@end
