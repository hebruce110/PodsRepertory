//
//  VRequestManager.h
//  VWebService
//
//  Created by yuan on 14-7-4.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

#define kSignatureCode @"vwebservice.request.signaturecode"
#define kWebServiceURL @"vwebservice.request.url"
#define kAdditionParameters @"vwebservice.request.additionparameters"

/* HTTP Methord*/
#define kRequestMethodGet                                 @"GET"
#define kRequestMethodPut                                 @"PUT"
#define kRequestMethodPost                                @"POST"
#define kRequestMethodPatch                               @"PATCH"
#define kRequestMethodDelete                              @"DELETE"

typedef void (^RequestCallBackBlock)(id result,BOOL status,NSError *error);

@interface VRequestManager : AFHTTPRequestOperationManager

+ (instancetype )sharedInstance;

- (void)initErrorCodes;

- (void)requstMethord:(NSString *)methord
               action:(NSString *)action
            parameter:(NSDictionary *)parameters
        callbackBlock:(RequestCallBackBlock)block;

@end
