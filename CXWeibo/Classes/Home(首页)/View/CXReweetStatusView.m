//
//  CXReweetStatusView.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/4.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXReweetStatusView.h"
#import "UIImage+CX.h"
#import "CXStatusFrame.h"
#import "CXStatus.h"
#import "CXUser.h"
#import "UIImageView+WebCache.h"
#import "CXPhoto.h"
#import "CXPhotosView.h"
@interface CXReweetStatusView()
/**
 *  被转发微博的作者昵称
 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/**
 *  被转发微博的内容
 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/**
 *  被转发微博的配图
 */
@property (nonatomic, weak) CXPhotosView *retweetPhotoView;
@end

@implementation CXReweetStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1.设置图片
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageName:@"timeline_retweet_background" left:0.9 top:0.5];
        
        //2.被转发微博的作者昵称
        
        UILabel *retweetNameLabel = [[UILabel alloc]init];
        retweetNameLabel.font  = CXRetweetStatusNameFont;
        retweetNameLabel.textColor = CXColor(67, 107, 163);
        retweetNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        
        
        //3.被转发微博的内容
       
        UILabel *retweetContentLabel = [[UILabel alloc]init];
        retweetContentLabel.font = CXRetweetStatusContentFont;
        retweetContentLabel.backgroundColor = [UIColor clearColor];
        retweetContentLabel.numberOfLines = 0;
        retweetContentLabel.textColor = CXColor(90, 90, 90);
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        //4.被转发微博的配图
        
        CXPhotosView *retweetPhotoView = [[CXPhotosView alloc]init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
    }
    return self;
}
-(void)setStatusFrame:(CXStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    CXStatus *retweetStatus = statusFrame.status.retweeted_status;
    CXUser *user = retweetStatus.user;
    
    //1.昵称
    self.retweetNameLabel.text = user.name;
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    //2.正文
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    //3.配图
    if (retweetStatus.pic_urls.count) {
        self.retweetPhotoView.hidden = NO;
        self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
        self.retweetPhotoView.photos = retweetStatus.pic_urls;
    }else{
        self.retweetPhotoView.hidden = YES;
    }
}




@end
