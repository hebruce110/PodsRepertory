//
//  VAppstoreComment.m
//  VAppstoreComment
//
//  Created by yuan on 14-7-2.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

/**********************************说 明**************************************
 在APP中提醒用户去给评价.规则如下:
 1. 弹框内容“支持一下xx吧~ 下次再说/赏个好评”
 2. App启动后，时间累计超过3分钟后，调用remind方法弹框提示
 4. 弹框出现次数：用户第一次弹框时，选择立即评价，则不再弹框；选择残忍拒绝，3天后再次弹框。每个版本弹框2次后，不论用户是否评价，都不在弹框
 *************************************************************************/

typedef enum {
    ShowAlertOK,            //已经评价过
    ShowAlertFirstTimes,    //提示了一次
    ShowAlertSecondTimes    //提示了两次
}ShowAlertTimes;

static NSString * const kAppFirstLaunchTime        = @"VAppstoreComment.appFirstLaunchTime";
static NSString * const kShowAlertTimes            = @"VAppstoreComment.showAlertTimes";
static NSString * const kAppId                     = @"VAppstoreComment.appId"; //appstore的id
static NSString * const kAppName                   = @"VAppstoreComment.appName"; //app的名称
static NSInteger  const kAccumulateIntervalSeconds  = 3*60;   //启动累积三分钟后提示
static NSInteger  const kAgainShowIntervalSeconds   = 3*86400; //三天后再次提示

#import "VAppstoreComment.h"

@implementation VAppstoreComment

+ (void)saveValue:(id)value key:(NSString *)_key
{
    NSAssert(_key!=nil,@"key could not equal to nil");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [_key stringByAppendingString:kAppVersion];
    [userDefaults setValue:value forKey:key];
    HYLog(@"key:%@ value:%@",key,value);
    [userDefaults synchronize];
}

+ (id)getValue:(NSString *)_key
{
    NSAssert(_key!=nil,@"key could not equal to nil");
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [_key stringByAppendingString:kAppVersion];
    return [userDefaults valueForKey:key];
}

//时间间隔
+ (NSTimeInterval )timeInterval
{
    NSTimeInterval nowTimeInterval = [[NSDate date]timeIntervalSince1970];
    NSNumber *appLauchTimeNumber = [self getValue:kAppFirstLaunchTime];
    if (!appLauchTimeNumber) {
        appLauchTimeNumber = @(nowTimeInterval);
    }
    NSTimeInterval appLauchTimeInterval = [appLauchTimeNumber doubleValue];
    NSTimeInterval result = nowTimeInterval - appLauchTimeInterval;
    return result;
}


//跳转到AppStore去评论，请用真机测试
+ (void)gotoAppstore
{
    NSString *appstoreId = [self getValue:kAppId];
    if (isValidString(appstoreId)) {
        NSString *str = SYSTEM_VERSION_LESS_THAN(@"7.0")?[NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appstoreId]:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appstoreId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

#pragma mark Public methords

//初始化App，开始计时
+ (void)initWithAppId:(NSString *)appstoreId
              appName:(NSString *)appName
{
    //存储appstore app的Id
    if (isValidString(appstoreId)) {
        [self saveValue:appstoreId key:kAppId];
    }
    
    //存储app的名称
    if (isValidString(appName)) {
        [self saveValue:appName key:kAppName];
    }
    
    //开始计时
    NSNumber *launchTime = [self getValue:kAppFirstLaunchTime];
    if (!launchTime) {
        NSTimeInterval nowTimeInterval = [[NSDate date]timeIntervalSince1970];
        [self saveValue:@(nowTimeInterval) key:kAppFirstLaunchTime];
    }
}

//提醒，在需要弹出提示的地方调用此方法
+ (void)remind
{
    NSNumber *alertTimesNumber = [self getValue:kShowAlertTimes];
    ShowAlertTimes alertTimes =alertTimesNumber?(ShowAlertTimes)[alertTimesNumber integerValue]:ShowAlertFirstTimes;
    if (alertTimes == ShowAlertOK) {//当前版本已经支持过，不再提示
        return;
    }else if(alertTimes == ShowAlertFirstTimes || alertTimes == ShowAlertSecondTimes){
        NSTimeInterval timeInterval = [self timeInterval];
        NSTimeInterval offsetTime = alertTimes == ShowAlertFirstTimes?kAccumulateIntervalSeconds:kAgainShowIntervalSeconds;  //时间间隔
        if (timeInterval >= offsetTime){
            switch (alertTimes) {
                case ShowAlertFirstTimes:
                    [self saveValue:@(ShowAlertSecondTimes) key:kShowAlertTimes];
                    break;
                case ShowAlertSecondTimes:
                    [self saveValue:@(ShowAlertOK) key:kShowAlertTimes];
                    break;
                default:
                    break;
            }
            NSString *appName = [self getValue:kAppName];
            if (!isValidString(appName)) {
                appName = @"";
            }
            NSString *message = VString(@"衷心感谢亲的支持与鼓励，#厚着脸皮来向你求一个爱的好评，么么哒~~");
            message = [message stringByReplacingOccurrencesOfString:@"#" withString:appName];
            [UIAlertView showAlertViewWithTitle:VString(@"求一个爱的好评")
                                        message:message
                              cancelButtonTitle:NSLocalizedString(@"下次再说", nil)
                              otherButtonTitles:@[NSLocalizedString(@"赏个好评", nil)]
                                      onDismiss:^(NSInteger buttonIndex) {
                                          [self saveValue:@(ShowAlertOK) key:kShowAlertTimes]; //点支持了，就标记为ok
                                          [self gotoAppstore];
                                      } onCancel:^{
                                          [self saveValue:@([[NSDate date]timeIntervalSince1970]) key:kAppFirstLaunchTime]; //没有支持就更新一下lauchTime
                                      }];
        }
    }
}


@end
