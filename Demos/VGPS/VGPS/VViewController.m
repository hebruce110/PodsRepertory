//
//  VViewController.m
//  VGPS
//
//  Created by Yuan on 14-6-16.
//  Copyright (c) 2014年 fullteem.com. All rights reserved.
//

#import "VViewController.h"
#import "VGPS.h"

@interface VViewController ()

@end

@implementation VViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([VGPS sharedVGPS].locationSuccess) {
        
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
