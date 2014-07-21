//
//  VRequestManager.h
//  VWebService
//
//  Created by yuan on 14-7-4.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "VExtensions.h"

#define kSignatureCode @"vwebservice.request.signaturecode"
#define kWebServiceURL @"vwebservice.request.url"
#define kAdditionParameters @"vwebservice.request.additionparameters"

/* HTTP Methord*/
#define kRequestMethodGet                                 @"GET"
#define kRequestMethodPut                                 @"PUT"
#define kRequestMethodPost                                @"POST"
#define kRequestMethodPatch                               @"PATCH"
#define kRequestMethodDelete                              @"DELETE"

/* 如果你用到了下面的配置，请将响应的定义拷贝到，工程的-Prefix.pch文件中
默认都是按照约定的格式请求和返回，超时时间也是默认
 
#define VWEBSERVICE_REQUEST_TIMEOUT 30                     //设置超时时间
#define VWEBSERVICE_REQUEST_NOT_FORMATTING_CONVENTIONS      //不是按照约定的请求参数格式
#define VWEBSERVICE_RESPONSE_NOT_FORMATTING_CONVENTIONS     //不是按约定的格式返回
 
*/

typedef void (^RequestCallBackBlock)(id result,BOOL status,NSError *error);

@interface VRequestManager : AFHTTPRequestOperationManager

+ (instancetype )sharedInstance;

- (void)initErrorCodes;

- (void)requstMethord:(NSString *)methord
               action:(NSString *)action
            parameter:(NSDictionary *)parameters
        callbackBlock:(RequestCallBackBlock)block;

@end
