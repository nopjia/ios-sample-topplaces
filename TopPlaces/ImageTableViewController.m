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
        [_images release];  // release old one
        _images = [images retain];  // retain new one
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
        self.images = [[recents reverseObjectEnumerator] allObjects]; // copy the reverse
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
    // get cell
    static NSString *CellIdentifier = @"Image Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // configure the cell...
    NSDictionary *current = self.images[indexPath.row];
    cell.textLabel.text = [current objectForKey:FLICKR_PHOTO_TITLE];
    if (cell.textLabel.text.length <= 0) {
        cell.textLabel.text = @"Unknown";
    }
    cell.detailTextLabel.text = [current valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if (cell.detailTextLabel.text.length <= 0) {
        cell.detailTextLabel.text = [current objectForKey:FLICKR_PHOTO_OWNER];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *selected = self.images[indexPath.row];
    
    // save to user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *loadedrecents = [defaults objectForKey:DEFAULTS_RECENT_PHOTOS];
    NSMutableArray *recents;
    
    // does default key exist?
    if (loadedrecents) {
        recents = [NSMutableArray arrayWithArray:loadedrecents];
    } else {
        recents = [[[NSMutableArray alloc] init] autorelease];
    }
    
    // unique?
    if (![recents containsObject:selected]) {
        [recents addObject:selected];
        [defaults setObject:recents forKey:DEFAULTS_RECENT_PHOTOS];
    }
    
    // setup view
    ImageScrollViewController *vc = [[[ImageScrollViewController alloc] init] autorelease];
    [vc setTitle:[selected objectForKey:FLICKR_PHOTO_TITLE]];
    vc.imageUrl = [FlickrFetcher urlForPhoto:selected
                                      format:FlickrPhotoFormatLarge];
    
    // go to view
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc {
    [_images release], _images = nil;
    [super dealloc];
}

@end