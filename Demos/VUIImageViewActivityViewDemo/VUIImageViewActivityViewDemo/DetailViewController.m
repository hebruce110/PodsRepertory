//
//  DetailViewController.m
//  VUIImageViewActivityViewDemo
//
//  Created by Bruce He on 15/6/27.
//  Copyright (c) 2015年 heyuan110.com. All rights reserved.
//

#import "DetailViewController.h"
#import "VUIImageView+ActivityView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //defulat is custom
//    [_detailImageView setActivityViewType:VActivityViewTypeWhite];
    [_detailImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic.nipic.com/2007-11-09/2007119121849495_2.jpg"] animated:YES];
    
    //set type is custom
    [_detailImageView2 setLoadingViewCategory:VLoadingViewCategorySystem];
//    [_detailImageView2 setActivityViewType:VActivityViewTypeGray];
    [_detailImageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic1.nipic.com/2008-09-08/200898163242920_2.jpg"] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
