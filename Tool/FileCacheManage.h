//
//  FileCacheManage.h
//  MassTool
//
//  Created by Coder雲逍遥 on 16/3/8.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileCacheManage : NSObject
/**
 *  获取mould数据,如果沙箱内没有,则取用资源文件中的文件,更新本地文件
 */
+ (NSArray*)getMouldData;

/**
 *  更新本地缓存文件
 */
+ (void)updateMouldData: (NSData*)data;
@end
