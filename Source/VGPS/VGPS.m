//
//  GPS.m
//  DXQ
//
//  Created by Yuan on 12-11-8.
//  Copyright (c) 2012年 http://www.heyuan110.com. All rights reserved.
//

#import "VGPS.h"
#import "VExtensions.h"

#define DEFAULT_DISTANCE_FILTER 1000.0f

@implementation VGPS
@synthesize currentLocation;
@synthesize isLocationing;

SINGLETON_GCD(VGPS)

-(id)init
{
    self =[super init];
    if (!self)
    {
        currentLocation.lat = 0.0;
        currentLocation.lng = 0.0;
    }
    return self;
}

//get location
-(NSString *)getLocation:(GPSLocation)locationType
{
    NSString* location = @"0.0";
    switch (locationType)
    {
        case GPSLocationLatitude:
            location = [NSString stringWithFormat:@"%f", currentLocation.lat];
            break;
        case GPSLocationLongitude:
            location = [NSString stringWithFormat:@"%f", currentLocation.lng];
            break;
        default:
            break;
    }
    return location;
}

-(NSString*)getDistanceFromLat:(NSNumber *)lat Lon:(NSNumber *)lon
{
    NSString *me_latString =   [[VGPS sharedVGPS]getLocation:GPSLocationLatitude];
    NSString *me_lonString =   [[VGPS sharedVGPS]getLocation:GPSLocationLongitude];
    
    CGFloat me_lat = me_latString!=nil?[me_latString floatValue]:0.0f;
    CGFloat me_lon = me_lonString!=nil?[me_lonString floatValue]:0.0f;
    CGFloat user_lat = lat!=nil?[lat floatValue]:0.0f;
    CGFloat user_lon = lon!=nil?[lon floatValue]:0.0f;
    
    BOOL isLocationRecord = YES;
    NSString *distanceString = @"";
    if (me_lat== me_lon && me_lon == 0.0)isLocationRecord = NO;
    if (user_lat== user_lon && user_lon == 0.0)isLocationRecord = NO;
    if (isLocationRecord)
    {
        CGFloat  dis = [self getDistanceFromPoint:CLLocationCoordinate2DMake(me_lat,me_lon) toPoint:CLLocationCoordinate2DMake(user_lat, user_lon)];
        if (dis > 1000)
        {
            distanceString = [NSString stringWithFormat:@"%.1f%@",dis/1000,VString(@"千米")];
        }
        else if (dis > 50)
        {
            distanceString = [NSString stringWithFormat:@"%.1f%@",dis,VString(@"米")];
        }
        else if (dis > 20)
        {
            distanceString = [NSString stringWithFormat:@"%@50%@",VString(@"小于"),VString(@"米")];
        }
        else
        {
            distanceString = [NSString stringWithFormat:@"%@20%@",VString(@"小于"),VString(@"米")];
        }
    }
    else
    {
        distanceString = VString(@"未知");
    }
    return distanceString;
}


-(CGFloat)getDistanceFromPoint:(CLLocationCoordinate2D)startpoint toPoint:(CLLocationCoordinate2D)endpoint
{
    CLLocation *startLocation = [[CLLocation alloc]initWithLatitude:startpoint.latitude longitude:startpoint.longitude];
    
    CLLocation *endLocation = [[CLLocation alloc]initWithLatitude:endpoint.latitude longitude:endpoint.longitude];
    
    CGFloat distance = [startLocation distanceFromLocation:endLocation];
    
    return distance;
}

//location Services turn on/off
- (BOOL)islocationServicesEnabled
{
    if ([CLLocationManager locationServicesEnabled]
        && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)
        return YES;
    
    //    [self showRefuseLoctionAlert:PCString(@"定位被拒绝")];
    
    return NO;
}

//打开系统的map显示路线
-(void)openSystemMapWithLat:(NSString *)latString longitude:(NSString *)lngString name:(NSString *)name
{
    if (SYSTEM_VERSION_LESS_THAN(@"6.0"))
    {
        //6.0以下，调用googleMap
        NSString *meLat = [self getLocation:GPSLocationLatitude];
        NSString *meLng = [self getLocation:GPSLocationLongitude];
        NSString * loadString=[NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%@,%@&daddr=%@,%@",latString,lngString,meLat,meLng];
        HYLog(@"%@",loadString);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:loadString]];
    }
    else
    {
        CLLocationCoordinate2D to;
        //要去的目标经纬度
        to.latitude = [latString floatValue];
        to.longitude = [lngString floatValue];
        MKMapItem *cLocation = [MKMapItem mapItemForCurrentLocation];//调用自带地图（定位）
        //显示目的地坐标。画路线
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
        toLocation.name = name;
        [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:cLocation, toLocation, nil]
                       launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                      
                                                                 forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
        
    }
}


-(void)showRefuseLoctionAlert:(NSString *)errorMsg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:VString(@"定位提示") message:errorMsg delegate:nil cancelButtonTitle:VString(@"确定") otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark -
#pragma mark Public Method

- (void)startUpdateLocation
{
    _locationSuccess = NO;
    isLocationing = YES;
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = DEFAULT_DISTANCE_FILTER;
    }
    [_locationManager startUpdatingLocation];
}

- (void)stopUpdateLocation
{
    HYLog(@"定位完成------!");
    if (_locationManager) {
        [_locationManager stopUpdatingLocation];
        _locationManager = nil;
    }
    isLocationing = NO;
}

#pragma mark - location Delegate
//当位置获取或更新失败会调用的方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorMsg = VString(@"获取位置信息失败");
    
    if ([error code] == kCLErrorDenied)
    {
        errorMsg = VString(@"定位被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown)
    {
        errorMsg = VString(@"获取位置信息失败");
    }
    _locationSuccess = NO;
    
    [self stopUpdateLocation];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if (!newLocation) {
        [self locationManager:manager didFailWithError:(NSError *)NULL];
        return;
    }
    
    if (signbit(newLocation.horizontalAccuracy)) {
		[self locationManager:manager didFailWithError:(NSError *)NULL];
		return;
	}
    
    _locationSuccess =  YES;
    
    currentLocation.lat = newLocation.coordinate.latitude;
    
    currentLocation.lng = newLocation.coordinate.longitude;
    
    [self stopUpdateLocation];
}


- (void)gotoLocationWithLan:(double)lat andLong:(double)lng mapView:(MKMapView *)mapView zoomlevel:(CGFloat)level
{
	// Override point for customization after app launch
	MKCoordinateRegion theRegion;
	CLLocationCoordinate2D theCenter;
	theCenter.latitude = lat;
	theCenter.longitude = lng;
	theRegion.center=theCenter;
	
	//set zoom level
	MKCoordinateSpan theSpan;
	theSpan.latitudeDelta = level;
	theSpan.longitudeDelta = level;
	theRegion.span = theSpan;
	
	//set map Region
	[mapView setRegion:theRegion animated:YES];
	[mapView regionThatFits:theRegion];
}

@end
