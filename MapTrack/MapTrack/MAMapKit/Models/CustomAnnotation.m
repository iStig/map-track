//
//  CustomAnnotatonDelegate.m
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "CustomAnnotation.h"
#import "CustomAnnotationView.h"
#import "RunMember.h"
#import "MAMemberAnnotation.h"
#define kCalloutViewMargin          -8

@interface CustomAnnotation ()
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *members;
@end
@implementation CustomAnnotation

- (id)init {
    return nil;
}

- (instancetype)initWithMembers:(NSArray *)members mapView:(MAMapView *)map{
    self = [super init];
    if (self) {
        _members = (NSMutableArray *)members;
        _mapView = map;
        _mapView.delegate = self;
//        _mapView.showsUserLocation = YES;
//        _mapView.userTrackingMode = 1;
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            _locationManager = [[CLLocationManager alloc] init];
            [_locationManager requestAlwaysAuthorization];
        }
        
        [self enumMembers];
    }
    return self;
}



#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    
    if ([annotation isKindOfClass:[MAMemberAnnotation class]])
    {
        MAMemberAnnotation *memberAnnotation = (MAMemberAnnotation *)annotation;
        
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        
        annotationView.portrait = [UIImage imageNamed:@"map_people"];
        annotationView.name     = memberAnnotation.member.name;
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - Action Handle

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    /* Adjust the map center in order to show the callout view completely. */
    if ([view isKindOfClass:[CustomAnnotationView class]]) {
        CustomAnnotationView *cusView = (CustomAnnotationView *)view;
        CGRect frame = [cusView convertRect:cusView.calloutView.frame toView:self.mapView];
        
        frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin, kCalloutViewMargin));
        
        if (!CGRectContainsRect(self.mapView.frame, frame))
        {
            /* Calculate the offset to make the callout view show up. */
            CGSize offset = [self offsetToContainRect:frame inRect:self.mapView.frame];
            
            CGPoint theCenter = self.mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            
            CLLocationCoordinate2D coordinate = [self.mapView convertPoint:theCenter toCoordinateFromView:self.mapView];
            
            [self.mapView setCenterCoordinate:coordinate animated:YES];
        }
        
    }
}

#pragma mark Private

- (void)enumMembers {
    for (RunMember *member in self.members) {
        [self addAnnotationWithCooordinate:member];
    }
}

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

-(void)addAnnotationWithCooordinate:(RunMember *)member
{
    MAMemberAnnotation *annotation = [[MAMemberAnnotation alloc] init];
    annotation.coordinate = member.coordinate;
    annotation.member = member;
    [self.mapView addAnnotation:annotation];
}

@end
