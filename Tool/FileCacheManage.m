//
//  FileCacheManage.m
//  MassTool
//
//  Created by Coder雲逍遥 on 16/3/8.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#import "FileCacheManage.h"
#import "ICSandboxHelper.h"

@implementation FileCacheManage
+ (NSArray *)getMouldData{
    NSString *path = [ICSandboxHelper libCachePath];
    //获取文件
    path = [NSString stringWithFormat:@"%@/mould.plist",path];
    NSData *mouldData = [NSData dataWithContentsOfFile:path];
    if(mouldData == nil){
        [self updateMouldData:nil];
    }
    return [[NSArray alloc] initWithContentsOfFile:path];
}

+ (void)updateMouldData:(NSData *)data{
    NSString *path = [ICSandboxHelper libCachePath];
    path = [NSString stringWithFormat:@"%@/mould.plist",path];
    NSFileManager *file = [[NSFileManager alloc]init];
    NSString *resourcePath;
    
    if(data == nil){
        resourcePath = [[NSBundle mainBundle]pathForResource:@"mould" ofType:@"plist"];
        NSURL *resourceURL = [NSURL fileURLWithPath:resourcePath];
        data = [NSData dataWithContentsOfURL:resourceURL];
    }
    [file createFileAtPath:path contents:data attributes:nil];
}
@end
