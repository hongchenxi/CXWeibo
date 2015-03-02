//
//  CXSettingCheckGroup.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSettingGroup.h"
@class CXSettingLabelItem,CXSettingCheckItem;

@interface CXSettingCheckGroup : CXSettingGroup
/**
 *  选中的索引
 */
@property (nonatomic, assign) int checkedIndex;

/**
 *  选中的item
 */
@property (nonatomic,strong) CXSettingLabelItem * checkedItem;
/**
 *  来源于哪个item
 */
@property (nonatomic,strong) CXSettingCheckItem * sourceItem;

@end
