//
//  SMLocationManager.h
//  MapTrack
//
//  Created by iStig on 15/5/29.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UpdateLocation)(void);

typedef NS_ENUM(NSInteger, AuthorizationType) {
    AuthorizationType_RequestAlways    = 0,
    AuthorizationType_RequestWhenInUse = 1,
};

@interface SMLocationManager : NSObject
/**
 *  authorizationType  default:AuthorizationType_RequestAlways
 */
@property (nonatomic, assign, readonly) AuthorizationType authorizationType;
@property (nonatomic, copy) UpdateLocation updateLocation;

+ (instancetype)smlocationManager;
@end
