//
//  CXSettingViewController.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXSettingGroup;

@interface CXSettingViewController : UITableViewController
 @property (nonatomic,strong) NSMutableArray * groups;

-(CXSettingGroup *)addGroup;
@end
