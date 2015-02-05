//
//  CXStatusTopView.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/4.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXStatusTopView.h"
#import "UIImage+CX.h"
#import "CXStatus.h"
#import "CXUser.h"
#import "CXStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "CXReweetStatusView.h"
#import "CXPhoto.h"
#import "CXPhotosView.h"

@interface CXStatusTopView()
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  会员头像
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  配图
 */
@property (nonatomic, weak) CXPhotosView *photoView;
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *contentLabel;


/** 被转发微博的View(父控件) */
@property (nonatomic, weak) CXReweetStatusView *retweetView;

@end

@implementation CXStatusTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.设置图片
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageName:@"timeline_card_top_background_highlighted"];
        
        /**
         *  2.头像
         */
        UIImageView *iconView = [[UIImageView alloc]init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /**
         *  3.会员头像
         */
        UIImageView *vipView = [[UIImageView alloc]init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /**
         *  4.配图
         */
        CXPhotosView *photoView = [[CXPhotosView alloc]init];
        [self addSubview:photoView];
        self.photoView = photoView;
        
        /**
         *  5.昵称
         */
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.font = CXStatusNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /**
         *  6.时间
         */
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.font = CXStatusTimeFont;
        timeLabel.textColor = CXColor(240, 140, 19);
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /**
         *  7.来源
         */
        UILabel *sourceLabel = [[UILabel alloc]init];
        sourceLabel.font = CXStatusSourceFont;
        sourceLabel.textColor = CXColor(135, 135, 135);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        /**
         *  8.正文
         */
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = CXColor(39, 39, 39);
        contentLabel.font = CXStatusContentFont;
        contentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /**
         *  9，添加被转发微博的view
         */
        CXReweetStatusView *retweetView = [[CXReweetStatusView alloc]init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}
-(void)setStatusFrame:(CXStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    //1.取出模型数据
    CXStatus *status = statusFrame.status;
    CXUser *user = status.user;
    
    //2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    //3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    //4.vip
    if (user.mbtype) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    //5.时间
    self.timeLabel.text = status.created_at;
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + CXStatusCellBoreder * 0.5 ;
    NSMutableDictionary *timeDict = [NSMutableDictionary dictionary];
    timeDict[NSFontAttributeName] = CXStatusTimeFont;
    CGSize timeLabelSize = [status.created_at sizeWithAttributes:timeDict];
    self.timeLabel.frame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    //6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + CXStatusCellBoreder;
    CGFloat sourceLabelY = timeLabelY;
    NSMutableDictionary *sourceDict = [NSMutableDictionary dictionary];
    sourceDict[NSFontAttributeName] = CXStatusSourceFont;
    CGSize sourceLabelSize = [status.source sizeWithAttributes:sourceDict];
    self.sourceLabel.frame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    //8.配图
    if (status.pic_urls.count) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewF;
        self.photoView.photos = status.pic_urls;

    }else{
        self.photoView.hidden = YES;
    }
    
    //9.被转发微博
    CXStatus *retweetStatus = status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        //传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
    }else{
        self.retweetView.hidden = YES;
    }
    
    
}
@end
