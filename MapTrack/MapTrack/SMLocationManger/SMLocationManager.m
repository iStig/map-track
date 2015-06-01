//
//  SMLocationManager.m
//  MapTrack
//
//  Created by iStig on 15/5/29.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "SMLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
@interface SMLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation SMLocationManager

#pragma mark Public
+ (instancetype)smlocationManager {
    static SMLocationManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[SMLocationManager alloc] init];
    });
    return shareInstance;
}

- (void)setUpdateLocation:(void (^)(void))updateLocation {
        _updateLocation = updateLocation;
}


#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if (_updateLocation)
        _updateLocation();
}

//这个方法有待考究
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined://还没有明确选择
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            break;
        case kCLAuthorizationStatusRestricted://app无权限
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
        case kCLAuthorizationStatusDenied://用户拒绝
            NSLog(@"kCLAuthorizationStatusDenied");
            break;
        case kCLAuthorizationStatusAuthorizedAlways://始终使用
            NSLog(@"kCLAuthorizationStatusAuthorizedAlways");
            [self startUpdatingLocation];
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse://该使用的时候使用
            NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
            [self startUpdatingLocation];
            break;
        default:
            break;
    }
}

#pragma mark Private
- (id)init {
    if (self = [super init]) {
        self.authorizationType  = AuthorizationType_RequestAlways;
    }
    return self;
}


- (void)locationAuthorization {
    //参考:  http://www.jianshu.com/p/60cdc55497e2
    //Privacy - Location Usage Description
    switch (_authorizationType) {
        case AuthorizationType_RequestAlways:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                // TODO: Remember to add the NSLocationAlwaysUsageDescription plist key
                [self.locationManager requestAlwaysAuthorization];
            }
            break;
        case AuthorizationType_RequestWhenInUse:
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                // TODO: Remember to add the NSLocationWhenInUseUsageDescription plist key
                [self.locationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

- (void)startUpdatingLocation {
    [self.locationManager startUpdatingLocation];
}

- (void)stopUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark Setter
- (void)setAuthorizationType:(AuthorizationType)authorizationType {
    _authorizationType = authorizationType;
    [self locationAuthorization];
}

#pragma mark Getter
- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

//- (void)requestAlwaysAuthorization
//{
//    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
//
//    // If the status is denied or only granted for when in use, display an alert
//    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
//        NSString *title;
//        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
//        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
//
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
//                                                            message:message
//                                                           delegate:self
//                                                  cancelButtonTitle:@"Cancel"
//                                                  otherButtonTitles:@"Settings", nil];
//        [alertView show];
//    }
//    // The user has not enabled any location services. Request background authorization.
//    else if (status == kCLAuthorizationStatusNotDetermined) {
//        [self.locationManager requestAlwaysAuthorization];
//    }
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1) {
//        // Send the user to the Settings for this app
//        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        [[UIApplication sharedApplication] openURL:settingsURL];
//    }
//}

@end
