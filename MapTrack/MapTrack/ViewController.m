//
//  ViewController.m
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "CustomAnnotation.h"
#import "RunMember.h"
@interface ViewController ()
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CustomAnnotation *customAnnotation;
@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMapView];
    [self initMembers];
    [self setupCustomAnnotaion];
}

- (void)initMapView {
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mapView];
}

- (void)initMembers {
    self.members = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < 5; i ++) {
        CLLocationCoordinate2D randomCoordinate = [self.mapView convertPoint:[self randomPoint] toCoordinateFromView:self.view];
        RunMember *member = [RunMember new];
        member.coordinate = randomCoordinate;
        member.name = [NSString stringWithFormat:@"user%lu",(unsigned long)i];
        member.type = i == 0 ? UserType_Self:UserType_Others;
        [self.members addObject:member];
    }
}

- (void)setupCustomAnnotaion {
    self.customAnnotation = [[CustomAnnotation alloc] initWithMembers:self.members mapView:self.mapView];
    
//    NSDate *scheduledTime = [NSDate dateWithTimeIntervalSinceNow:2.0];
//
//   self.timer = [[NSTimer alloc] initWithFireDate:scheduledTime
//                                              interval:2
//                                                target:self
//                                              selector:@selector(refreshMembers)
//                                              userInfo:nil
//                                               repeats:YES];
    
    
    // initialize the timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(refreshMembers) userInfo:nil repeats:YES];
}

- (void)refreshMembers {
    [self.members removeAllObjects];
    
    for (NSUInteger i = 0; i < 5; i ++) {
        CLLocationCoordinate2D randomCoordinate = [self.mapView convertPoint:[self randomPoint] toCoordinateFromView:self.view];
        RunMember *member = [RunMember new];
        member.coordinate = randomCoordinate;
        member.name = [NSString stringWithFormat:@"user%lu",(unsigned long)i];
        member.type = i == 0 ? UserType_Self:UserType_Others;
        [self.members addObject:member];
    }
    
    [self.customAnnotation refreshData:self.members];
}

- (CGPoint)randomPoint {
    CGPoint randomPoint = CGPointZero;
    randomPoint.x = arc4random() % (int)(CGRectGetWidth(self.view.bounds));
    randomPoint.y = arc4random() % (int)(CGRectGetHeight(self.view.bounds));
    return randomPoint;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
