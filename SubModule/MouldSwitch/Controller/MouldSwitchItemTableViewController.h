//
//  MouldSwitchItemTableViewController.h
//  MassTool
//
//  Created by Coder雲逍遥 on 16/3/9.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnBlock)(NSString *contentValue, UIViewController *controller);

@interface MouldSwitchItemTableViewController : UITableViewController
- (instancetype)initWithData: (NSArray*)data returnBlock:(returnBlock)block;
@end
