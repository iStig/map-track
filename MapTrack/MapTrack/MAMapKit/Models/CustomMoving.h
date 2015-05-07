//
//  SMLocationManager.h
//  MapTrack
//
//  Created by iStig on 15/5/7.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface CustomMoving : NSObject
@property (nonatomic, strong) MAMapView *mapView;
+ (instancetype)checkLocationAvailable;
@end
