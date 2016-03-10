//
//  CreateSMSTaskViewController.m
//  MassTool
//
//  Created by Coder雲逍遥 on 16/3/6.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#import "CreateSMSTaskViewController.h"
//#import "mouldGroupListTableViewController.h"
#import "MouldSwitchTableViewController.h"
//文件缓存管理
#import "FileCacheManage.h"
//首页动效
#import "WZAnimatingTransition.h"
//pop动画扩展
#import <MMTweenAnimation.h>
#import <POP.h>
//cell动画
#import <AMWaveTransition.h>

@interface CreateSMSTaskViewController (){
    UIButton *useMouldButton;
    UIButton *dontUseMouldButton;
    //用于标记相应按钮的标号
    NSInteger showButtonIndex;
    UIView *subView;
}

@end

@implementation CreateSMSTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    showButtonIndex = -1;
    
    //backGroundImage
    self.backGroundImage.image = [UIImage imageNamed:@"Splash_Image.jpg"];
    
    //creat view
    CGFloat buttonWith = ([[UIScreen mainScreen] bounds].size.width - 150) / 2;
    CGFloat buttonY = [[UIScreen mainScreen] bounds].size.height / 2 - buttonWith / 2;
    
    useMouldButton = [[UIButton alloc]initWithFrame:
                          CGRectMake(50, buttonY, buttonWith, buttonWith)];
    useMouldButton.tag = 0;
    useMouldButton.adjustsImageWhenHighlighted = NO;
    useMouldButton.backgroundColor = [UIColor orangeColor];
    [useMouldButton setBackgroundImage:[UIImage imageNamed:@"social-mould"] forState:UIControlStateNormal];
    useMouldButton.layer.masksToBounds = YES;
    useMouldButton.layer.cornerRadius = buttonWith/2;
    useMouldButton.alpha = 0.f;
    [self.view addSubview:useMouldButton];
    
    dontUseMouldButton = [[UIButton alloc]initWithFrame:
                               CGRectMake(100 + buttonWith, buttonY, buttonWith, buttonWith)];
    dontUseMouldButton.tag = 1;
    dontUseMouldButton.adjustsImageWhenHighlighted = NO;
    dontUseMouldButton.backgroundColor = [UIColor purpleColor];
    [dontUseMouldButton setBackgroundImage:[UIImage imageNamed:@"social-whrite"] forState:UIControlStateNormal];
    dontUseMouldButton.layer.masksToBounds = YES;
    dontUseMouldButton.layer.cornerRadius = buttonWith/2;
    dontUseMouldButton.alpha = 0.f;
    [self.view addSubview:dontUseMouldButton];
    
    [self performSelector:@selector(showButton:) withObject:useMouldButton afterDelay:0.5f];
    [self performSelector:@selector(showButton:) withObject:dontUseMouldButton afterDelay:1.f];
    
    //add action
    [self performSelector:@selector(buttonsAddTarget) withObject:nil afterDelay:2.f];
    
    //lazy to do somethings on backstage thread
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark tableview delegate and datasource

#pragma --mark action
//绑定按钮事件
- (void)buttonsAddTarget {
    [[useMouldButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self showButtonClickAnimation:0];
     }];
    
    [[dontUseMouldButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         [self showButtonClickAnimation:1];
     }];
}

//页面初始化的时候显示按钮动画效果
- (void)showButton: (UIButton *)button {
    //透明度
    [UIView animateWithDuration:0.5f animations:^{
        button.alpha = 1;
    }];
    //反弹效果
    MMTweenAnimation *anim = [MMTweenAnimation animation];
    anim.functionType   = MMTweenFunctionBounce;
    anim.easingType     = MMTweenEasingOut;
    anim.duration       = 2.0f;
    anim.fromValue      = @[@0];
    anim.toValue        = @[[NSNumber numberWithFloat:button.frame.origin.y]];
    anim.animationBlock = ^(double c,double d,NSArray *v,id target,MMTweenAnimation *animation)
    {
        //c: current time, from the beginning of animation
        //d: duration, always bigger than c
        //v: value, after the change at current time
        
        double value = [v[0] doubleValue];
        UIView *t = (UIView*)target;
        //        t.center = CGPointMake(t.bounds.origin.x, value);
        t.frame = CGRectMake(t.frame.origin.x, value, t.frame.size.width, t.frame.size.height);
    };
    
    [button pop_addAnimation:anim forKey:@"center.y"];
}

//按钮点击后显示的动画效果
- (void)showButtonClickAnimation: (NSInteger)buttonIndex{
    UIButton *showButton  = buttonIndex == 0 ? useMouldButton : dontUseMouldButton;
    UIButton *hidenButton = buttonIndex == 0 ? dontUseMouldButton : useMouldButton;
    
    [UIView animateWithDuration:0.5f animations:^{
        showButton.center = self.view.center;
        POPSpringAnimation *hidenButtonSize = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
        hidenButtonSize.toValue = [NSValue valueWithCGSize:CGSizeZero];
        [hidenButton.layer pop_addAnimation:hidenButtonSize forKey:@"hidenButtonSize"];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f animations:^{
            [showButton setBackgroundImage:nil forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            POPSpringAnimation *showButtonSize = [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
            showButtonSize.toValue = [NSValue valueWithCGSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height * 1.5f,
                                                                             [[UIScreen mainScreen] bounds].size.height * 1.5f)];
            [showButton.layer pop_addAnimation:showButtonSize forKey:@"showButtonSize"];
            [self performSelector:@selector(test) withObject:nil afterDelay:0.3f];
        }];
    }];
}

- (void)test {
    //首先定义一个回调方法，用来关闭压栈的控制器
    void (^returnBlock)(NSString*, UIViewController*) = ^(NSString *contentValue, UIViewController *subVC){
        NSLog(@"选择短信后回调的短信内容为：\n%@",contentValue);
        [subVC dismissViewControllerAnimated:NO completion:nil];
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
    };
    
    MouldSwitchTableViewController *vc = [[MouldSwitchTableViewController alloc]initWithReturnBlock:returnBlock];
    vc.title = @"短信模板库";
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:nil];
}

- (void)showWhriteMassContentView: (NSString *)content{
    
}

- (void)popViewToMainController {
    [self.navigationController.view.layer addAnimation:[WZAnimatingTransition backwardTransition] forKey:@"transition"];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
