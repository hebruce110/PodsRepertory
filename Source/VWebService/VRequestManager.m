//
//  VRequestManager.m
//  VWebService
//
//  Created by yuan on 14-7-4.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "VRequestManager.h"
#import "VWebService.h"

//request parameter key
static NSString *const kResquestParameter            = @"p";
static NSString *const kResquestParameterSignature   = @"sign";
static NSString *const kResquestParameterAction      = @"action";

static NSString *const kAppInfoPlatform              = @"plat";
static NSString *const kAppInfoVersion               = @"version";
static NSString *const kAppInfoScreenSize            = @"screensize";

//response json key
static NSString *const kResponseParameterStatus      = @"status";
static NSString *const kResponseParameterMessage     = @"msg";
static NSString *const kResponseParameterContent     = @"content";

//error codes
static NSString *const kAPIErrorCodes                = @"VErrorCodes";

//约定的默认校验串码
#define kSignatureDefaultCode @"XxV58bu28P7a885X"


@implementation VRequestManager
{
    NSDictionary *_errorCodes;
    NSString *_webserviceURL;
}

+ (instancetype )sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceSingleton;
    dispatch_once(&onceSingleton, ^{
        NSString *url = [[NSUserDefaults standardUserDefaults]valueForKey:kWebServiceURL];
        if (!isValidString(url)) {
            HYLog(@"#######error: please configure webservice url######");
            url = @"";
        }
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:url]];
    });
    return sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    //add https support
    self.securityPolicy.allowInvalidCertificates = YES;
    
    //add text/html,plain
    self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    _webserviceURL = url.absoluteString;
    _isAgreedParameterFormat = YES;
    _isAgreedResponseContentFormat = YES;
    _isRestfulFormatActionParameter = YES;
    
    //add app info to request header
    [self.requestSerializer setValue:kAppVersion forHTTPHeaderField:kAppInfoVersion];
    [self.requestSerializer setValue:@"ios" forHTTPHeaderField:kAppInfoPlatform];
    [self.requestSerializer setValue:[NSString stringWithFormat:@"%.fx%.f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height] forHTTPHeaderField:kAppInfoScreenSize];
    
    return self;
}


//读取程序设置的校验码
- (NSString *)getSignatureCode
{
    NSString *code =  [[NSUserDefaults standardUserDefaults]valueForKey:kSignatureCode];
    if (!isValidString(code)) {
        return kSignatureDefaultCode;
    }
    return code;
}

//读取附加参数
- (NSDictionary *)getAdditionParameters
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *parameters = [userDefaults valueForKey:kAdditionParameters];
    if (isValidDictionary(parameters)) {
        return parameters;
    }
    return nil;
}

#pragma mark Request

//格式化参数
- (NSDictionary *)formatParameters:(NSDictionary *)parameters
{
    //参数的json字符串
    if (!isValidDictionary(parameters)) {
        parameters = @{};
    }
    
    //这里读取在项目中设置的基础参数
    NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [newParameters addEntriesFromDictionary:[self getAdditionParameters]];
    NSString *parametersJsonString = FormatString([newParameters toJsonString], @"");
    
    //校验字符串
    NSString* signature=[[NSString stringWithFormat:@"%@%@",[self getSignatureCode],parametersJsonString] toMD5];
    
    //将校验位传递到header中
    [self.requestSerializer setValue:signature forHTTPHeaderField:kResquestParameterSignature];
    
    //如果为空就返回nil
    if (newParameters.count<1) {
        return nil;
    }
    
    return @{kResquestParameter:parametersJsonString};
}



- (void)requstMethord:(NSString *)methord
               action:(NSString *)action
            parameter:(NSDictionary *)_parameters
        callbackBlock:(RequestCallBackBlock)block
{
    action = FormatString(action,@"");
    
    NSString *urlString;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:_parameters];
    if (_isRestfulFormatActionParameter) {
        urlString = [[NSURL URLWithString:action relativeToURL:self.baseURL] absoluteString];
    }else {
        if (isValidString(action)){
            parameters[kResquestParameterAction] = action;
        }
        urlString = [[NSURL URLWithString:@"" relativeToURL:self.baseURL] absoluteString];
    }
    
    //如果最后一个是/就去掉
    if (urlString.length>0 && [[urlString substringFromIndex:urlString.length-1] isEqualToString:@"/"]) {
        urlString = [urlString substringToIndex:urlString.length-1];
    }
    
    //如果请求不是按照约定的格式，那么就会按正常的request的格式去请求，不进行校验等.
    NSDictionary *vars = _isAgreedParameterFormat?[self formatParameters:parameters]:parameters;
    
    NSMutableURLRequest *request;
    if (_webServiceStyle == WebServiceStyleRaw) {
        request = [self.requestSerializer requestWithMethod:methord URLString:urlString parameters:nil error:nil];
        if (isValidDictionary(_parameters)) {
            //这里读取在项目中设置的基础参数
            NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
            [newParameters addEntriesFromDictionary:[self getAdditionParameters]];
            NSString *jsonString = [newParameters toJsonString];
            [request setHTTPBody: [jsonString dataUsingEncoding:NSUTF8StringEncoding]];
            HYLog(@"\nHTTP Request:＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝》\nStyle:raw \nMethord: %@ %@ \nAction: %@ \nParameters: %@ \nUrl: %@\n",methord,[[NSDate date] formatYMDHMS],action,jsonString,request.URL.absoluteString);
        }
    }else {
        request = [self.requestSerializer requestWithMethod:methord URLString:urlString parameters:vars error:nil];
        HYLog(@"\nHTTP Request:＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝》\nStyle:form-data \nMethord: %@ %@ \nAction: %@ \nParameters: %@ \nUrl: %@\n",methord,[[NSDate date] formatYMDHMS],action,vars,request.URL.absoluteString);
    }
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request
                                                                      success:^(AFHTTPRequestOperation *operation, id info){
                                                                          HYLog(@"\nHTTP Response:《＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝\nMethord: %@ %@ \nStatus: %d \nAction: %@\nContent:\n%@",request.HTTPMethod,[[NSDate date] formatYMDHMS],operation.response.statusCode,request.URL.absoluteString,info);
                                                                          [self handleRequest:operation result:info status:YES callbackBlock:block];
                                                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                          HYLog(@"\nHTTP Response:《＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝\nMethord: %@ %@ \nStatus: %d \nError:%d %@ \nAction: %@ \nParameters: %@ \nUrl: %@\n",request.HTTPMethod,[[NSDate date] formatYMDHMS],operation.response.statusCode,error.code,error.localizedDescription,action,vars,request.URL.absoluteString);
                                                                          [self handleRequest:operation result:error status:NO callbackBlock:block];
                                                                      }];
    [self.operationQueue addOperation:operation];
}

- (void)handleRequest:(AFHTTPRequestOperation *)operation
               result:(id)info
               status:(BOOL)status
        callbackBlock:(RequestCallBackBlock)block
{
    if (block){
        if (_isAgreedResponseContentFormat) {
            if (isValidDictionary(info)) {
                id responseStatus = info[kResponseParameterStatus];
                if (!responseStatus) {
                    responseStatus = @(0);
                }
                NSError *error = [self createError:[responseStatus intValue] description:info[kResponseParameterMessage]];
                block(info[kResponseParameterContent],status,error);
            }else if(info && [info isKindOfClass:[NSError class]]){
                NSError *error = (NSError *)info;
                error = [self createError:error.code description:nil];
                block(nil,status,error);
            }
        }else { //返回的数据不是采用的约定格式，自定义处理
            if (status) {
                block(info,status,nil);
            }else {
                block(nil,status,info);
            }
        }
    }
}

#pragma mark NSError

- (void)initErrorCodes
{
    HYLog(@"初始化错误码列表...");
    if (!_errorCodes) {
        _errorCodes = [[NSDictionary alloc]initWithContentsOfFile:PATH(kAPIErrorCodes, @"plist")];
        if (isValidDictionary(_errorCodes)) {
            HYLog(@"错误码列表初始化成功");
        }else {
            HYLog(@"初始化错误码列表失败，请检查VErrorCodes.plist文件是否存在");
        }
    }
}

- (NSString *)errorDescriptionWithErrorCode:(NSString *)errorCode
{
    if(_errorCodes != nil && errorCode && [errorCode length]>0)
    {
        NSString *errorDescription = [_errorCodes objectForKey:errorCode];
        if (errorDescription == nil || [errorDescription length] < 1)
        {
            errorDescription = [_errorCodes objectForKey:@"-404"];
        }
        return errorDescription;
    }
    return @"unknown";
}

- (NSError *)createError:(NSInteger)errorCode
             description:(NSString *)errorDescription
{
    
    if (errorCode == 0 || errorCode == 200)return nil;
    if (![VWebService isConnected])errorCode = -1000;
    if (!isValidString(errorDescription)) {
        errorDescription = [self errorDescriptionWithErrorCode:[@(errorCode) stringValue]];
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:errorDescription forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:FormatString(_webserviceURL,@"") code:errorCode userInfo:userInfo];
    return error;
}


@end












