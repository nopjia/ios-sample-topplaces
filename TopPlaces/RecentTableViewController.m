//
//  TopTableViewController.m
//  TopPlaces
//
//  Created by Nop Jiarathanakul on 9/16/13.
//  Copyright (c) 2013 Prutsdom Jiarathanakul. All rights reserved.
//

#import "RecentTableViewController.h"
#import "FlickrFetcher.h"

@interface RecentTableViewController ()
@property (nonatomic, strong) NSArray *recentPhotos;
@end

@implementation RecentTableViewController

@synthesize recentPhotos = _recentPhotos;

- (NSArray *) recentPhotos {
    if (!_recentPhotos) {
        // load from user defaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *recents = [defaults objectForKey:@"RecentTableViewController.RecentPhotos"];
        
        if (!recents) {
            _recentPhotos = [[NSArray alloc] init];
        } else {
            _recentPhotos = recents;
            NSLog(@"%@", _recentPhotos);
        }
        NSLog(@"%i Recent Photos loaded", _recentPhotos.count);
    }
    return _recentPhotos;
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
    self.title = @"Recents";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recentPhotos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Image Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.recentPhotos[indexPath.row] objectForKey:FLICKR_PHOTO_TITLE];
    
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
