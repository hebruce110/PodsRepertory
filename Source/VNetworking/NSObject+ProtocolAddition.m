//
//  NSObject+ProtocolAddition.m
//  PatPat
//
//  Created by Bruce He on 15/7/16.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "NSObject+ProtocolAddition.h"

@implementation NSObject (NSObject_ProtocolAddition)

- (BOOL)checkProtocolImplementation:(Protocol *)aProtocol
{
    return ([self conformsToProtocol:aProtocol] && [self checkMethodImplementation:aProtocol]);
}

- (BOOL) checkMethodImplementation:(Protocol *)aProtocol
{
    Class aClass = [self class];
    struct objc_method_description *methods;
    unsigned int count;
    
    // required instance methods
    methods = protocol_copyMethodDescriptionList(aProtocol, YES, YES, &count);
    for (unsigned int ix = 0; ix < count; ix++)
    {
        if (![aClass instancesRespondToSelector:methods[ix].name])
        {
            free(methods);
            return NO;
        }
    }
    free(methods);
    
    // required class methods
    methods = protocol_copyMethodDescriptionList(aProtocol, YES, NO, &count);
    for (unsigned int ix = 0; ix < count; ix++)
    {
        if (![aClass respondsToSelector:methods[ix].name])
        {
            free(methods);
            return NO;
        }
    }
    free(methods);
    
    // other protocols
    Protocol * __unsafe_unretained *protocols = protocol_copyProtocolList(aProtocol, &count);
    for (unsigned int ix = 0; ix < count; ix++)
    {
        if (![self checkMethodImplementation:protocols[ix]])
        {
            free(protocols);
            return NO;
        }
    }
    free(protocols);
    
    return YES;
}

@end
