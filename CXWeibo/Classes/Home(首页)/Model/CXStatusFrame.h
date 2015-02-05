//
//  CXStatusFrame.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/1.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 昵称的字体 */
#define CXStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define CXRetweetStatusNameFont CXStatusNameFont
/** 时间字体 */
#define CXStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源字体 */
#define CXStatusSourceFont CXStatusTimeFont
/** 正文字体 */
#define CXStatusContentFont [UIFont systemFontOfSize:13]
/** 转发微博正文的字体 */
#define CXRetweetStatusContentFont CXStatusContentFont

/**表格的边框宽度*/
#define CXStatusTableBorder 5
/**cell边框宽度*/
#define CXStatusCellBoreder 10
@class CXStatus;
@interface CXStatusFrame : NSObject
@property (nonatomic,strong) CXStatus * status;

/**
 *  顶部的View
 */
@property (nonatomic, assign, readonly) CGRect topViewF;

/**
 *  头像
 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/**
 *  会员头像
 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/**
 *  配图
 */
@property (nonatomic, assign, readonly) CGRect photoViewF;
/**
 *  昵称
 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/**
 *  时间
 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/**
 *  来源
 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/**
 *  正文
 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;


/** 被转发微博的View(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/**
 *  被转发微博的作者昵称
 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/**
 *  被转发微博的内容
 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/**
 *  被转发微博的配图
 */
@property (nonatomic, assign, readonly) CGRect retweetPhotoViewF;


/**
 *  微博的工具条
 */
@property (nonatomic, assign, readonly) CGRect statusToolBarF;
/**
 *  cell的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;



@end
