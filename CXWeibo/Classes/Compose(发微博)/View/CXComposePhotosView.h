//
//  CXComposePhotosView.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/8.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXComposePhotosView : UIView
/**
 *  添加一张新的图片
 */
-(void)addImage:(UIImage *)image;
/**
 *  返回内部所有的图片
 */
-(NSArray *)totalImages;

@end
