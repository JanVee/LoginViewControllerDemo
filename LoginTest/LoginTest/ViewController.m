//
//  ViewController.m
//  LoginTest
//
//  Created by 宇泽 on 15/5/28.
//  Copyright (c) 2015年 宇泽. All rights reserved.
//

#import "ViewController.h"
#define kStutas 0.43
#import "JAKeyboard.h"

@interface ViewController ()<JAKeyboardDelegate>
{
    __weak IBOutlet UIImageView *cloud1;
    __weak IBOutlet UIImageView *cloud2;
    __weak IBOutlet UIImageView *cloud3;
    __weak IBOutlet UIImageView *cloud4;
    __weak IBOutlet UITextField *name;
    __weak IBOutlet UITextField *pwd;
    __weak IBOutlet UIButton *regist;
    __weak IBOutlet UIButton *login;
    UIActivityIndicatorView *activity;
    __weak IBOutlet UILabel *top;
    __weak IBOutlet UIButton *forget;
    __weak IBOutlet UIImageView *logoImage;
    BOOL isClick;
    UIImageView *status;
    int count;
    UILabel *title;
    NSArray *titleName;
}
@property (nonatomic, strong) JAKeyboard *keyboardName;
@property (nonatomic, strong) JAKeyboard *keyboardPwd;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JAKeyboard *keyboardName = [[JAKeyboard alloc] init];
    keyboardName.delegate = self;
    keyboardName.tag = 1001;
    self.keyboardName = keyboardName;
    name.inputView = self.keyboardName;
    
    JAKeyboard *keyboardPwd = [[JAKeyboard alloc] init];
    keyboardPwd.delegate = self;
    keyboardPwd.tag = 1002;
    self.keyboardPwd = keyboardPwd;
    
    name.inputView = self.keyboardName;
    pwd.inputView = self.keyboardPwd;
    pwd.secureTextEntry = YES;
    
    regist.layer.masksToBounds = YES;
    regist.layer.cornerRadius = 8;
    regist.enabled = NO;
    forget.enabled = NO;
    login.layer.masksToBounds = YES;
    login.layer.cornerRadius = 8;
    forget.layer.masksToBounds = YES;
    forget.layer.cornerRadius = 8;
    isClick = YES;
    count = 0;
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    status = [[UIImageView alloc] init];
    status.image = [UIImage imageNamed:@"banner"];
    status.bounds = CGRectMake(0, 0, self.view.frame.size.width-40, 50);
    status.hidden = YES;
    status.center = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*kStutas);
    [self.view addSubview:status];
    title = [[UILabel alloc] initWithFrame:status.bounds];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = [UIColor orangeColor];
    title.text = @"正在登陆,请稍候...";
    [status addSubview:title];
    
    titleName = @[@"正在验证账号",@"正在验证密码",@"验证成功,正在登陆..."];
    
    //初始化一个基本动画实例,KeyPath
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"]; //透明度keyPath
    fadeIn.fromValue = @(0.0); //初始值
    fadeIn.toValue = @(1.0);//终点值
    fadeIn.duration = 1.5f; //时长
    fadeIn.fillMode = kCAFillModeBackwards;
    fadeIn.beginTime = CACurrentMediaTime() + 0.5;
    [cloud1.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.7;
    [cloud2.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.9;
    [cloud3.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 1.1;
    [cloud4.layer addAnimation:fadeIn forKey:nil];
    
    //定义一个动画组1
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = 0.5f;
    group.fillMode = kCAFillModeBackwards;
    
    // 单体动画1
    CABasicAnimation *flyRight = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyRight.fromValue = @(-self.view.frame.size.width/2);
    flyRight.toValue = @(self.view.frame.size.width/2);
    
    // 单体动画2
    CABasicAnimation *fadeFieldIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeFieldIn.fromValue = @(0.25);
    fadeFieldIn.toValue = @(1.0);
    
    // 单体动画3
    CABasicAnimation *flyLeft = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyLeft.fromValue = @(self.view.frame.size.width+forget.frame.size.width);
    flyLeft.toValue = @(forget.frame.size.width+20);
    
    [group setAnimations:@[flyRight,fadeFieldIn]];//组合动画
    [top.layer addAnimation:group forKey:nil];
    [logoImage.layer addAnimation:group forKey:nil];
    
    group.delegate = self;
    [group setValue:@"form" forKey:@"name"];
    [group setValue:name.layer forKey:@"layer"];
    
    group.beginTime = CACurrentMediaTime() + 0.3;
    [name.layer addAnimation:group forKey:nil];
    
    //[group setValue:pwd.layer forKey:@"layer"];
    group.beginTime = CACurrentMediaTime() + 0.4;
    [pwd.layer addAnimation:group forKey:nil];
    
    group.beginTime = CACurrentMediaTime() + 2.0;
    [group setAnimations:@[flyLeft,fadeFieldIn]];
    [forget.layer addAnimation:group forKey:nil];
    
    //定义一个动画组2
    CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
    groupAnimation.duration = 0.5f;
    groupAnimation.fillMode = kCAFillModeBackwards;
    groupAnimation.beginTime = CACurrentMediaTime() + 0.5;
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // 单体动画2.1
    CABasicAnimation *scaleDown = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleDown.fromValue = @(3.5);
    scaleDown.toValue = @(1.0);
    
    // 单体动画2.2
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = @(M_PI_4);
    rotate.toValue = @(0.0);
    
    // 单体动画2.3
    CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fade.fromValue = @(0.0);
    fade.toValue = @(1.0);
    
    // 单体动画2.4
    CABasicAnimation *rotate1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate1.fromValue = @(-M_PI_4);
    rotate1.toValue = @(0.0);
    
    [groupAnimation setAnimations:@[scaleDown, rotate, fade]];//组合动画1
    [login.layer addAnimation:groupAnimation forKey:nil];
    
    [groupAnimation setAnimations:@[scaleDown, rotate1, fade]];//组合动画2
    [regist.layer addAnimation:groupAnimation forKey:nil];
    
    [self animateCloud:cloud1.layer];
    [self animateCloud:cloud2.layer];
    [self animateCloud:cloud3.layer];
    [self animateCloud:cloud4.layer];
}

#pragma mark 代理方法
- (void)keyboard:(JAKeyboard *)keyboard didClickDeleteButton:(UIButton *)deleteBtn string:(NSMutableString *)string
{
    if (keyboard.tag == 1001) {
        name.text = string;
    }else if (keyboard.tag == 1002){
        pwd.text = string;
    }
}

- (void)keyboard:(JAKeyboard *)keyboard didClickTextButton:(UIButton *)textBtn string:(NSMutableString *)string
{
    if (keyboard.tag == 1001) {
        name.text = string;
    }else if (keyboard.tag == 1002){
        pwd.text = string;
    }
}

#pragma mark 收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [name resignFirstResponder];
    [pwd resignFirstResponder];
}

#pragma mark 云朵的图层动画
- (void)animateCloud:(CALayer *)layer
{
    float speed = 15.0f;
    float timer = (self.view.frame.size.width-layer.frame.origin.x)/speed;
    
    // 单体动画
    CABasicAnimation *cloudMove = [CABasicAnimation animationWithKeyPath:@"position.x"];
    cloudMove.beginTime = CACurrentMediaTime() + 2.5f;
    cloudMove.toValue = @(self.view.bounds.size.width + layer.bounds.size.width/2);
    cloudMove.duration = timer;
    cloudMove.delegate = self;
    [cloudMove setValue:layer forKey:@"layer"];
    [cloudMove setValue:@"cloud" forKey:@"name"];
    [layer addAnimation:cloudMove forKey:nil];
}

#pragma mark 动画代理方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString *value = [anim valueForKey:@"name"];
    if ([value isEqualToString:@"cloud"]) {
        CALayer *layer = [anim valueForKey:@"layer"];
        [anim setValue:nil forKey:@"layer"];
        layer.position = CGPointMake(-layer.frame.size.width/2, layer.frame.origin.y+20);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self animateCloud:layer];
        });
    }
}

#pragma mark 登陆点击事件
- (IBAction)loginClick:(id)sender {
    if (isClick == NO) {
        return;
    }
    regist.hidden = YES;
    [UIView animateWithDuration:1.5 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGRect cf = login.frame;
        cf.size.width += 80.0;
        cf.size.height += 20;
        login.frame = cf;
        login.layer.cornerRadius = 20;
    } completion:nil];
    
    [UIView animateWithDuration:0.33 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGPoint p = login.center;
        p.y += 40.0;
        p.x = self.view.frame.size.width*0.5;
        login.center = p;
        activity.bounds = CGRectMake(0, 0, 40, 40);
        activity.center = CGPointMake(30.0, login.frame.size.height*0.5);
        [login addSubview:activity];
        [activity startAnimating];
    } completion:^(BOOL finished) {
        [self showMessage:0];
    }];
    isClick = NO;
    
    UIImageView *ballon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"balloon"]];
    ballon.frame = CGRectMake(-50.0, 0.0, 50.0, 65.0);
    [self.view insertSubview:ballon belowSubview:name];
    CAKeyframeAnimation *flight = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flight.duration = 12.0;
    flight.values = @[[NSValue valueWithCGPoint:CGPointMake(-50.0, 0.0)],[NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width+50.0, 160.0)],[NSValue valueWithCGPoint:CGPointMake(-50.0, login.center.y)]];
    flight.keyTimes = @[@(0),@(0.5),@(1)];
    [ballon.layer addAnimation:flight forKey:nil];
}

- (void)showMessage:(int)index
{
    count++;
    title.text = titleName[index];
    [UIView transitionWithView:status duration:0.33 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        status.hidden = NO;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if (count < 3) {
                [self removeMessage:count];
            }else{
                [self resetForm];
            }
        });
    }];
}

- (void)removeMessage:(int)index
{
    [UIView animateWithDuration:0.33 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        CGPoint p = status.center;
        p.x += self.view.frame.size.width;
        status.center = p;
    } completion:^(BOOL finished) {
        status.hidden = YES;
        CGPoint p = status.center;
        p = CGPointMake(self.view.frame.size.width*0.5, self.view.frame.size.height*kStutas);
        status.center = p;
        [self showMessage:index];
    }];
}

- (void)resetForm
{
    CAKeyframeAnimation *wobble = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    wobble.duration = 0.25;
    wobble.repeatCount = 4;
    wobble.values = @[@(0.0), @(-M_PI_4/4), @(0.0), @(M_PI_4/4), @(0.0)];
    wobble.keyTimes = @[@(0.0),@(0.25),@(0.5),@(0.75),@(1.0)];
    [top.layer addAnimation:wobble forKey:nil];
    [logoImage.layer addAnimation:wobble forKey:nil];
    
    [UIView transitionWithView:status duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        status.hidden = YES;
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [activity removeFromSuperview];
        regist.hidden = NO;
        CGRect cf = login.frame;
        cf.size.width -= 80.0;
        cf.size.height -= 20.0;
        cf.origin.y -= 40.0;
        cf.origin.x = self.view.frame.size.width*0.6;
        login.frame = cf;
        login.layer.cornerRadius = 8;
    } completion:^(BOOL finished) {
        isClick = YES;
        count = 0;
    }];
}

#pragma mark 注册
- (IBAction)registClick:(id)sender {
    
}


@end
