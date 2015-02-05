//
//  CXStatusCell.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/1.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXStatusCell.h"
#import "CXStatus.h"
#import "CXStatusFrame.h"
#import "CXUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+CX.h"
#import "CXStatusTopView.h"
#import "CXStatusToolbar.h"

@interface CXStatusCell()
/**
 *  顶部的View
 */
@property (nonatomic, weak) CXStatusTopView *topView;

/**
 *  微博的工具条
 */
@property (nonatomic, weak) CXStatusToolbar *statusToolBar;

@end

@implementation CXStatusCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    CXStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CXStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.添加顶部的view
        [self setupTopView];
        
        //2.添加微博的工具条
        [self setupStatusToolBar];

    }
    return  self;
}

-(void)setupTopView{
    
    //1.设置cell选中时候的背景
    self.selectedBackgroundView = [[UIView alloc]init];
    
     //2.顶部的View
    CXStatusTopView *topView = [[CXStatusTopView alloc]init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

-(void)setupStatusToolBar{
    
    CXStatusToolbar *statusToolBar = [[CXStatusToolbar alloc]init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
}

-(void)setFrame:(CGRect)frame{
    frame.origin.y += CXStatusTableBorder;
    frame.origin.x = CXStatusTableBorder;
    frame.size.width -= 2 * CXStatusTableBorder;
    frame.size.height -= CXStatusTableBorder;
    [super setFrame:frame];
}




/**
 *  传递模型数据
 */
-(void)setStatusFrame:(CXStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    //1.设置顶部View的数据
    [self setupTopViewData];
    
    //2.设置微博工具条的数据
    [self setupStatusToolbarData];
    
}
-(void)setupTopViewData{
    
    //1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    //2.传递模型数据
    self.topView.statusFrame = self.statusFrame;
    
   
}
-(void)setupStatusToolbarData{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    
    self.statusToolBar.status = self.statusFrame.status;
    
}


@end
