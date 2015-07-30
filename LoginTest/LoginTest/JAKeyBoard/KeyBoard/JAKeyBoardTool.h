//
//  JAKeyBoardTool.h
//  YZWGO
//
//  Created by Jan on 15/6/3.
//  Copyright (c) 2015年 YZWGO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class JALetterKeyboard, JANumberKeyboard, JASymbolKeyboard;
@protocol JACustomKeyboardDelegate <NSObject>

@optional

- (void)letterKeyboard:(JALetterKeyboard *)letter didClickButton:(UIButton *)button;
- (void)numberKeyboard:(JANumberKeyboard *)number didClickButton:(UIButton *)button;
- (void)symbolKeyboard:(JASymbolKeyboard *)symbol didClickButton:(UIButton *)button;
- (void)customKeyboardDidClickDeleteButton:(UIButton *)deleteBtn;

@end

@interface JAKeyBoardTool : NSObject

#pragma mark - 添加基础按钮
+ (UIButton *)setupBasicButtonsWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage;

#pragma mark - 添加功能按钮
+ (UIButton *)setupFunctionButtonWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage;

@end
