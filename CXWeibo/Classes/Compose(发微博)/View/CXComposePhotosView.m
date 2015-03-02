//
//  CXComposePhotosView.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/8.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXComposePhotosView.h"

@implementation CXComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)addImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    [self addSubview:imageView];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    int count = self.subviews.count;
    CGFloat imageViewW = 70;
    CGFloat imageViewH = imageViewW;
    int maxColumns = 3;//一行最多显示3张图片
    CGFloat margin = (self.frame.size.width - maxColumns *imageViewW) / (maxColumns + 1);
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        CGFloat imageViewX = margin +(i%maxColumns) *(imageViewW+margin);
        CGFloat imageViewY = (i/maxColumns) *(imageViewW+margin);
        imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    }
    
}

-(NSArray *)totalImages{
    NSMutableArray *images = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [images addObject:imageView.image];
    }
    return images;
}


@end
