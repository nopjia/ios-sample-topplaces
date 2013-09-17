//
//  ImageTableViewController.m
//  TopPlaces
//
//  Created by Nop Jiarathanakul on 9/16/13.
//  Copyright (c) 2013 Prutsdom Jiarathanakul. All rights reserved.
//

#import "ImageTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageScrollViewController.h"

@interface ImageTableViewController()

@end

@implementation ImageTableViewController

@synthesize images = _images;

- (void)setImages:(NSArray *)images {
    if (_images != images) {
        _images = images; // need copy?
        [self.tableView reloadData];
    }
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define DEFAULTS_RECENT_PHOTOS @"TopPlaces.RecentPhotos"

- (void)loadRecents {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *recents = [defaults objectForKey:DEFAULTS_RECENT_PHOTOS];
    if (recents) {
        self.images = recents; // need copy?
        NSLog(@"%i Recent Photos loaded", recents.count);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Loaded \"%@\"", self.title);
}

- (void)viewWillAppear:(BOOL)animated {
    if ([self.title isEqual:@"Recents"]) {
        [self loadRecents];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Image Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.images[indexPath.row] objectForKey:FLICKR_PHOTO_TITLE];
    if (cell.textLabel.text.length <= 0) {
        cell.textLabel.text = @"Unknown";
    }
    cell.detailTextLabel.text = [self.images[indexPath.row] valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if (cell.detailTextLabel.text.length <= 0) {
        cell.detailTextLabel.text = [self.images[indexPath.row] objectForKey:FLICKR_PHOTO_OWNER];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // save to user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *loadedrecents = [defaults objectForKey:DEFAULTS_RECENT_PHOTOS];
    NSMutableArray *recents;
    if (loadedrecents) {
        recents = [NSMutableArray arrayWithArray:loadedrecents];
    } else {
        recents = [[NSMutableArray alloc] init];
    }
    [recents addObject:self.images[indexPath.row]];
    [defaults setObject:recents forKey:DEFAULTS_RECENT_PHOTOS];
    
    // setup view
    NSDictionary *selected = self.images[indexPath.row];
    ImageScrollViewController *vc = [[ImageScrollViewController alloc] init];
    [vc setTitle:[selected objectForKey:FLICKR_PHOTO_TITLE]];
    vc.imageUrl = [FlickrFetcher urlForPhoto:selected
                                      format:FlickrPhotoFormatLarge];
    
    // go to view
    [self.navigationController pushViewController:vc animated:YES];
}

@end
