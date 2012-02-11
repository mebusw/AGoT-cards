//
//  SearchViewController.m
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "TypeDao.h"
#import "AGoTType.h"
#import "HouseDao.h"
#import "AGoTHouse.h"
#import "CrestDao.h"
#import "AGotCrest.h"
#import "SetDao.h"
#import "AGoTSet.h"

@implementation SearchViewController

NSArray *types, *houses, *crests, *sets;

NSString *pickedType;
int selectedHouse = 0;
int selectedType = 0;

NSArray *houseImages;
UIPickerView *pickerV;

UIToolbar *toolbar;


@synthesize _searchBar, checkList;
@synthesize isWithName, isWithText, isWithProperty;
@synthesize btnType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"权力的游戏卡牌搜索";


    types = [[[TypeDao alloc] init] select];
    houses = [[[HouseDao alloc] init] select];
    crests = [[[CrestDao alloc] init] select];
    sets = [[[SetDao alloc] init] select];
    
    houseImages = [NSArray arrayWithObjects:@"stsm.png", @"lasm.png", @"basm.png", @"tasm.png", @"masm.png", @"gjsm.png", @"nesm.png", nil];

    
    _searchBar.showsCancelButton = YES;
    
    }

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - searchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"text=%@", searchBar.text);
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"");
    return [houses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    NSLog(@"");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    AGoTHouse *house = (AGoTHouse*)[houses objectAtIndex:indexPath.row];
    cell.textLabel.text = house.name;
    cell.selected = NO;
    UIImage *img = [UIImage imageNamed:[houseImages objectAtIndex:indexPath.row]];
    cell.imageView.image = img;
    
    if(indexPath.row == selectedHouse) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedHouse = indexPath.row;
    [tableView reloadData];


}

#pragma mark - events
-(IBAction) tapTypes {
    NSLog(@"");
    pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    pickerV.delegate = (id)self;
    pickerV.showsSelectionIndicator = YES;
    [self.view addSubview:pickerV];
    
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 160.0f, 320.0f, 40.0f)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTypes:)];
    
    NSArray *items = [NSArray arrayWithObject:item];
    toolbar.items = items;
    [self.view addSubview:toolbar];
}

-(void) doneTypes:(id)obj {
    [pickerV removeFromSuperview];
    [toolbar removeFromSuperview];
    
}

-(IBAction) tapNext {
    //[self.navigationController performSegueWithIdentifier:@"Result" sender:nil];
}

#pragma mark - Picker delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [types count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    AGoTType* type = (AGoTType*)[types objectAtIndex:row];
    return type.types;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    AGoTType* type = (AGoTType*)[types objectAtIndex:row];
    selectedType = row;


    btnType.titleLabel.text = type.types;
    [pickerV reloadAllComponents];
}


@end
