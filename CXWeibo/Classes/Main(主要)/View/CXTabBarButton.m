//
//  CXTabBarButton.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/1/28.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#define CXTabBarButtonImageRatio 0.6 //图片比例

#define CXTabBarButtonTitleColor (ios7 ? [UIColor blackColor] : [UIColor whiteColor])
#define CXTabBarButtonSelectedTitleColor (ios7 ? CXColor(234,103,7) : CXColor(248,139,0))
#import "CXTabBarButton.h"
#import "UIImage+CX.h"
#import "CXBadgeButton.h"

@interface CXTabBarButton()
@property (nonatomic, weak) CXBadgeButton *badgebutton;
@end
@implementation CXTabBarButton



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitleColor:CXTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:CXTabBarButtonSelectedTitleColor forState:UIControlStateSelected];
        if(!ios7){
            [self setBackgroundImage:[UIImage imageWithName:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        //添加一个角标
        CXBadgeButton *badgeButton = [[CXBadgeButton alloc]init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgebutton = badgeButton;
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * CXTabBarButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);

}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * CXTabBarButtonImageRatio;;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}


-(void)setItem:(UITabBarItem *)item{

    _item = item;
    
    //kvo监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
}
-(void)dealloc{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];
    
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    self.badgebutton.badgeValue = self.item.badgeValue;
    
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgebutton.frame.size.width - 10;
    CGRect badgeFrame = self.badgebutton.frame;
    
    badgeFrame.origin.x = badgeX;
    badgeFrame.origin.y = badgeY;
    
    self.badgebutton.frame = badgeFrame;
    
    
}




@end
