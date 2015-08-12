//
//  PPRequest.h
//  PatPat
//
//  Created by Yuan on 14/12/23.
//  Copyright (c) 2014年 http://www.patpat.com. All rights reserved.
//
//  Request的基类，所有请求类请继承此类,并遵守PPRequestProtocol协议
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "PPNetworkingConfig.h"

@class PPRequest;

//request methord
typedef enum{
    PPRequestMethodGet = 0,
    PPRequestMethodPost,
    PPRequestMethodHead,
    PPRequestMethodPut,
    PPRequestMethodDelete,
} PPRequestMethod;

//block callback
typedef void (^RequestSuccessCompletionBlock)(PPRequest *request);
typedef void (^RequestFailureCompletionBlock)(PPRequest *request,NSError *error);
typedef void (^RequestCompletionHandler)(id result,PPRequest *request,NSError *error);
typedef void (^PPRequestMultipartFormDataBlock)(id<AFMultipartFormData> formData);
typedef void (^PPRequestUploadProgressBlock)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);

//规定所有的子类必须符合本协议，否则不能继承此类,子类里必须实现为@required的方法才能编译通过
@protocol PPRequestProtocol <NSObject>

@required

/**
 *  Http请求的方法，默认为POST请求，如果需要修改为GET，PUT等在subclass里修改
 *
 *  @return 方法
 */
- (PPRequestMethod)requestMethod;

/**
 *  请求地址的url path，比如/user/add
 *
 *  @return 字符串
 */
- (NSString *)path;

@optional

/**
 *  特别需要注意host一定先要在PPNetworkingConfig里初始化设置一个，否则会抛出没有host
 *  的异常提示，这里把host放在可选里是为了有多个url的场景：
 *  比如全局host设置为了http://api.test.com，某一个接口需要换到新的http://api2.test.com，
 *  那么可以在子类里实现host，返回http://api2.test.com即可。
 *
 *  @return 字符串
 */
- (NSString *)host;

/**
 *  在HTTP报头添加的自定义参数
 *
 *  @return 字典
 */
- (NSDictionary *)requestHeaderFieldValueDictionary;

/**
 *  请求的参数
 *
 *  @return id
 */
- (id)requestParameter;

/**
 *   请求的连接超时时间，默认为60秒
 *
 *  @return NSTimeInterval
 */
- (NSTimeInterval)requestTimeoutInterval;

/**
 *  请求的serializer
 *
 *  @return AFHTTPRequestSerializer
 */
- (AFHTTPRequestSerializer *)requestSerializer;

/**
 *  请求返回内容处理的serializer
 *
 *  @return AFHTTPResponseSerializer
 */
- (AFHTTPResponseSerializer *)responseSerializer;

/**
 *  当POST内容带有file时使用
 *
 *  @return PPRequestMultipartFormDataBlock
 */
- (PPRequestMultipartFormDataBlock)multipartFormDataBlock;

/**
 *  上传block
 *
 *  @return PPRequestUploadProgressBlock
 */
- (PPRequestUploadProgressBlock)uploadProgressBlock;

@end

//注入器：初始化时，通过这个协议可以实现统一注入
@protocol PPRequestInjector <NSObject>

@optional
- (void)initInjector:(PPRequest *)request;

@end

//拦截器:请求完成后调用，实现协议方法后，可以在方法里完成比如说对某一状态做处理。
@protocol PPRequestInterceptor <NSObject>

@optional
- (void)interceptRequest:(PPRequest *)request;

@end

//Request reformer:对请求的数据统一做refrom处理，比如做签名，添加共用参数等
@protocol PPRequestReformer <NSObject>

@optional
- (void)requestReformerWithHeaders:(id)headers
                        parameters:(id)parameters
                          finished:(void(^)(id newHeaders,id newParameters))result;

@end

//Response reformer:对返回的数据统一做refrom处理,比如对返回数据格式处理等
@protocol PPResponseReformer <NSObject>

@optional
- (void)responseReormer:(PPRequest *)request;

@end

@interface PPRequest : NSObject
@property (nonatomic) NSInteger tag;
@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;
@property (nonatomic, copy) RequestSuccessCompletionBlock successCompletionBlock;
@property (nonatomic, copy) RequestFailureCompletionBlock failureCompletionBlock;
@property (nonatomic, copy) RequestCompletionHandler completionHandler;
@property (nonatomic, strong, readonly) NSDictionary *responseHeaders;
@property (nonatomic, strong, readonly) NSString *responseString;
@property (nonatomic, strong, readonly) NSString *absoluteString;
@property (nonatomic, strong, readonly) id responseObject;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, readonly)  NSInteger responseStatusCode;
@property (nonatomic, weak) id <PPRequestProtocol> child;
@property (nonatomic, weak) id<PPRequestReformer> requestReformer;
@property (nonatomic, weak) id<PPResponseReformer> responseReformer;
@property (nonatomic, weak) id<PPRequestInterceptor> interceptor;
@property (nonatomic, weak) id<PPRequestInjector> injector;
@property (nonatomic, readonly) BOOL statusCodeValidator;

/**
 *  开始请求,相当于setCompletionBlockWithSuccess:failure:和start一起调用
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)startWithCompletionBlockWithSuccess:(RequestSuccessCompletionBlock)success
                                    failure:(RequestFailureCompletionBlock)failure;

/**
 *  开始请求，并且通过一个handler返回,
 *
 *  @param handler 回调的handler，相当于把success和failure两个block集为一个
 */
- (void)startWithCompletionHandler:(RequestCompletionHandler)handler;

/**
 *  设置回调
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)setCompletionBlockWithSuccess:(RequestSuccessCompletionBlock)success
                              failure:(RequestFailureCompletionBlock)failure;

/**
 *  开始请求
 */
- (void)start;

/**
 *  停止请求
 */
- (void)stop;

/**
 *  请求的状态
 *
 *  @return BOOL
 */
- (BOOL)isExecuting;

/**
 *  清理Block
 */
- (void)clearCompletionBlock;

@end
