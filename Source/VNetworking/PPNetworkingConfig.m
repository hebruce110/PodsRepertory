//
//  PPNetworkingConfig.m
//  PatPat
//
//  Created by Bruce He on 15/7/10.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPNetworkingConfig.h"
#import "PPNSString+Addition.h"

@interface PPNetworkingConfig()

@property (nonatomic, strong)  NSString      *host;                          //request host
@property (nonatomic, strong)  AFHTTPRequestSerializer  *requestSerializer ; //request serializer
@property (nonatomic, strong)  AFHTTPResponseSerializer *responseSerializer ; //response serializer

@end

@implementation PPNetworkingConfig

+ (PPNetworkingConfig *)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)initWithHost:(NSString *)host
   requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
  responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
{
    NSAssert(host, @"## Error(initWithHost:): host is nil ,but it must be a string,");
    [[PPNetworkingConfig sharedInstance]setHost:host];
    if (requestSerializer) {
        [[PPNetworkingConfig sharedInstance]setRequestSerializer:requestSerializer];
    }
    
    if (responseSerializer) {
        [[PPNetworkingConfig sharedInstance]setResponseSerializer:responseSerializer];
    }
}

+ (void)initWithHost:(NSString *)host
{
    [self initWithHost:host requestSerializer:nil responseSerializer:nil];
}

- (id)init {
    self = [super init];
    if (self) {
        _host = nil;
        _timeoutInterval = 30; //default 30s
        _printLogType = PPRequestPrintLogTypeNSObject; //default string
        _requestSerializer = [AFHTTPRequestSerializer serializer];
        _responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

@end
