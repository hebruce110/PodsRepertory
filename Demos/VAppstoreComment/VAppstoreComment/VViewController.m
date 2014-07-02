//
//  VViewController.m
//  VAppstoreComment
//
//  Created by yuan on 14-7-2.
//  Copyright (c) 2014年 www.heyuan110.com. All rights reserved.
//

#import "VViewController.h"
#import "VAppstoreComment.h"

@interface VViewController ()

@end

@implementation VViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //弹出提示
    [VAppstoreComment remind];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
