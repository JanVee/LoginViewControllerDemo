//
//  JAKeyboard.m
//  YZWGO
//
//  Created by Jan on 15/6/3.
//  Copyright (c) 2015年 YZWGO. All rights reserved.
//

#import "JAKeyboard.h"
#import "JAKeyBoardTool.h"
#import "JALetterKeyboard.h"
#import "JANumberKeyboard.h"
#import "JASymbolKeyboard.h"
#define JAScreen_Size [UIScreen mainScreen].bounds.size


@interface JAKeyboard ()<JACustomKeyboardDelegate>
@property (nonatomic, strong) JALetterKeyboard *letterKeyboard;
@property (nonatomic, strong) JASymbolKeyboard *symbolKeyboard;
@property (nonatomic, strong) JANumberKeyboard *numberKeyboard;
@property (nonatomic, strong) NSMutableString *string;
@end
@implementation JAKeyboard
#pragma mark 懒加载
- (JALetterKeyboard *)letterKeyboard {
    if (!_letterKeyboard) {
        _letterKeyboard = [[JALetterKeyboard alloc] initWithFrame:self.bounds];
        _letterKeyboard.delegate = self;
    }
    return _letterKeyboard;
}

- (JASymbolKeyboard *)symbolKeyboard {
    if (!_symbolKeyboard) {
        _symbolKeyboard = [[JASymbolKeyboard alloc] initWithFrame:self.bounds];
        _symbolKeyboard.delegate = self;
    }
    return _symbolKeyboard;
}

- (JANumberKeyboard *)numberKeyboard {
    if (!_numberKeyboard) {
        _numberKeyboard = [[JANumberKeyboard alloc] initWithFrame:self.bounds];
        _numberKeyboard.delegate = self;
    }
    return _numberKeyboard;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, JAScreen_Size.height - 216, JAScreen_Size.width, 180);
        self.string = [NSMutableString string];
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = YES;
        [self addSubview:self.letterKeyboard];
    }
    return self;
}
#pragma mark 代理方法
- (void)letterKeyboard:(JALetterKeyboard *)letter didClickButton:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"符"]) {
        [letter removeFromSuperview];
        [self addSubview:self.symbolKeyboard];
    } else if ([button.currentTitle isEqualToString:@"123"]) {
        [self.letterKeyboard removeFromSuperview];
        [self addSubview:self.numberKeyboard];
    } else if ([button.currentTitle isEqualToString:@"完成"]) {
        [self.nextResponder resignFirstResponder];
    } else {
        [self appendString:button];
    }
}
#pragma mark 代理方法
- (void)symbolKeyboard:(JASymbolKeyboard *)symbol didClickButton:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"ABC"]) {
        [symbol removeFromSuperview];
        [self addSubview:self.letterKeyboard];
    } else if ([button.currentTitle isEqualToString:@"123"]) {
        [symbol removeFromSuperview];
        [self addSubview:self.numberKeyboard];
    } else if ([button.currentTitle isEqualToString:@"完成"]) {
        [self.nextResponder resignFirstResponder];
    } else {
        [self appendString:button];
    }
}
#pragma mark 代理方法
- (void)numberKeyboard:(JANumberKeyboard *)number didClickButton:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"符"]) {
        [number removeFromSuperview];
        [self addSubview:self.symbolKeyboard];
    } else if ([button.currentTitle isEqualToString:@"ABC"]) {
        [number removeFromSuperview];
        [self addSubview:self.letterKeyboard];
    } else if ([button.currentTitle isEqualToString:@"完成"]) {
        [self.nextResponder resignFirstResponder];
    } else {
        [self appendString:button];
    }
}

#pragma mark 删除方法
- (void)customKeyboardDidClickDeleteButton:(UIButton *)deleteBtn {
    
    if (self.string.length > 0) {
        [self.string deleteCharactersInRange:NSMakeRange(self.string.length - 1, 1)];
        if ([self.delegate respondsToSelector:@selector(keyboard:didClickDeleteButton:string:)]) {
            [self.delegate keyboard:self didClickDeleteButton:deleteBtn string:self.string];
        }
    }
    
}
#pragma mark 拼接字符串
- (void)appendString:(UIButton *)button {
    
    [self.string appendString:button.currentTitle];
    
    if ([self.delegate respondsToSelector:@selector(keyboard:didClickTextButton:string:)]) {
        [self.delegate keyboard:self didClickTextButton:button string:self.string];
    }
}


@end
