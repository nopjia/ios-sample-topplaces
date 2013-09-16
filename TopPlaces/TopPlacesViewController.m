//
//  TopPlacesViewController.m
//  TopPlaces
//
//  Created by Nop Jiarathanakul on 9/16/13.
//  Copyright (c) 2013 Prutsdom Jiarathanakul. All rights reserved.
//

#import "TopPlacesViewController.h"
#import "FlickrFetcher.h"

@interface TopPlacesViewController ()

@end

@implementation TopPlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [FlickrFetcher topPlaces]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
