//
//  CXTitle.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/30.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXTitleButton.h"
#import "UIImage+CX.h"

@implementation CXTitleButton
#define CXTitleButtonImageW 20

+(instancetype)titleButton{
    return [[self alloc]init];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 背景
        [self setBackgroundImage:[UIImage resizedImageName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = CXTitleButtonImageW;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleW = contentRect.size.width - CXTitleButtonImageW;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    //根据title计算自己的宽度
    CGFloat titleW = [title sizeWithFont:self.titleLabel.font].width;
    CGRect frame = self.frame;
    frame.size.width = titleW + CXTitleButtonImageW + 5;
    self.frame = frame;
    
    [super setTitle:title forState:state];
    
}


@end
