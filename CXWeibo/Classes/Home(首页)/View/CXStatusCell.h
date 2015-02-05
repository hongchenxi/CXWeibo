//
//  CXStatusCell.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/1.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXStatusFrame;
@interface CXStatusCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) CXStatusFrame * statusFrame;
@end
