//
//  VWebService.m
//  VWebService
//
//  Created by yuan on 14-7-4.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "VWebService.h"

@implementation VWebService

+ (void)configURL:(NSString *)url
    signatureCode:(NSString *)code
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSUserDefaults standardUserDefaults]setObject:url forKey:kWebServiceURL];
    if (isValidString(code)) {
        [[NSUserDefaults standardUserDefaults]setObject:code forKey:kSignatureCode];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[VRequestManager sharedInstance]initErrorCodes];
}

+ (void)setWebServiceStyle:(WebServiceStyle)style
{
    [[VRequestManager sharedInstance]setWebServiceStyle:style];
}

+ (void)setIsAgreedParameterFormat:(BOOL)isAgreed
{
    if (isValidString([[NSUserDefaults standardUserDefaults]objectForKey:kWebServiceURL])) {
        [[VRequestManager sharedInstance]setIsAgreedParameterFormat:isAgreed];
    }
}

+ (void)setIsAgreedResponseContentFormat:(BOOL)isAgreed
{
    if (isValidString([[NSUserDefaults standardUserDefaults]objectForKey:kWebServiceURL])) {
        [[VRequestManager sharedInstance]setIsAgreedResponseContentFormat:isAgreed];
    }
}

+ (void)setIsRestfulFormatActionParameter:(BOOL)isRestful
{
    if (isValidString([[NSUserDefaults standardUserDefaults]objectForKey:kWebServiceURL])) {
        [[VRequestManager sharedInstance]setIsRestfulFormatActionParameter:isRestful];
    }
}

+ (void)setAdditionParameters:(NSDictionary *)parameters
{
    if (isValidDictionary(parameters)) {
        [[NSUserDefaults standardUserDefaults] setObject:parameters forKey:kAdditionParameters];
    }else{
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAdditionParameters];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (BOOL)isConnected{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (void)setTimeOut:(NSInteger)timeOut
{
    [[VRequestManager sharedInstance].requestSerializer setTimeoutInterval:timeOut];
}

#pragma mark Request action

+(void)getRequestAction:(NSString *)action
              parameter:(NSDictionary *)parameter
          callbackBlock:(RequestCallBackBlock)block
{
    [VRequestManager.sharedInstance requstMethord:kRequestMethodGet
                                           action:action
                                        parameter:parameter
                                    callbackBlock:block];
    
}

+(void)postRequestAction:(NSString *)action
               parameter:(NSDictionary *)parameter
           callbackBlock:(RequestCallBackBlock)block
{
    [VRequestManager.sharedInstance requstMethord:kRequestMethodPost
                                           action:action
                                        parameter:parameter
                                    callbackBlock:block];
}

+(void)putRequestAction:(NSString *)action
              parameter:(NSDictionary *)parameter
          callbackBlock:(RequestCallBackBlock)block
{
    [VRequestManager.sharedInstance requstMethord:kRequestMethodPut
                                           action:action
                                        parameter:parameter
                                    callbackBlock:block];
}

+(void)deleteRequestAction:(NSString *)action
                 parameter:(NSDictionary *)parameter
             callbackBlock:(RequestCallBackBlock)block
{
    [VRequestManager.sharedInstance requstMethord:kRequestMethodDelete
                                           action:action
                                        parameter:parameter
                                    callbackBlock:block];
}

+(void)patchRequestAction:(NSString *)action
                parameter:(NSDictionary *)parameter
            callbackBlock:(RequestCallBackBlock)block
{
    [VRequestManager.sharedInstance requstMethord:kRequestMethodPatch
                                           action:action
                                        parameter:parameter
                                    callbackBlock:block];
}

@end
