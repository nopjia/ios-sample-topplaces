//
//  ImageScrollViewController.m
//  TopPlaces
//
//  Created by Nop Jiarathanakul on 9/16/13.
//  Copyright (c) 2013 Prutsdom Jiarathanakul. All rights reserved.
//

#import "ImageScrollViewController.h"

@interface ImageScrollViewController() <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ImageScrollViewController

@synthesize imageUrl = _imageUrl;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.delegate = self;
    
    UIImage *image = [UIImage imageWithData:
                      [NSData dataWithContentsOfURL:self.imageUrl]];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [self.imageView setImage:image];
    
    self.scrollView.contentSize = self.view.frame.size;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 4.0;
    
    // set appropriate zoom
    [self.scrollView zoomToRect:self.imageView.frame animated:NO];
    
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
}

@end