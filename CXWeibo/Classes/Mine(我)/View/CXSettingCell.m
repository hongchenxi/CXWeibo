//
//  CXSettingCell.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSettingCell.h"
#import "CXBadgeButton.h"
#import "UIImage+CX.h"
#import "CXSettingItem.h"
#import "CXSettingSwitchItem.h"
#import "CXSettingArrowItem.h"
@interface CXSettingCell()
@property (nonatomic,strong) UIImageView * arrowView;
@property (nonatomic,strong) UISwitch * switchView;
@property (nonatomic,strong) CXBadgeButton * badgeButton;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIImageView *bgView;
@property (nonatomic, weak) UIImageView *selectedBgView;
@end
@implementation CXSettingCell
-(UIImageView *)arrowView{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _arrowView;
}
-(UISwitch *)switchView{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc]init];
    }
    return _switchView;
}
-(CXBadgeButton *)badgeButton{
    if (_badgeButton == nil) {
        _badgeButton = [[CXBadgeButton alloc]init];
    }
    return _badgeButton;
}


+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"setting";
    CXSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CXSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.tableView = tableView;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //1.标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        
        //2.创建背景
        UIImageView *bgView = [[UIImageView alloc]init];
        self.backgroundView = bgView;
        self.bgView = bgView;
        
        UIImageView *selectedBgView = [[UIImageView alloc]init];
        self.selectedBackgroundView = selectedBgView;
        self.selectedBgView = selectedBgView;
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    if (ios7) {
        frame.origin.x = 5;
        frame.size.width -= 10;
    }
    [super setFrame:frame];
}

-(void)setItem:(CXSettingItem *)item{
    _item = item;
    
    //1.设置数据
    [self setupData];
    
    //2.设置右边的控件
    [self setupRightView];
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    
    //设置背景图片
    int totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
    NSString *bgName = nil;
    NSString *selectedBgName = nil;
    if (totalRows == 1) {//这组就一行
        bgName = @"common_card_background";
        selectedBgName = @"common_card_background_highlighted";
    }else if (indexPath.row == 0){//首行
        bgName = @"common_card_top_background";
        selectedBgName = @"common_card_top_background_highlighted";
    }else if (indexPath.row == totalRows - 1) { // 尾行
        bgName = @"common_card_bottom_background";
        selectedBgName = @"common_card_bottom_background_highlighted";
    } else { // 中行
        bgName = @"common_card_middle_background";
        selectedBgName = @"common_card_middle_background_highlighted";
    }
    self.bgView.image = [UIImage resizedImageName:bgName];
    self.selectedBgView.image = [UIImage resizedImageName:selectedBgName];
}

-(void)setupData{
    //1.图标
    if (self.item.icon) {
        self.imageView.image = [UIImage imageWithName:self.item.icon];
    }
    
    //2.标题
    self.textLabel.text = self.item.title;
}

- (void)setupRightView{
    if (self.item.badgeValue) {
        self.badgeButton.badgeValue = self.item.badgeValue;
        self.accessoryView = self.badgeButton;
    }else if ([self.item isKindOfClass:[CXSettingSwitchItem class]]){
        self.accessoryView = self.switchView;
    }else if([self.item isKindOfClass:[CXSettingArrowItem class]]){
        self.accessoryView = self.arrowView;
    }else{
        self.accessoryView = nil;
    }
}




@end
