//
//  CXComposeToolbar.h
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/8.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXComposeToolbar;

typedef enum {
    CXComposeToolbarButtonTypeCamera,
    CXComposeToolbarButtonTypePicture,
    CXComposeToolbarButtonTypeMention,
    CXComposeToolbarButtonTypeTrend,
    CXComposeToolbarButtonTypeEmotion
}CXComposeToolbarButtonType;

@protocol CXComposeToolbarDelegate <NSObject>
@optional
-(void)composeToolbar:(CXComposeToolbar *)toolbar didClickedButton:(CXComposeToolbarButtonType)buttonType;
@end

@interface CXComposeToolbar : UIView
@property (nonatomic, weak) id<CXComposeToolbarDelegate> delegate;
 
@end
