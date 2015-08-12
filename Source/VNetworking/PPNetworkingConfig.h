//
//  PPNetworkingConfig.h
//  PatPat
//
//  Created by Bruce He on 15/7/10.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPRequestSerializer+XMLRequestSerializer.h"

typedef enum {
    PPRequestPrintLogTypeNone, //no request log will be printed
    PPRequestPrintLogTypeNSString, //request log will be printed with string(eg:json or xml) format
    PPRequestPrintLogTypeNSObject //request log will be printed with NSObject format,e.g:NSArray,NSDictionary
}PPRequestPrintLogType;

@interface PPNetworkingConfig : NSObject

@property (readonly)   NSString      *host;          //request host
@property (readonly)  AFHTTPRequestSerializer  *requestSerializer ; //request serializer
@property (readonly)  AFHTTPResponseSerializer *responseSerializer ; //response serializer
@property (nonatomic, assign)  NSInteger   timeoutInterval ; //request timeout interval
@property (nonatomic, assign)  PPRequestPrintLogType  printLogType ; //the type of print log

+ (PPNetworkingConfig *)sharedInstance;

+ (void)initWithHost:(NSString *)host;

+ (void)initWithHost:(NSString *)host
   requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
  responseSerializer:(AFHTTPResponseSerializer *)responseSerializer;

@end
