//
//  ImageScrollViewController.m
//  TopPlaces
//
//  Created by Nop Jiarathanakul on 9/16/13.
//  Copyright (c) 2013 Prutsdom Jiarathanakul. All rights reserved.
//

#import "ImageScrollViewController.h"

@interface ImageScrollViewController() <UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation ImageScrollViewController

@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;
@synthesize imageUrl = _imageUrl;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageUrl]];
    self.imageView = [[[UIImageView alloc] init] autorelease];
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [self.imageView setImage:image];
    
    self.scrollView = [[[UIScrollView alloc] init] autorelease];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView.image.size;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 4.0;
    [self.scrollView setBackgroundColor:[UIColor blackColor]];  // set to activate whole area
    
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // set size to final frame size
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.scrollView zoomToRect:self.imageView.frame animated:NO];
}

- (void)dealloc {
    [_imageView release], _imageView = nil;
    [_scrollView release], _scrollView = nil;
    [_imageUrl release], _imageUrl = nil;
    [super dealloc];
}

@end