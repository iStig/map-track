//
//  APIKeyConfig.m
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "APIKeyConfig.h"
#import <UIKit/UIKit.h>
#import "MAAPIconfig.h"
#import <MAMapKit/MAMapKit.h>
@implementation APIKeyConfig

+ (void)configureAPIKey {
    if ([APIKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
}

@end
