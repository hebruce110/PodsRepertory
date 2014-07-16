//
//  VGPS.h
//  VGPS
//
//  Created by Yuan on 14-6-16.
//  Copyright (c) 2014年 fullteem.com. All rights reserved.
//

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