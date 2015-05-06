//
//  MAMemberAnnotation.h
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "RunMember.h"
@interface MAMemberAnnotation : MAPointAnnotation
@property (nonatomic, strong) RunMember *member;
@end
