//
//  JAKeyboard.h
//  YZWGO
//
//  Created by Jan on 15/6/3.
//  Copyright (c) 2015年 YZWGO. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JAKeyboard;
@protocol JAKeyboardDelegate <NSObject>
@optional
/**
 *  点击了文字或字符数字按钮
 */
- (void)keyboard:(JAKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string;
/**
 *  点击了删除按钮
 */
- (void)keyboard:(JAKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string;

@end
@interface JAKeyboard : UIView
@property (nonatomic, assign) id<JAKeyboardDelegate> delegate;
@end
