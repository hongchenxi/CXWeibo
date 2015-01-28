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
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
}


@end
