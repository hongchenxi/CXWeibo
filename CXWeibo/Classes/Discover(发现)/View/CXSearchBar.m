//
//  CXSearchBar.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/29.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSearchBar.h"
#import "UIImage+CX.h"

@implementation CXSearchBar
+(instancetype)searchBar{
    return [[self alloc]init];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImage resizedImageName:@"searchbar_textfield_background"];
        
        UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.font = [UIFont systemFontOfSize:13];
        
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索" attributes:attrs];
        
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置左边图标的frame
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
    
}


@end
