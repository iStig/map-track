//
//  CustomTracking.m
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "CustomTracking.h"

@interface CustomTracking()<MAMapViewDelegate,TrackingDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) Tracking *tracking;
@end
@implementation CustomTracking
- (instancetype)initWithMapView:(MAMapView *)map andTrack:(Tracking *)track{
    self = [super init];
    if (self) {
    
        _mapView = map;
        _mapView.delegate = self;
        
        //        _mapView.showsUserLocation = YES;
        //        _mapView.userTrackingMode = 1;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            _locationManager = [[CLLocationManager alloc] init];
            [_locationManager requestAlwaysAuthorization];
        }
        
        _tracking = track;
        _tracking.delegate = self;
        _tracking.mapView  = _mapView;
        _tracking.duration = 5.f;
        _tracking.edgeInsets = UIEdgeInsetsMake(50, 50, 50, 50);
 
    }
    return self;

}

#pragma mark - TrackingDelegate

- (void)willBeginTracking:(Tracking *)tracking
{
    NSLog(@"%s", __func__);
}

- (void)didEndTracking:(Tracking *)tracking
{
    NSLog(@"%s", __func__);
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if (annotation == self.tracking.annotation)
    {
        static NSString *trackingReuseIndetifier = @"trackingReuseIndetifier";
        
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:trackingReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:trackingReuseIndetifier];
        }
        
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:@"ball"];
        
        return annotationView;
    }
    
    return nil;
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if (overlay == self.tracking.polyline)
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 4.f;
        polylineView.strokeColor = [UIColor redColor];
        
        return polylineView;
    }
    
    return nil;
}
@end
