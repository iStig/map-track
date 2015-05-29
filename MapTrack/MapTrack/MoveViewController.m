//
//  MoveViewController.m
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "MoveViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "CustomMoving.h"

@interface MoveViewController()
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CustomMoving *locationManager;
@end
@implementation MoveViewController
- (void)initMapView {
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
}

- (void)viewDidLoad {
    [self initMapView];
    self.locationManager = [CustomMoving checkLocationAvailable];
    self.locationManager.mapView = self.mapView;
}


@end
