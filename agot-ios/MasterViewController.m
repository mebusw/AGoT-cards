//
//  MasterViewController.m
//  agot-ios
//
//  Created by mebusw on 12-2-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "CardViewController.h"

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

#import "TypeDao.h"
#import "AGoTType.h"

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

@synthesize allItems, searchResult;
@synthesize searchBar, searchDisplayController;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
    //allItems = [NSArray arrayWithObjects:@"Tom", @"Bob", @"Alice" , nil];
    self.searchDisplayController.searchBar.showsScopeBar = YES;
    [self.searchDisplayController.searchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"All",@"Device",@"Desktop",@"Portable",nil]];

    ///////////
    TypeDao *dao = [[TypeDao alloc] init];
    allItems = [dao select];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        return [searchResult count];
    } else {
        return [allItems count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView]) {
        cell.textLabel.text = [searchResult objectAtIndex:indexPath.row];
    } else {
        NSLog(@"row=%d", indexPath.row);
        cell.textLabel.text = ((AGoTType*)[allItems objectAtIndex:indexPath.row]).types;

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CardViewController *cvc = [[CardViewController alloc] init];
    cvc.title = ((AGoTType*)[allItems objectAtIndex:indexPath.row]).types;
    [self.navigationController pushViewController:cvc animated:YES];
    
}


-(void) filterContentForSearchText:(NSString*) searchText scope:(NSString*) scope {
    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
    searchResult = [allItems filteredArrayUsingPredicate:p];
}



#pragma mark - UISearchDisplayController delegate

-(BOOL) searchDisplayController:(UISearchDisplayController*) controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSLog(@"%@", searchString);
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
     return YES;
}

-(BOOL) searchDisplayController:(UISearchDisplayController*) controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    NSLog(@"%d", searchOption);
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
