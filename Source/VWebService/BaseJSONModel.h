//
//  BaseJSONModel.h
//  VWebService
//
//  Created by yuan on 14-7-4.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//
#import "JSONModelLib.h"

//定义一个可变的参数的block
typedef void (^ModelBlock)(id model,NSError *error) ;

@interface BaseJSONModel : JSONModel

@end
