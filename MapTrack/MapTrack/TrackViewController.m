//
//  TrackViewController.m
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "TrackViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "Tracking.h"
#import "CustomTracking.h"
#import "SMLocationManager.h"

@interface TrackViewController()
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) Tracking *tracking;
@property (nonatomic, strong) CustomTracking *customTracking;
@end
@implementation TrackViewController


- (void)viewDidLoad {
    [self initMapView];
    [self setupNavigationBar];
    [[SMLocationManager smlocationManager] setUpdateLocation:nil];
    
}

- (void)handleRunAction
{
    if (self.tracking == nil)
    {
        [self setupTracking];
    }
    [self.tracking execute];
}

- (void)setupNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Run"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(handleRunAction)];
}
- (void)initMapView {
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
}

/* 构建轨迹回放. */
- (void)setupTracking
{
    NSString *trackingFilePath = [[NSBundle mainBundle] pathForResource:@"GuGong" ofType:@"tracking"];


    
    NSData *trackingData = [NSData dataWithContentsOfFile:trackingFilePath];
    
    /*分配CLLocationCoordinate2D类型的内存*/
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D *)malloc(trackingData.length);
    
    
//    float z;
//    [trackingData getBytes:&z length:sizeof(float)];
    
    /* 提取轨迹原始数据. 将trackingData拷贝到coordinates这个内存缓存区 */
    [trackingData getBytes:coordinates length:trackingData.length];
    
    /* 构建tracking. */
    self.tracking = [[Tracking alloc] initWithCoordinates:coordinates count:trackingData.length / sizeof(CLLocationCoordinate2D)];

    _customTracking = [[CustomTracking alloc] initWithMapView:self.mapView andTrack:self.tracking];
}




@end
