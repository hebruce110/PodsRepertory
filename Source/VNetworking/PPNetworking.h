//
//  PPRequestManager.h
//  PatPat
//
//  Created by Yuan on 14/12/24.
//  Copyright (c) 2014年 http://www.patpat.com. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "PPRequest.h"
#import "PPNetworkingConfig.h"

@interface PPNetworking : NSObject

+ (PPNetworking *)sharedInstance;

/**
 *  add a request
 *
 *  @param request 需要添加的请求
 */
- (void)addRequest:(PPRequest *)request;

/**
 *  取消请求
 *
 *  @param request 需要取消的请求
 */
- (void)cancelRequest:(PPRequest *)request;

/**
 *  取消所有请求
 */
- (void)cancelAllRequests;

/**
 *  是否有网络连接
 *
 *  @return BOOL
 */
+ (BOOL)isConnected;

@end
