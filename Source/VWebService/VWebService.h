//
//  VWebService.h
//  VWebService
//
//  Created by yuan on 14-7-4.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

/**************************************** 说     明 **************************************
 
 VWebService是为了方便快速开发，总结出来的模块，使用的是AFNetworking2.9,只支持IOS 6.0以上
 据苹果在其开发者页面公布的官方数据,截止到刚刚过去的2014年10,苹果iOS8，IOS7系统在苹果iOS设备中的占有达到95%以上，IOS6占了不到5%，IOS5基本可以忽略了，所以现在的版本可以从IOS6或IOS7开始做最低兼容了。
 
 ******************************************************************************************/

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "VRequestManager.h"

@interface VWebService : NSObject

/**
 *  是否有网络连接
 *
 *  @return BOOL
 */
+ (BOOL)isConnected;

/**
 *  配置Webservice的地址，检验码
 *
 *  @param url  地址
 *  @param code 校验码，需要和后台给的校验码一致才能请求到数据
 */
+ (void)configURL:(NSString *)url
    signatureCode:(NSString *)code;

/**
 *  这只请求的方式，目前只支持常用的form-data格式和raw格式,默认是form-data格式
 *
 *  @param style
 */
+ (void)setWebServiceStyle:(WebServiceStyle)style;

/**
 *  设置超时时间
 *
 *  @param timeOut 超时时间
 */
+ (void)setTimeOut:(NSInteger)timeOut;

/**
 *  请求的参数格式为约定格式。如果请求不是按照约定的格式，那么就会按正常的request的格式去请求，不进行校验等.
 *
 *  @param isAgreed 是否是约定的
 */
+ (void)setIsAgreedParameterFormat:(BOOL)isAgreed;

/**
 *  返回数据的内容格式为约定格式，如果返回是约定的格式就会读取error列表，创建错误码等，否则就会直接返回response的内容
 *
 *  @param isAgreed 是否是约定的
 */
+ (void)setIsAgreedResponseContentFormat:(BOOL)isAgreed;

/**
 *  请求的action是否是restful格式,restful风格是比如http://api.demo.com/user/action 如果不是就是http://api.demo.com/user?action=login
 *
 *  @param isRestful 是否是restful格式
 */
+ (void)setIsRestfulFormatActionParameter:(BOOL)isRestful;

/**
 *  设置一些通用的参数到请求里，所有的接口都会带上这些参数，比如userid，token等，请传入字典格式
 *
 *  @param dict
 */
+ (void)setAdditionParameters:(NSDictionary *)parameters;

/**
 *	@brief	发起GET请求
 *
 *	@param 	action        请求的路径
 *	@param 	parameter 	参数
 *	@param 	block       回调block
 */
+(void)getRequestAction:(NSString *)action
              parameter:(NSDictionary *)parameter
          callbackBlock:(RequestCallBackBlock)block;

/**
 *	@brief	发起POST请求
 *
 *	@param 	action        请求的路径
 *	@param 	parameter 	参数
 *	@param 	block       回调block
 */
+(void)postRequestAction:(NSString *)action
               parameter:(NSDictionary *)parameter
           callbackBlock:(RequestCallBackBlock)block;

/**
 *  上传文件发起POST请求
 *
 *  @param url                           url，不填就用默认的
 *  @param action                        请求的路径
 *  @param parameter                     参数
 *  @param requestMultipartFormDataBlock 上传的内容，传nil则不上传文件，不会回调progressblock
 *  @param requestUploadProgressBlock    上传进度回调,可以传nil不回调
 *  @param block                         请求完回调
 */
+(void)postRequestUrl:(NSString *)url
               action:(NSString *)action
            parameter:(NSDictionary *)parameter
           uploadFile:(VRequestMultipartFormDataBlock)requestMultipartFormDataBlock
             progress:(VRequestUploadProgressBlock)requestUploadProgressBlock
        callbackBlock:(RequestCallBackBlock)block;

/**
 *	@brief	发起PUT请求
 *
 *	@param 	action        请求的路径
 *	@param 	parameter 	参数
 *	@param 	block       回调block
 */
+(void)putRequestAction:(NSString *)action
              parameter:(NSDictionary *)parameter
          callbackBlock:(RequestCallBackBlock)block;

/**
 *	@brief	发起DELETE请求
 *
 *	@param 	action        请求的路径
 *	@param 	parameter 	参数
 *	@param 	block       回调block
 */
+(void)deleteRequestAction:(NSString *)action
                 parameter:(NSDictionary *)parameter
             callbackBlock:(RequestCallBackBlock)block;

/**
 *	@brief	发起PATCH请求
 *
 *	@param 	action        请求的路径
 *	@param 	parameter 	参数
 *	@param 	block       回调block
 */
+(void)patchRequestAction:(NSString *)action
                parameter:(NSDictionary *)parameter
            callbackBlock:(RequestCallBackBlock)block;

@end





