//
//  CXPhotosView.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/5.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXPhotosView : UIView

/**
 *  需要展示的图片(数组里面装的都是IWPhoto模型)
 */
@property (nonatomic,strong) NSArray * photos;
/**
 *  根据图片的个数返回相册的最终尺寸
 */
+(CGSize)photosViewSizeWithPhotosCount:(int)count;
@end
