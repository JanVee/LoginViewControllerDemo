//
//  JASymbolKeyboard.m
//  YZWGO
//
//  Created by Jan on 15/6/3.
//  Copyright (c) 2015年 YZWGO. All rights reserved.
//

#import "JASymbolKeyboard.h"
#import "UIView+Extension.h"

@interface JASymbolKeyboard ()

@property (nonatomic, copy)  NSString *title;
@property (nonatomic, strong) NSMutableArray *symbolBtnArrM;
/** 其他按钮 删除按钮 */
@property (nonatomic, strong) UIButton *deleteBtn;
/** 其他按钮 切换至数字键盘 */
@property (nonatomic, strong) UIButton *switchNumBtn;
/** 其他按钮 切换至符号按钮 */
@property (nonatomic, strong) UIButton *switchLetterBtn;
/** 其他按钮 登录 */
@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation JASymbolKeyboard

- (NSMutableArray *)symbolBtnArrM {
    if (!_symbolBtnArrM) {
        _symbolBtnArrM = [NSMutableArray array];
    }
    return _symbolBtnArrM;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = @"~`!@#$%^&*()_-+={}[]|\\:;\"'<,>.?/";
        [self setupControls];
    }
    return self;
}

#pragma mark 添加子控件
- (void)setupControls {
    UIImage *image = [UIImage imageNamed:@"c_symbolKeyboardButton"];
    UIImage *highImage = [UIImage imageNamed:@"c_symbolKeyboardButtonSel"];
    
    NSUInteger length = self.title.length;
    // 字母按钮
    for (NSUInteger i = 0; i < length; i++) {
        unichar c = [self.title characterAtIndex:i];
        NSString *text = [NSString stringWithFormat:@"%c", c];
        UIButton *symbolBtn = [JAKeyBoardTool setupBasicButtonsWithTitle:text image:image highImage:highImage];
        [self addSubview:symbolBtn];
        [symbolBtn addTarget:self action:@selector(symbolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.symbolBtnArrM addObject:symbolBtn];
    }
    
    // 其他按钮 123、ABC、回退、login
    self.deleteBtn = [JAKeyBoardTool setupFunctionButtonWithTitle:nil image:[UIImage imageNamed:@"c_symbol_keyboardDeleteButton"] highImage:[UIImage imageNamed:@"c_symbol_keyboardDeleteButtonSel"]];
    self.loginBtn = [JAKeyBoardTool setupFunctionButtonWithTitle:@"完成" image:[UIImage imageNamed:@"login_c_symbol_keyboardLoginButton"] highImage:highImage];
    self.switchNumBtn = [JAKeyBoardTool setupFunctionButtonWithTitle:@"123" image:[UIImage imageNamed:@"c_symbol_keyboardSwitchButton"] highImage:[UIImage imageNamed:@"c_symbol_keyboardSwitchButtonSel"]];
    self.switchLetterBtn = [JAKeyBoardTool setupFunctionButtonWithTitle:@"ABC" image:[UIImage imageNamed:@"c_character_keyboardSwitchButton"] highImage:[UIImage imageNamed:@"c_character_keyboardSwitchButtonSel"]];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchNumBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchLetterBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
    [self addSubview:self.loginBtn];
    [self addSubview:self.switchNumBtn];
    [self addSubview:self.switchLetterBtn];
}

#pragma mark 符号按钮
- (void)symbolBtnClick:(UIButton *)symbolBtn {
    if ([self.delegate respondsToSelector:@selector(symbolKeyboard:didClickButton:)]) {
        [self.delegate symbolKeyboard:self didClickButton:symbolBtn];
    }
}
#pragma mark 删除按钮
- (void)deleteBtnClick:(UIButton *)deleteBtn {
    if ([self.delegate respondsToSelector:@selector(customKeyboardDidClickDeleteButton:)]) {
        [self.delegate customKeyboardDidClickDeleteButton:deleteBtn];
    }
}
#pragma mark 完成按钮
- (void)functionBtnClick:(UIButton *)switchBtn {
    if ([self.delegate respondsToSelector:@selector(symbolKeyboard:didClickButton:)]) {
        [self.delegate symbolKeyboard:self didClickButton:switchBtn];
    }
}

#pragma mark 重新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat topMargin = 5;
    CGFloat bottomMargin = 3;
    CGFloat leftMargin = 3;
    CGFloat colMargin = 3;
    CGFloat rowMargin = 3;
    CGFloat buttonH = (self.height - (topMargin + bottomMargin + 3 * rowMargin)) / 4;
    CGFloat buttonW = (self.width - 9 * colMargin - leftMargin * 2) / 10;
    NSUInteger count = self.symbolBtnArrM.count;
    NSLog(@"%zd", count);
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *symbolBtn = (UIButton *)self.symbolBtnArrM[i];
        NSUInteger row = i / 10;
        NSUInteger col = i % 10;
        symbolBtn.x = leftMargin + (buttonW + colMargin) * col;
        symbolBtn.y = topMargin + (buttonH + rowMargin) * row;
        symbolBtn.width = buttonW;
        symbolBtn.height = buttonH;
    }
    
    CGFloat otherBtnW = 2 * buttonW + colMargin;
    CGFloat otherBtnY = self.height - bottomMargin - buttonH;
    self.loginBtn.frame = CGRectMake(self.width - leftMargin - otherBtnW, otherBtnY, otherBtnW, buttonH);
    self.deleteBtn.frame = CGRectMake(self.width - leftMargin - colMargin - 2 * otherBtnW, otherBtnY, otherBtnW, buttonH);
    self.switchLetterBtn.frame = CGRectMake(self.width - leftMargin - 2 * colMargin - 3 * otherBtnW, otherBtnY, otherBtnW, buttonH);
    self.switchNumBtn.frame = CGRectMake(self.width - leftMargin - 3 * colMargin - 4 * otherBtnW, otherBtnY, otherBtnW, buttonH);
}

@end
