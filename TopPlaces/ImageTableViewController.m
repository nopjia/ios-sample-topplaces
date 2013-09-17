//
//  ImageTableViewController.m
//  TopPlaces
//
//  Created by Nop Jiarathanakul on 9/16/13.
//  Copyright (c) 2013 Prutsdom Jiarathanakul. All rights reserved.
//

#import "ImageTableViewController.h"
#import "FlickrFetcher.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Loaded \"%@\"", self.title);
    
    if ([self.title isEqual:@"Recents"]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *recents = [defaults objectForKey:@"TopPlacesViewController.Recents"];
        if (recents) {
            self.images = recents; // need copy?
            NSLog(@"%i Recent Photos loaded", recents.count);
        }
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.images[indexPath.row] objectForKey:FLICKR_PHOTO_TITLE];
    if (cell.textLabel.text.length <= 0) {
        cell.textLabel.text = @"Unknown";
    }
    cell.detailTextLabel.text = [self.images[indexPath.row] objectForKey:FLICKR_PHOTO_DESCRIPTION];
    if (cell.detailTextLabel.text.length <= 0) {
        cell.detailTextLabel.text = [self.images[indexPath.row] objectForKey:FLICKR_PHOTO_OWNER];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
