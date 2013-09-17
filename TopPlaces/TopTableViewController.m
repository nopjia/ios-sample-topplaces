//
//  TopTableViewController.m
//  TopPlaces
//
//  Created by Nop Jiarathanakul on 9/16/13.
//  Copyright (c) 2013 Prutsdom Jiarathanakul. All rights reserved.
//

#import "TopTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageTableViewController.h"

@interface TopTableViewController()
@property (nonatomic, strong) NSArray *topPlaces;
@property (nonatomic) int selectedRow;
@end

@implementation TopTableViewController

@synthesize topPlaces = _topPlaces;

- (NSArray *) topPlaces {
    if (!_topPlaces) {
        _topPlaces = [[FlickrFetcher topPlaces] copy];
        NSLog(@"%@", _topPlaces);
        NSLog(@"%i Top Places loaded", _topPlaces.count);
    }
    return _topPlaces;
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
    self.title = @"Top Places";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topPlaces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Place Cell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *fullname = [self.topPlaces[indexPath.row] objectForKey:FLICKR_PLACE_NAME];
    NSRange range = [fullname rangeOfString:@","];
    NSString *title = [fullname substringToIndex:range.location];
    NSString *subtitle = [fullname substringFromIndex:range.location+2];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subtitle;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *fullname = [self.topPlaces[indexPath.row] objectForKey:FLICKR_PLACE_NAME];
//    NSRange range = [fullname rangeOfString:@","];
//    NSString *title = [fullname substringToIndex:range.location];
    
//    ImageTableViewController *detailVC = [[ImageTableViewController alloc] init];
//    [detailVC setTitle:title];
//    [detailVC setImages: [FlickrFetcher photosInPlace:self.topPlaces[indexPath.row] maxResults:5]];

//    [self.navigationController pushViewController:detailVC animated:YES];

//    NSLog(@"go to %@", title);
    
    self.selectedRow = indexPath.row;
    
    [self performSegueWithIdentifier:@"Show Image Table" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show Image Table"]) {
        
        NSString *fullname = [self.topPlaces[self.selectedRow] objectForKey:FLICKR_PLACE_NAME];
        NSRange range = [fullname rangeOfString:@","];
        NSString *title = [fullname substringToIndex:range.location];
        
        [segue.destinationViewController setTitle:title];
        [segue.destinationViewController setImages:
         [FlickrFetcher photosInPlace:self.topPlaces[self.selectedRow] maxResults:20]];
    }
}

@end
