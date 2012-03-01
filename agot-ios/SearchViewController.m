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
#import "ResultViewController.h"
#import "dictKeys.h"
#import "ConditionPickers.h"

#define PICKER_COMPONENT    1
#define SELECTED_NONE   -1
enum {
    PICKER_SET = 0,
    PICKER_CREST = 1,
    PICKER_TYPE = 2
};

@implementation SearchViewController

NSMutableArray *types, *houses, *crests, *sets, *challenges;

/** For search conditions */
NSMutableSet *housesSelected;
BOOL multiHouseFlag = NO;
AGoTSet *selectedSet;
AGotCrest *selectedCrest;
AGoTType *selectedType;
NSMutableSet *challengeSelected;
BOOL titleFlag = NO;
BOOL traitsFlag = NO;
BOOL rulesFlage = NO;
NSString *searchText;

NSArray *houseImages;
int multiHouseId;
UIToolbar *toolbar;
UIPickerView *pickerV;

@synthesize _searchBar, checkList;
@synthesize isWithRules, isWithTitle, isWithTraits;
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
    
    
    houseImages = [NSArray arrayWithObjects:ICON_STARK, ICON_BARATHEON, ICON_TARGRARYEN,  ICON_LANNISTER, ICON_MARTELL, ICON_GREYJOY, ICON_NEUTRAL, ICON_UNIQUE, nil];
    challenges = [NSArray arrayWithObjects:MILITARY, INTELIGENCE, POWER, nil];
    
    
    housesSelected = [[NSMutableSet alloc] init];
    challengeSelected = [[NSMutableSet alloc] init];
    multiHouseFlag = NO;
    
    _searchBar.text= @" ";
    selectedSet = [[AGoTSet alloc] init];
    selectedSet.setsId = 0;
    selectedCrest = [[AGotCrest alloc] init];
    selectedCrest._id = 0;
    selectedType = [[AGoTType alloc] init];
    selectedType._id = 0;

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
    searchText = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    [challengeSelected removeAllObjects];
    if ([isWithMil isOn]) {
        [challengeSelected addObject:MILITARY];
    }
    if ([isWithInt isOn]) {
        [challengeSelected addObject:INTELIGENCE];
    }
    if ([isWithPow isOn]) {
        [challengeSelected addObject:POWER];
    }
    
    [self performSegueWithIdentifier:@"Results" sender:self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ResultViewController *dest = [segue destinationViewController];
    NSMutableDictionary *conditions = [[NSMutableDictionary alloc] init];
    
    [conditions setObject:[NSNumber numberWithBool:multiHouseFlag] forKey:MULTI_HOUSE_FLAG];
    [conditions setObject:housesSelected forKey:HOUSE_SELECTED];
    
    [conditions setObject:[NSNumber numberWithBool:[isWithTitle isOn]] forKey:TITLE_FLAG];
    [conditions setObject:[NSNumber numberWithBool:[isWithTraits isOn]] forKey:TRAITS_FLAG];
    [conditions setObject:[NSNumber numberWithBool:[isWithRules isOn]] forKey:RULES_FLAG];
    [conditions setObject:searchText forKey:SEARCH_TEXT];
    
    [conditions setObject:challengeSelected forKey:CHALLENGES_SELECTED];
    [conditions setObject:selectedSet forKey:SET_SELECTED];
    [conditions setObject:selectedCrest forKey:CREST_SELECTED];
    [conditions setObject:selectedType forKey:TYPE_SELECTED];
    
    //dest.allItems = [[[CardDao alloc] init] selectCardBrieves:conditions];
    dest.allItems = [[[CardDao alloc] init] selectCards:conditions];
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

-(UIPickerView*) pickerFactory:(int)tag { 
    UIPickerView<ConditionPicker> *pv = nil;
    switch (tag) {
        case PICKER_SET: {
            pv = [[SetPicker alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
            pv.elements = sets;
            pv.button = btnSet;
            break;
        }
        case PICKER_CREST: {
            pv = [[CrestPicker alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
            pv.elements = crests;
            pv.button = btnCrest;
            break;
        }
        case PICKER_TYPE: {
            pv = [[TypePicker alloc] initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 216.0f)];
            pv.elements = types;
            pv.button = btnType;
            break;
        }
        default:
            break;
    }
    pv.tag = tag;
    pv.delegate = (id)self;
    pv.showsSelectionIndicator = YES;
    return pv;
}

-(IBAction) tapPicker:(UIButton*)button {
    pickerV = [self pickerFactory:button.tag];
    //[pickerV selectRow:selectedType inComponent:PICKER_COMPONENT animated:NO];
    [self.view addSubview:pickerV];
    
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 156.0f, 320.0f, 44.0f)];
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

    return [(UIPickerView<ConditionPicker>*)pickerView count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return [(UIPickerView<ConditionPicker>*)pickerView titleForIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    UIPickerView<ConditionPicker> *pv = (UIPickerView<ConditionPicker>*)pickerView;
    switch (pv.tag) {
        case PICKER_SET: {
            selectedSet = (AGoTSet*)[sets objectAtIndex:row];
            break;
        }
        case PICKER_CREST: {
            selectedCrest = (AGotCrest*)[crests objectAtIndex:row];
            break;
        }
        case PICKER_TYPE: {
            selectedType = (AGoTType*)[types objectAtIndex:row];
            break;
        }
        default:
            break;
    }
    
    pv.button.titleLabel.text = [pv titleForIndex:row];  
    [pv reloadComponent:component];
}


@end
