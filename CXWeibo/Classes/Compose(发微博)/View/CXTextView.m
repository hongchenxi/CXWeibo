//
//  CXTextView.m
//  CXWeibo
//
//  Created by 洪晨希 on 15/2/8.
//  Copyright (c) 2015年 chenxi. All rights reserved.
//

#import "CXTextView.h"
@interface CXTextView()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end;

@implementation CXTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = YES;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.font = self.font;
        [self insertSubview:placeholderLabel atIndex:0];
        self.placeholderLabel = placeholderLabel;
    }
    return self;
}
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    if (placeholder.length) {
        self.placeholderLabel.hidden = NO;
        
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxW = self.frame.size.width - 2 * placeholderX;
        CGFloat maxH = self.frame.size.height - 2 *placeholderY;
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = self.placeholderLabel.font;
        
        CGRect placeholderRect = [placeholder boundingRectWithSize:(CGSize){maxW, maxH} options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        CGSize placeholderSize = placeholderRect.size;
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
        
        [CXNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }else{
        self.placeholderLabel.hidden = YES;
    }
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;
}
-(void)textDidChange{
    self.placeholderLabel.hidden = self.text.length != 0 ;
}

-(void)dealloc{
    [CXNotificationCenter removeObserver:self];
}


@end
