//
//  MoveViewController.m
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "MoveViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface MoveViewController()
@property (nonatomic, strong) MAMapView *mapView;
@end
@implementation MoveViewController
- (void)initMapView {
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
}

- (void)viewDidLoad {
    [self initMapView];
}
@end
