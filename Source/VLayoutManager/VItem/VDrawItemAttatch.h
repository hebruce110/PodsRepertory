//
//  PKDrawItemAttatch.h
//  Vote
//
//  Created by yuan on 14-1-13.
//  Copyright (c) 2014年 yuan.he. All rights reserved.
//

#import "VDrawItem.h"

@interface VDrawItemAttatch : VDrawItem
@property (nonatomic, strong)  NSString *url;   //链接url
@property (nonatomic) NSInteger attachType;     //附件类型
@property (nonatomic) NSInteger  attachStatus;  //附件状态
@end
