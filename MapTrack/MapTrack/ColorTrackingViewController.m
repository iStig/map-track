//
//  ColorTrackingViewController.m
//  MapTrack
//
//  Created by iStig on 15/5/28.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "ColorTrackingViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "GradientPolylineRenderer.h"
#import "GradientPolylineOverlay.h"

@interface ColorTrackingViewController ()
@property (nonatomic, strong) MAMapView *mapView;
@end

@implementation ColorTrackingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMapView];
}


- (void)initMapView {
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
