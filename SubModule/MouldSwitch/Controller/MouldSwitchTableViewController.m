//
//  MouldSwitchTableViewController.m
//  MassTool
//
//  Created by Coder雲逍遥 on 16/3/9.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#import "MouldSwitchTableViewController.h"
#import <AMWaveTransition.h>                 //cell aniamtion
#import "UITableView+FDTemplateLayoutCell.h" //cell height
#import "FileCacheManage.h"                  //cell data cache

#import "mouldGroupTableViewCell.h"
#import "MouldSwitchItemTableViewController.h"
//#import "mouldItemTableViewCell.h"

#define cellIdentifier @"MouldGroupCell"     //重用视图id

@interface MouldSwitchTableViewController ()<UINavigationControllerDelegate>
@property (nonatomic, copy) returnBlock returnBlock;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) IBOutlet AMWaveTransition *interactive;
@end

@implementation MouldSwitchTableViewController

- (instancetype)initWithReturnBlock:(returnBlock)block {
    self = [super init];
    self.returnBlock = block;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1,样式设置
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"X" style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    //2,tableView设置
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //3,cell animation设置
    self.interactive = [[AMWaveTransition alloc] init];
    [self.navigationController.view setBackgroundColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                      NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                                                      }];
    [self.navigationController.navigationBar setHidden:NO];
    //4,重用视图加载到内存
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([mouldGroupTableViewCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
    //5,获取缓存中的数据
    self.data = [FileCacheManage getMouldData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack {
    self.returnBlock(nil,self);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    mouldGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.entity = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier configuration:^(id cell) {
        ((mouldGroupTableViewCell*)cell).entity = self.data[indexPath.row];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MouldSwitchItemTableViewController *vc = \
    [[MouldSwitchItemTableViewController alloc]initWithData:self.data[indexPath.row][@"data"]
                                                returnBlock:self.returnBlock];
    vc.title = self.data[indexPath.row][@"name"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    [self.navigationController setDelegate:nil];
}

#pragma --mark cell animation
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromVC
                                                 toViewController:(UIViewController*)toVC {
    if (operation != UINavigationControllerOperationNone) {
        // Return your preferred transition operation
        return [AMWaveTransition transitionWithOperation:operation];
    }
    return nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setDelegate:self];
}

- (NSArray*)visibleCells {
    return [self.tableView visibleCells];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.interactive detachInteractiveGesture];
}


@end
