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

#define PICKER_COMPONENT    1
#define SELECTED_NONE   -1
enum {
    PICKER_SET = 0,
    PICKER_CREST = 1,
    PICKER_TYPE = 2
};

@implementation SearchViewController

NSArray *types, *houses, *crests, *sets, *challenges;

int selectedSet = SELECTED_NONE;
int selectedCrest = SELECTED_NONE;
int selectedType = SELECTED_NONE;
BOOL multiHouseSelected;
NSMutableSet *houseSet;
NSMutableSet *challengeSet;

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

    houses = [NSArray arrayWithObjects:@"史塔克", @"兰尼斯特", @"拜拉席恩", @"坦格利安", @"马泰尔", @"葛雷乔伊", @"中立", @"仅多家族", nil];
    types = [NSArray arrayWithObjects:@"议政牌", @"战略牌", @"角色牌", @"地区牌", @"附属牌", @"事件牌", nil];
    crests = [NSArray arrayWithObjects:@"高贵", @"勇武", @"博学", @"崇圣", @"暗影", nil];
    sets = [[[SetDao alloc] init] select];
    
    
    houseImages = [NSArray arrayWithObjects:@"stsm.png", @"lasm.png", @"basm.png", @"tasm.png", @"masm.png", @"gjsm.png", @"nesm.png", @"unique13.png", nil];
    challenges = [NSArray arrayWithObjects:@"军事争夺", @"阴谋争夺", @"权力争夺", nil];
    
    
    houseSet = [[NSMutableSet alloc] init];
    challengeSet = [[NSMutableSet alloc] init];
    multiHouseSelected = NO;

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
    dest.allItems = [[[CardDao alloc] init] selectCardBrieves:nil];
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
    
    cell.textLabel.text = [houses objectAtIndex:indexPath.row];
    cell.selected = NO;
    UIImage *img = [UIImage imageNamed:[houseImages objectAtIndex:indexPath.row]];
    cell.imageView.image = img;
    
    if ([houseSet containsObject:[houses objectAtIndex:indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
         
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([houseSet containsObject:[houses objectAtIndex:indexPath.row]]) {
        [houseSet removeObject:[houses objectAtIndex:indexPath.row]];
    } else {
        [houseSet addObject:[houses objectAtIndex:indexPath.row]];
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
        case PICKER_CREST:
            title = [crests objectAtIndex:row];
            break;
        case PICKER_TYPE:
            title = [types objectAtIndex:row];
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
            btnCrest.titleLabel.text = [crests objectAtIndex:row];
            break;
        }
        case PICKER_TYPE: {
            selectedType = row;
            btnType.titleLabel.text = [types objectAtIndex:row];
            break;
        }
        default:
            break;
    }
    
    [pickerV reloadComponent:component];
}


@end
