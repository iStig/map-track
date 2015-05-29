//
//  ViewController.m
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "MembersViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "CustomAnnotation.h"
#import "RunMember.h"
@interface MembersViewController ()
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CustomAnnotation *customAnnotation;
@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *customData;
@end

@implementation MembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMapView];
    [self initMembers];
    [self setupCustomAnnotaion];
}

- (void)initMapView {
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    //要显示的位置经纬度
//    CLLocationCoordinate2D lc2d = CLLocationCoordinate2DMake(121.606209,31.212939);
//    //缩放比例
//    MACoordinateSpan span = MACoordinateSpanMake(1, 1);
//    //地图结构体
//    MACoordinateRegion region =  MACoordinateRegionMake(lc2d, span);
//    [self.mapView setRegion:region animated:YES];
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
