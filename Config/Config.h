//
//  Config.h
//  BestWishes
//
//  Created by 微博@iOS攻城犭师 on 16/2/25.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#ifndef Config_h
#define Config_h

#import <objc/objc.h>
#import <Foundation/Foundation.h>

//网络请求回调的block
typedef void (^RequestSuccessBlock) (id returnValue); //请求成功返回结果
typedef void (^RequestErrorBlock) (NSError *error); //请求成功，有错误:
typedef void (^RequestFailureBlock) (); //请求失败(一般指超时)
typedef void (^NetWorkBlock)(BOOL netConnetState); //

#define DDLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define RGB(R,G,B) [UIColor colorWithRed:(R/255.f) green:(G/255.f) blue:(B/255.f) alpha:1.f]
#define MAINSCREENBOUNDS ([UIScreen mainScreen].bounds)

#define APPVERSON @"1.0"
#define DBNAME [NSString stringWithFormat:@"%@.sqlite",APPVERSON]
#endif /* Config_h */
