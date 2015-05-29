//
//  RootViewController.m
//  MapTrack
//
//  Created by iStig on 15/5/6.
//  Copyright (c) 2015年 iStig. All rights reserved.
//

#import "RootViewController.h"
#import "MembersViewController.h"
#import "MoveViewController.h"
#import "TrackViewController.h"
#import "ColorTrackingViewController.h"
@interface RootViewController ()
- (IBAction)memebers:(id)sender;
- (IBAction)TrackingAnimation:(id)sender;
- (IBAction)moveTracking:(id)sender;

@end
@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)memebers:(id)sender
{
    MembersViewController *v = [[MembersViewController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
}

- (IBAction)TrackingAnimation:(id)sender
{
    TrackViewController *v = [[TrackViewController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
}

- (IBAction)moveTracking:(id)sender
{
    MoveViewController *v = [[MoveViewController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
}

- (IBAction)colorTracking:(id)sender {
    ColorTrackingViewController *v = [[ColorTrackingViewController alloc] init];
    [self.navigationController pushViewController:v animated:YES];
}

@end
