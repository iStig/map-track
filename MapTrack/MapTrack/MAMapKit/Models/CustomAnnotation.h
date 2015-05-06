//
//  CustomAnnotatonDelegate.h
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface CustomAnnotation : NSObject <MAMapViewDelegate>

- (instancetype)initWithMembers:(NSArray *)members mapView:(MAMapView *)map;
@end
