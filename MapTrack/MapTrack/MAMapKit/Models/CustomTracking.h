//
//  CustomTracking.h
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tracking.h"
#import <MAMapKit/MAMapKit.h>

@interface CustomTracking : NSObject
- (instancetype)initWithMapView:(MAMapView *)map andTrack:(Tracking *)track;
@end
