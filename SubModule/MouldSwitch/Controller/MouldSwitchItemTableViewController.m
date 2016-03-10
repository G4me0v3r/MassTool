//
//  MouldSwitchItemTableViewController.m
//  MassTool
//
//  Created by Coder雲逍遥 on 16/3/9.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#import "MouldSwitchItemTableViewController.h"

#import "UITableView+FDTemplateLayoutCell.h"
#import "AMWaveTransition.h" //cell animation

#import "mouldItemTableViewCell.h"

#define cellIdentifier @"MouldItemCell"

@interface MouldSwitchItemTableViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, copy) returnBlock returnBlock;
@property (nonatomic, strong) IBOutlet AMWaveTransition *interactive;
@end

@implementation MouldSwitchItemTableViewController

- (instancetype)initWithData:(NSArray *)data returnBlock:(returnBlock)block {
    self = [super init];
    self.data = data;
    self.returnBlock = block;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self.navigationController action:@selector(popViewControllerAnimated:)];
    //1,tableView设置
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    _interactive = [[AMWaveTransition alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //2,nib regist
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([mouldItemTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setDelegate:self];
    [self.interactive attachInteractiveGestureToNavigationController:self.navigationController];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.interactive detachInteractiveGesture];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier configuration:^(id cell) {
        ((mouldItemTableViewCell*)cell).entity = self.data[indexPath.row];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    mouldItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    ((mouldItemTableViewCell*)cell).entity = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.returnBlock(self.data[indexPath.row][@"contentValue"],self);
}

#pragma --mark cell animation
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC
{
    if (operation != UINavigationControllerOperationNone) {
        return [AMWaveTransition transitionWithOperation:operation];
    }
    return nil;
}

- (void)dealloc
{
    [self.navigationController setDelegate:nil];
}

- (NSArray*)visibleCells {
    return [self.tableView visibleCells];
}

@end
