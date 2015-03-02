//
//  CXSettingArrowItem.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXSettingItem.h"
typedef void(^IWSettingArrowItemReadyForDestVc) (id item,id destVc);

@interface CXSettingArrowItem : CXSettingItem

@property (nonatomic, assign) Class destVcClass;
@property (nonatomic,copy) IWSettingArrowItemReadyForDestVc readyForDestVc;

+(instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

+(instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;
@end
