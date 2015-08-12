//
//  PPRequest.m
//  PatPat
//
//  Created by Yuan on 14/12/23.
//  Copyright (c) 2014年 http://www.patpat.com. All rights reserved.
//

#import "PPRequest.h"
#import "PPNetworking.h"
#import "NSObject+ProtocolAddition.h"

@interface PPRequest()

@end

@implementation PPRequest

- (id)init {
    self = [super init];
    if (self) {
        _child = nil;
        _requestReformer = nil;
        _responseReformer = nil;
        _interceptor = nil;
        _error = nil;
        _injector = (id<PPRequestInjector>)self;
        if (_injector && [_injector respondsToSelector:@selector(initInjector:)]) {
            [_injector initInjector:self];
        }
        if ([self checkProtocolImplementation:@protocol(PPRequestProtocol)]) {
            self.child = (id <PPRequestProtocol>)self;
        }else{ //继承本类的子类如果不遵守PPRequestProtocol协议就抛出异常
            NSString *errorDetail = [NSString stringWithFormat:@"subclass %@ must implementation the PPRequestProtocol",NSStringFromClass([self class])];
            NSAssert(NO, errorDetail);
        }
    }
    return self;
}

- (void)start
{
    [[PPNetworking sharedInstance]addRequest:self];
}

- (void)stop
{
    [[PPNetworking sharedInstance]cancelRequest:self];
}

- (BOOL)isExecuting {
    return self.requestOperation.isExecuting;
}

- (void)startWithCompletionHandler:(RequestCompletionHandler)handler
{
    self.completionHandler = handler;
    [self start];
}

- (void)setCompletionBlockWithSuccess:(RequestSuccessCompletionBlock)success
                              failure:(RequestFailureCompletionBlock)failure
{
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)startWithCompletionBlockWithSuccess:(RequestSuccessCompletionBlock)success
                                    failure:(RequestFailureCompletionBlock)failure
{
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)clearCompletionBlock
{
    self.completionHandler = nil;
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (id)responseObject
{
    return self.requestOperation.responseObject;
}

- (NSString *)responseString
{
    return self.requestOperation.responseString;
}

- (NSInteger)responseStatusCode
{
    return self.requestOperation.response.statusCode;
}

- (NSDictionary *)responseHeaders
{
    return self.requestOperation.response.allHeaderFields;
}

- (NSString *)absoluteString
{
    return self.requestOperation.request.URL.absoluteString;
}

- (BOOL)statusCodeValidator
{
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode >= 200 && statusCode <=299) {
        return YES;
    } else {
        return NO;
    }
}

@end
