//
//  CXStatusFrame.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/1.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXStatusFrame.h"
#import "CXStatus.h"
#import "CXUser.h"
#import "CXPhotosView.h"
#import "CXPhotosView.h"
/** cell的边框宽度 */

@implementation CXStatusFrame

/**
 *  根据模型数据计算子控件的frame
 *
 *  @param status <#status description#>
 */
-(void)setStatus:(CXStatus *)status{
    _status = status;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2 * CXStatusTableBorder;
    
    //1.topView
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    //2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = CXStatusCellBoreder;
    CGFloat iconViewY = CXStatusCellBoreder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + CXStatusCellBoreder;
    CGFloat nameLabelY = iconViewY;
    NSMutableDictionary *nameDict = [NSMutableDictionary dictionary];
    nameDict[NSFontAttributeName] = CXStatusNameFont;
    CGSize nameLabelSize = [status.user.name sizeWithAttributes:nameDict];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY},nameLabelSize};
    
    //4.会员图标
    if (status.user.mbtype) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + CXStatusCellBoreder;
        CGFloat vipViewY = nameLabelY;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + CXStatusCellBoreder * 0.5;
//    NSMutableDictionary *timeDict = [NSMutableDictionary dictionary];
//    timeDict[NSFontAttributeName] = CXStatusTimeFont;
//    CGSize timeLabelSize = [status.created_at sizeWithAttributes:timeDict];
     CGSize timeLabelSize = [status.created_at sizeWithFont:CXStatusTimeFont];
    _timeLabelF = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    //6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + CXStatusCellBoreder;
    CGFloat sourceLabelY = timeLabelY;
    NSMutableDictionary *sourceDict = [NSMutableDictionary dictionary];
    sourceDict[NSFontAttributeName] = CXStatusSourceFont;
    CGSize sourceLabelSize = [status.source sizeWithAttributes:sourceDict];
    _sourceLabelF = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //7.微博正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelF), CGRectGetMaxY(_iconViewF)) + CXStatusCellBoreder * 0.5;
    CGFloat contentLabelMaxW = topViewW - 2 *CXStatusCellBoreder;
     CGSize contentLabelSize = [status.text sizeWithFont:CXStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    //8.配图
    if (status.pic_urls.count) {
        CGSize photosViewSize = [CXPhotosView photosViewSizeWithPhotosCount:status.pic_urls.count];
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + CXStatusCellBoreder;
        _photoViewF = CGRectMake(photoViewX, photoViewY, photosViewSize.width, photosViewSize.height);
    }
    
    //9.转发的微博
    if (status.retweeted_status) {
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + CXStatusCellBoreder * 0.5;
        CGFloat retweetViewH = 0;
        
        //10.转发的昵称
        CGFloat retweetNameLabelX = CXStatusCellBoreder;
        CGFloat retweetNameLabelY = CXStatusCellBoreder;
        NSString *name = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name sizeWithFont:CXRetweetStatusNameFont];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX,retweetNameLabelY},retweetNameLabelSize};
        
        //11.转发的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + CXStatusCellBoreder * 0.5;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * CXStatusCellBoreder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:CXRetweetStatusContentFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
        
        //12.转发微博的配图
        if (status.retweeted_status.pic_urls.count) {
#warning 根据图片个数计算整个相册的尺寸
            CGSize retweetPhotosViewSize = [CXPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + CXStatusCellBoreder;
            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);
        }else{//没有配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += CXStatusCellBoreder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        //有转发微博时topViewH
        topViewH = CGRectGetMaxY(_retweetViewF);
    }else{//没有转发微博
        if (status.pic_urls.count) {//有图
            topViewH = CGRectGetMaxY(_photoViewF);
        }else{
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
    }
    
    topViewH += CXStatusCellBoreder;
    
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    //13.工具条
    CGFloat statusToolbarX = topViewX;
    CGFloat statusToolbarY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW = topViewW;
    CGFloat statusToolbarH = 35;
    _statusToolBarF = CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);

    //计算cell高度
    _cellHeight = CGRectGetMaxY(_statusToolBarF) + CXStatusTableBorder;
    
    
}
@end
