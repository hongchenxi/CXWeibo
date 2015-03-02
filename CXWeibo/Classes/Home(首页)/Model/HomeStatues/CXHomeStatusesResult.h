//
//  CXHomeStatusesResult.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/3/2.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXHomeStatusesResult : NSObject
/**
 *  statues数组里面放的都是CXStatus模型
 */
@property (nonatomic,strong) NSArray * statues;
@property (nonatomic, assign) long long previous_cursor;
@property (nonatomic, assign) long long next_cursor;

/**
 *  总数
 */
@property (nonatomic, assign) long long total_number;
@end
