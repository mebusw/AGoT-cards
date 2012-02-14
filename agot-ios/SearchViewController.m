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
#import "CardDao.h"
#import "CardBrief.h"
#import "ResultViewController.h"
#import "dictKeys.h"

#define PICKER_COMPONENT    1
#define SELECTED_NONE   -1
enum {
    PICKER_SET = 0,
    PICKER_CREST = 1,
    PICKER_TYPE = 2
};

@implementation SearchViewController

NSMutableArray *types, *houses, *crests, *sets, *challenges;

int selectedSet = SELECTED_NONE;
int selectedCrest = SELECTED_NONE;
int selectedType = SELECTED_NONE;
BOOL multiHouseFlag;
int multiHouseId;
NSMutableSet *housesSelected;
NSMutableSet *challengeSelected;

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

    //TODO
    //NSDictionary *d = [NSDictionary dictionaryWithContentsOfFile:@"names.plist"];
    //NSLog(@"%@", d);
    
    houses = [[[HouseDao alloc] init] select];
    multiHouseId = [houses count];
    AGoTHouse *mh = [[AGoTHouse alloc] init];
    mh._id = multiHouseId;
    mh.name = @"仅多家族";
    [houses addObject:mh];
    
    types = [[[TypeDao alloc] init] select];
    crests = [[[CrestDao alloc] init] select];
    sets = [[[SetDao alloc] init] select];
    
    NSMutableSet *majorSets = [[NSMutableSet alloc] init];
    for (int i = 0; i < [sets count]; i++) {
        AGoTSet *aSet = [sets objectAtIndex:i];
        NSNumber *setNum = [NSNumber numberWithInt:aSet.setsId];
        if (aSet.expId > 0 && ![majorSets member:setNum]) {
            AGoTSet *aMajorSet = [[AGoTSet alloc] init];
            aMajorSet.setsId = aSet.setsId;
            aMajorSet.expId = 0;
            aMajorSet.setName = aSet.setName;
            aMajorSet.expName = nil;
            [sets insertObject:aMajorSet atIndex:i];
            i++;
            [majorSets addObject:setNum];
        }
    }
    
    
    houseImages = [NSArray arrayWithObjects:@"stsm.png", @"lasm.png", @"basm.png", @"tasm.png", @"masm.png", @"gjsm.png", @"nesm.png", @"unique13.png", nil];
    challenges = [NSArray arrayWithObjects:@"军事争夺", @"阴谋争夺", @"权力争夺", nil];
    
    
    housesSelected = [[NSMutableSet alloc] init];
    challengeSelected = [[NSMutableSet alloc] init];
    multiHouseFlag = NO;

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
   [self performSegueWithIdentifier:@"Results" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ResultViewController *dest = [segue destinationViewController];
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    
    [conditions setObject:[NSNumber numberWithBool:multiHouseFlag] forKey:MULTI_HOUSE_FLAG];

    [conditions setObject:housesSelected forKey:HOUSE_SELECTED];
    
    dest.allItems = [[[CardDao alloc] init] selectCardBrieves:conditions];
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
    
    cell.textLabel.text = ((AGoTHouse*)[houses objectAtIndex:indexPath.row]).name;
    cell.selected = NO;
    UIImage *img = [UIImage imageNamed:[houseImages objectAtIndex:indexPath.row]];
    cell.imageView.image = img;
    
    if (multiHouseId == indexPath.row) {
        cell.accessoryType = multiHouseFlag ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    } else {
        if ([housesSelected containsObject:[houses objectAtIndex:indexPath.row]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (multiHouseId == indexPath.row) {
        if (multiHouseFlag) {
            multiHouseFlag = NO;
        } else {
            multiHouseFlag = YES;
        }
    } else {
        if ([housesSelected containsObject:[houses objectAtIndex:indexPath.row]]) {
            [housesSelected removeObject:[houses objectAtIndex:indexPath.row]];
        } else {
            [housesSelected addObject:[houses objectAtIndex:indexPath.row]];
        }
    }
    
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];


}

#pragma mark - touch actions

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
        case PICKER_CREST: {
            AGotCrest *crest = (AGotCrest*)[crests objectAtIndex:row];
            title = crest.name;
            break;
        }
        case PICKER_TYPE: {
            AGoTType *type = (AGoTType*)[types objectAtIndex:row];
            title = type.name;
            break;
        }
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
            AGotCrest *crest = (AGotCrest*)[crests objectAtIndex:row];
            btnCrest.titleLabel.text = crest.name;
            break;
        }
        case PICKER_TYPE: {
            selectedType = row;
            AGoTType *type = (AGoTType*)[types objectAtIndex:row];
            btnType.titleLabel.text = type.name;
            break;
        }
        default:
            break;
    }
    
    [pickerV reloadComponent:component];
}


@end
