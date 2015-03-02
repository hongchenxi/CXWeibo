//
//  CXSettingCell.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXSettingItem;
@interface CXSettingCell : UITableViewCell
@property (nonatomic,strong) CXSettingItem * item;
@property (nonatomic,strong) NSIndexPath * indexPath;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
