//
//  RunMember.h
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
typedef NS_ENUM(NSInteger, UserType) {
    UserType_Self = 0,
    UserType_Others = 1,
};

@interface RunMember : NSObject
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) UserType type;
@property (nonatomic, strong) NSString *name;
@end
