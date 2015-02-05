//
//  CXPhotosView.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/5.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXPhotosView.h"
#import "CXPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "CXPhoto.h"
#define CXPhotoW 70
#define CXPhotoH 70
#define CXphotoMargin 10

@implementation CXPhotosView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i < 9; i++) {
            CXPhotoView *photoView = [[CXPhotoView alloc]init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

-(void)photoTap:(UITapGestureRecognizer *)recognizer{
    int count = self.photos.count;
    
    //1.分装图片数据
    NSMutableArray *photoArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
        
        //一个MJPhoto对应显示一张图片
        MJPhoto *mjphoto = [[MJPhoto alloc]init];
        mjphoto.srcImageView = self.subviews[i];//源于那个imageView
        CXPhoto *cxphoto = self.photos[i];
        NSString *photoUrl = [cxphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl];;
        
        [photoArray addObject:mjphoto];
        
    }
    //2.显示相册
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc]init];
    brower.currentPhotoIndex = recognizer.view.tag;//显示的第一张图片
    brower.photos = photoArray;//设置所有图片
    [brower show];
    
}
-(void)setPhotos:(NSArray *)photos{
    _photos = photos;
    for (int i = 0; i<self.subviews.count; i++) {
        CXPhotoView *photoView = self.subviews[i];
        if (i < photos.count) {
            photoView.hidden = NO;
            photoView.photo = photos[i];
            int maxColumns = (photos.count == 4) ? 2 : 3;
            int col = i % maxColumns;
            int row = i / maxColumns;
            CGFloat photoX = col * (CXPhotoW + CXphotoMargin);
            CGFloat photoY = row * (CXPhotoH + CXphotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, CXPhotoW, CXPhotoH);
            
            // Aspect : 按照图片的原来宽高比进行缩
            // UIViewContentModeScaleAspectFit : 按照图片的原来宽高比进行缩放(一定要看到整张图片)
            // UIViewContentModeScaleAspectFill :  按照图片的原来宽高比进行缩放(只能图片最中间的内容)
            // UIViewContentModeScaleToFill : 直接拉伸图片至填充整个imageView
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            }else{
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = YES;
            }
            
        }else{
            photoView.hidden = YES;
        }
    }
}

+(CGSize)photosViewSizeWithPhotosCount:(int)count{
    
    //一行最多3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    //总行数
    int rows = (count + maxColumns -1)/maxColumns;
    
    //高度
    CGFloat photosH = rows * CXPhotoH +(rows -1) *CXphotoMargin;
    
    //总列数
    int cols = (count >=maxColumns)? maxColumns : count;
    
    //宽度
    CGFloat photosW = cols * CXPhotoW + (cols - 1) *CXphotoMargin;
    
    return CGSizeMake(photosW, photosH);
    
    
}

@end

