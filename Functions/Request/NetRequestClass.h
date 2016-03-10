//
//  NetRequestClass.h
//  BestWishes
//
//  Created by 微博@iOS攻城犭师 on 16/2/25.
//  Copyright © 2016年 github.com/SSshare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestClass : NSObject
#pragma 监测网络的可链接性
+ (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl;

#pragma GET请求
+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (RequestSuccessBlock) successBlock
                  WithErrorCodeBlock: (RequestErrorBlock) errorBlock
                    WithFailureBlock: (RequestFailureBlock) failureBlock;

#pragma POST请求
+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                 WithReturnValeuBlock: (RequestSuccessBlock) successBlock
                   WithErrorCodeBlock: (RequestErrorBlock) errorBlock
                     WithFailureBlock: (RequestFailureBlock) failureBlock;

@end
