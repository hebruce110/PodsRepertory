//
//  VGPS.h
//  VGPS
//
//  Created by Yuan on 14-6-16.
//  Copyright (c) 2014年 fullteem.com. All rights reserved.
//
/***
 用XCode6编译的原来XCode 5.1.1写的程序时，CLLocationManager定位的代码以及MKmapView的showUserLocation失效。因为XCode6选用iOS8 SDK编译，需要调用CLLocationManage 的requestAlwaysAuthorization 方法。
 在定位的地方添加
 
 1.增加
 // 判斷是否 iOS 8
 if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
 [locationManager requestAlwaysAuthorization]; // 永久授权
 [locationManager requestWhenInUseAuthorization]; //使用中授权
 }

 2. 在 info.plist里加入：
 NSLocationWhenInUseDescription，允许在前台获取GPS的描述
 NSLocationAlwaysUsageDescription，允许在后台获取GPS的描述
 
 ***/

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

typedef enum
{
    GPSLocationLatitude,//维度
    GPSLocationLongitude//经度
}GPSLocation;

typedef struct
{
    float lat;
    float lng;
}Location;

@interface VGPS : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager* _locationManager;
    Location currentLocation;
    BOOL isLocationing;
}
@property(nonatomic)BOOL locationSuccess;
@property (nonatomic)BOOL isLocationing;
@property (nonatomic) Location currentLocation;

+ (VGPS *)sharedVGPS;

- (void)startUpdateLocation;

- (void)stopUpdateLocation;

- (BOOL)islocationServicesEnabled;

-(NSString *)getLocation:(GPSLocation)locationType;

-(NSString*)getDistanceFromLat:(NSNumber *)lat Lon:(NSNumber *)lon;

-(void)openSystemMapWithLat:(NSString *)latString longitude:(NSString *)lngString name:(NSString *)name;

- (void)gotoLocationWithLan:(double)lat
                    andLong:(double)lng
                    mapView:(MKMapView *)mapView
                  zoomlevel:(CGFloat)level;

@end