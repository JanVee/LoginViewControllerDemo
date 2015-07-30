//
//  JAKeyBoardTool.m
//  YZWGO
//
//  Created by Jan on 15/6/3.
//  Copyright (c) 2015年 YZWGO. All rights reserved.
//

#import "JAKeyBoardTool.h"

@implementation JAKeyBoardTool
#pragma mark - 添加基础按钮
+ (UIButton *)setupBasicButtonsWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highImage forState:UIControlStateHighlighted];
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    return button;
}

#pragma mark - 添加功能按钮
+ (UIButton *)setupFunctionButtonWithTitle:(NSString *)title image:(UIImage *)image highImage:(UIImage *)highImage {
    
    UIButton *otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    otherBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [otherBtn setTitle:title forState:UIControlStateNormal];
    [otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [otherBtn setBackgroundImage:image forState:UIControlStateNormal];
    [otherBtn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    otherBtn.layer.cornerRadius = 6;
    otherBtn.layer.masksToBounds = YES;
    return otherBtn;
}
@end
