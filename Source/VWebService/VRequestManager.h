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

typedef enum {
    WebServiceStyleFormData, //
    WebServiceStyleRaw       //no key and value request
}WebServiceStyle;

typedef void (^RequestCallBackBlock)(id result,BOOL status,NSError *error);

@interface VRequestManager : AFHTTPRequestOperationManager

@property(nonatomic)BOOL isAgreedParameterFormat;   //是否是按照约定的请求参数格式
@property(nonatomic)BOOL isAgreedResponseContentFormat; //服务端是否是按照约定的格式返回数据
@property(nonatomic)BOOL isRestfulFormatActionParameter; //是否是按Restful路径风格传输action参数
@property(nonatomic)WebServiceStyle webServiceStyle; //请求的style

+ (instancetype )sharedInstance;

- (void)initErrorCodes;

- (void)requstMethord:(NSString *)methord
               action:(NSString *)action
            parameter:(NSDictionary *)parameters
        callbackBlock:(RequestCallBackBlock)block;

@end
