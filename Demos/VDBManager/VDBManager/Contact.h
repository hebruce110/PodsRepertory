//
//  Contacts.h
//  Financial
//
//  Created by Yuan on 14-3-1.
//  Copyright (c) 2014年 suihuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ContactTypeInvite, //邀请
    ContactTypeAddFriend, //已经注册但是还未被我添加成好友添加好友
    ContactTypeAdded //已经是我的好友
}ContactType;

@interface Contact : NSObject
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *tel;
@property(nonatomic,retain)NSString *userid;
@property(nonatomic,retain)NSString *type;

+ (NSMutableArray *) allRecords;

+ (NSMutableArray *)searchCantacts:(NSString *)keywords;

+ (void) insert:(NSDictionary *) contact;

@end
