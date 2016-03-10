//
//  WZTransitionDetailController.m
//  WZAnimatingTransition
//
//  Created by Wongzigii on 5/21/15.
//  Copyright (c) 2015 Wongzigii. All rights reserved.
//

#import "WZTransitionDetailController.h"
#import "MainTableController.h"
#import "WZDraggableSwitchHeaderView.h"
#import "WZAnimatingTransition.h"

@interface WZTransitionDetailController ()<UIScrollViewDelegate, WZDraggableSwitchHeaderViewDelegate>

@property (nonatomic, strong) WZDraggableSwitchHeaderView *headerView;
@property (nonatomic, strong) UIScrollView                *scrollView;

@end

@implementation WZTransitionDetailController

#pragma mark - ViewControllers LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView = [[WZDraggableSwitchHeaderView alloc] initWithDelegate:self frame:CGRectMake(0, 0, self.view.bounds.size.width, 50) normalStateHeight:20.0f heightCanTriggerSwitch:70.0f];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height, self.headerView.frame.size.width, self.view.bounds.size.height - self.headerView.frame.size.height)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(0, 1.01 * self.scrollView.frame.size.height);
    self.scrollView.delegate = self;
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    self.backGroundImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:self.backGroundImage];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.headerView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - WZDraggableSwitchHeaderViewDelegate

- (void)WZDraggableSwitchHeaderViewDidTriggerDeepDragging;
{
    [self.navigationController.view.layer addAnimation:[WZAnimatingTransition backwardTransition] forKey:@"transition"];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.headerView WZDraggableSwitchHeaderViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.headerView WZDraggableSwitchHeaderViewDidEndDragging:scrollView];
}

@end
