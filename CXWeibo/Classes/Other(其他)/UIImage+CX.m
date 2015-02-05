//
//  UIImage+CX.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/28.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "UIImage+CX.h"

@implementation UIImage (CX)

+(UIImage *)imageWithName:(NSString *)name{
    if (ios7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    return [UIImage imageNamed:name];
}

+(UIImage *)resizedImageName:(NSString *)name{
    
    return [self resizedImageName:name left:0.5 top:0.5];
}
+(UIImage *)resizedImageName:(NSString *)name left:(CGFloat)left top:(CGFloat)top{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}


@end
