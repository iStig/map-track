//
//  SMLocationManager.m
//  MapTrack
//
//  Created by iStig on 15/5/7.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "CustomMoving.h"

@interface CustomMoving ()<CLLocationManagerDelegate, MAMapViewDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property float distance;
@property (nonatomic, strong) NSMutableArray *locations;
@end
@implementation CustomMoving
+ (instancetype)checkLocationAvailable {
    static CustomMoving *location;
    if (!location) {
        location = [[self class] new];
    }
    return location;
}

- (id)init {
    self = [super init];
    if (self) {
        _distance = 0;
        _locations = [NSMutableArray array];
    }
    return self;
}


- (void)setMapView:(MAMapView *)map {

    if (!_mapView) {
        _mapView = map;
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = 1;
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.activityType = CLActivityTypeFitness;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_locationManager requestAlwaysAuthorization];
            }
        }
          [self.locationManager startUpdatingLocation];
    }
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *newLocation in locations) {
        
        NSDate *eventDate = newLocation.timestamp;
        
        NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
        NSLog(@"%f_____%f",fabs(howRecent),newLocation.horizontalAccuracy);
        if (fabs(howRecent) < 10.0 && 8 < newLocation.horizontalAccuracy && newLocation.horizontalAccuracy < 100) {
            
            // update distance
            if (self.locations.count > 0) {
                self.distance += [newLocation distanceFromLocation:self.locations.lastObject];
                
                CLLocationCoordinate2D coords[2];
                coords[0] = ((CLLocation *)self.locations.lastObject).coordinate;
                coords[1] = newLocation.coordinate;
                
    
                MACoordinateRegion region =
                MACoordinateRegionMakeWithDistance(newLocation.coordinate, 0.01, 0.01);
                [self.mapView setRegion:region animated:YES];
                
                [self.mapView addOverlay:[MAPolyline polylineWithCoordinates:coords count:2]];
            }
            
            [self.locations addObject:newLocation];
        }
    }
}

//这个方法有待考究
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"kCLAuthorizationStatusAuthorizedAlways");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
            break;
        default:
            break;
    }
}

#pragma mark - MKMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id < MAOverlay >)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolyline *polyLine = (MAPolyline *)overlay;
        MAPolylineRenderer *aRenderer = [[MAPolylineRenderer alloc] initWithPolyline:polyLine];
        aRenderer.strokeColor = [UIColor blueColor];
        aRenderer.lineWidth = 3;
        return aRenderer;
    }
    
    return nil;
}



@end
