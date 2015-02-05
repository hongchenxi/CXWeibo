//
//  CXPhotoView.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/5.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXPhotoView.h"
#import "UIImage+CX.h"
#import "CXPhoto.h"
#import "UIImageView+WebCache.h"
@interface CXPhotoView()
    @property (nonatomic, weak) UIImageView *gifView;
@end
@implementation CXPhotoView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加一个gif小图片
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
        
    }
    return self;
}


-(void)setPhoto:(CXPhoto *)photo{
    _photo = photo;
    
    //控制gif的可见性
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}
@end
