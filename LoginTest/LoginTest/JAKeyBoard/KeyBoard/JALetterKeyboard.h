//
//  JALetterKeyboard.h
//  YZWGO
//
//  Created by Jan on 15/6/3.
//  Copyright (c) 2015年 YZWGO. All rights reserved.
//  字母键盘

#import <UIKit/UIKit.h>
#import "JAKeyBoardTool.h"

@interface JALetterKeyboard : UIView
@property (nonatomic, assign) id<JACustomKeyboardDelegate> delegate;

@end
