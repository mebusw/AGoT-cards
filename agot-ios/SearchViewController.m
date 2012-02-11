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

#define PICKER_COMPONENT    1
#define SELECTED_NONE   -1
enum {
    PICKER_SET = 0,
    PICKER_CREST = 1,
    PICKER_TYPE = 2
};

@implementation SearchViewController

NSArray *types, *houses, *crests, *sets;

int selectedHouse = SELECTED_NONE;
int selectedSet = SELECTED_NONE;
int selectedCrest = SELECTED_NONE;
int selectedType = SELECTED_NONE;

NSArray *houseImages;
UIPickerView *pickerV;

UIToolbar *toolbar;


@synthesize _searchBar, checkList;
@synthesize isWithName, isWithText, isWithProperty;
@synthesize isWithInt, isWithMil, isWithPow;
@synthesize btnType, btnSet, btnCrest;

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

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    return YES; 
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [houses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
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
-(IBAction) tapPicker:(UIButton*)button {
    NSLog(@"%d", button.tag);
    pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
    pickerV.delegate = (id)self;
    pickerV.showsSelectionIndicator = YES;
    pickerV.tag = button.tag;
    //[pickerV selectRow:selectedType inComponent:PICKER_COMPONENT animated:NO];
    [self.view addSubview:pickerV];
    
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 160.0f, 320.0f, 40.0f)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPicker:)];
    
    NSArray *items = [NSArray arrayWithObject:item];
    toolbar.items = items;
    [self.view addSubview:toolbar];
}

-(void) dismissPicker:(id)obj {
    [pickerV removeFromSuperview];
    [toolbar removeFromSuperview];
    
}

-(IBAction) tapNext {
    //[self.navigationController performSegueWithIdentifier:@"Result" sender:nil];
}

#pragma mark - Picker delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return PICKER_COMPONENT;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    int count;
    switch (pickerView.tag) {
        case PICKER_SET:
            count = [sets count];
            break;
        case PICKER_CREST:
            count = [crests count];
            break;
        case PICKER_TYPE:
            count = [types count];
            break;
        default:
            count = 0;
            break;
    }
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    switch (pickerView.tag) {
        case PICKER_SET: {
            AGoTSet *set = (AGoTSet*)[sets objectAtIndex:row];
            title = [set composeNames];
            break;
        }
        case PICKER_CREST:
            title = ((AGotCrest*)[crests objectAtIndex:row]).crest;
            break;
        case PICKER_TYPE:
            title = ((AGoTType*)[types objectAtIndex:row]).types;
            break;
        default:
            break;
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    NSLog(@"%d", row);

    switch (pickerView.tag) {
        case PICKER_SET: {
            selectedSet = row;
            AGoTSet *set = (AGoTSet*)[sets objectAtIndex:row];
            btnSet.titleLabel.text = [set composeNames];
            break;
        }
        case PICKER_CREST: {
            selectedCrest = row;
            AGotCrest* crest = (AGotCrest*)[crests objectAtIndex:row];
            btnCrest.titleLabel.text = crest.crest;
            break;
        }
        case PICKER_TYPE: {
            selectedType = row;
            AGoTType* type = (AGoTType*)[types objectAtIndex:row];
            btnType.titleLabel.text = type.types;
            break;
        }
        default:
            break;
    }
    
    [pickerV reloadComponent:component];
}


@end
