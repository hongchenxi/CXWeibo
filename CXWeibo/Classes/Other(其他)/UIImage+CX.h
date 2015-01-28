//
//  UIImage+CX.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/28.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CX)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+(UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 *
 *  @param name 图片名
 */
+(UIImage *)resizedImageName:(NSString *)name;
@end
