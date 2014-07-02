//
//  VVersion.m
//  VVersion
//
//  Created by Yuan on 14-7-2.
//  Copyright (c) 2014年 heyuan110.com. All rights reserved.
//

#import "VVersion.h"
#import "VExtensions.h"

/*检测新版本*/
#define CheckAppVersionURL  @"http://itunes.apple.com/lookup?id="

@implementation VVersion

+ (id)getURL:(NSString *)url
{
    if (!isValidString(url)) {
        return nil;
    }
    NSError *error = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.f];
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] init];
    NSData *resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (!error && response.statusCode == 200 && resultData != nil){
        if (resultData == nil) {
            return nil;
        }
        return [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingAllowFragments error:&error];;
    }
    return nil;
}

+ (void)check:(NSString *)appId
{
    if (!isValidString(appId)) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSDictionary *result = [self getURL:[CheckAppVersionURL stringByAppendingString:appId]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"JSON: %@", result);
            if (isValidDictionary(result)) {
                NSArray *array=[result objectForKey:@"results"];
                if (isValidArray(array)&&[array count]>0) {
                    NSDictionary *dic=[array objectAtIndex:0];
                    if (isValidDictionary(dic)) {
                        NSString *version=[dic objectForKey:@"version"];
                        if (isValidString(version)) {
                            NSString *description=[dic objectForKey:@"releaseNotes"];
                            float versionFloat=[version floatValue];
                            float currentVersionFloat=[kAppVersion floatValue];
                            if (versionFloat>currentVersionFloat) {
                                NSString *title = [NSString stringWithFormat:@"检测到新版本%@",version];
                                [UIAlertView showAlertViewWithTitle:title
                                                            message:FormatString(description,@"")
                                                  cancelButtonTitle:VString(@"取消")
                                                  otherButtonTitles:@[VString(@"立即更新")]
                                                          onDismiss:^(NSInteger buttonIndex) {
                                                              NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appId];
                                                              [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                                                          } onCancel:^{
                                                              
                                                          }];
                                
                            }
                        }
                    }
                }
            }
        });
    });
}

@end
