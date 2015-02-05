//
//  CXStatusToolbar.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/4.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXStatusToolbar.h"
#import "UIImage+CX.h"
#import "CXStatus.h"
@interface CXStatusToolbar()
/**
 *  转发
 */
@property (nonatomic, weak) UIButton *reweetBtn;
/**
 *  评论
 */
@property (nonatomic, weak) UIButton *commentBtn;
/**
 *  赞
 */
@property (nonatomic, weak) UIButton *attitudeBtn;

@property (nonatomic,strong) NSMutableArray * btns;
@property (nonatomic,strong) NSMutableArray * dividers;

@end

@implementation CXStatusToolbar


-(NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)dividers{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.userInteractionEnabled = YES;
        
        //1.设置图片
        self.image = [UIImage resizedImageName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageName:@"timeline_card_bottom_background_highlighted"];
        
        //2.添加按钮
        self.reweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        
        //3.添加分割线
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;
}
/**
 *  初始化分割线
 */
-(void)setupDivider{
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  初始化按钮
 *
 *  @param title   文字
 *  @param image   图片
 *  @param bgImage 背景图片
 */
-(UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundImage:[UIImage resizedImageName:bgImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return  btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //1.设置按钮的frame
    int dividerCount = self.dividers.count;//分割线的条数
    CGFloat dividerW = 2;//分割线的宽带
    int btnCount = self.btns.count;//按钮的总数
    CGFloat btnW = (self.frame.size.width - dividerW * dividerCount) / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    for (int i = 0; i< btnCount; i++) {
        UIButton *btn = self.btns[i];
        
        //设置frame
        CGFloat btnX = i *(btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    //2.设置分割线的frame
    CGFloat dividerH = btnH;
    CGFloat dividerY = 0;
    for (int j = 0; j < dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        
        //设置frame
        UIButton *btn = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
    
}

-(void)setStatus:(CXStatus *)status{
    _status = status;
    [self setupBtn:self.reweetBtn originalTitle:@"转发" count:status.reposts_count];
    
}


/**
 *  按钮的显示文字
 *
 *  @param btn           按钮
 *  @param originalTitle 文字
 *  @param count         数字
 */
-(void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count{
    if (count) {//不为0
        NSString *title = nil;
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        }else{
            double countDouble = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",countDouble];
            
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}



@end
