//
//  SearchViewController.h
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISearchBar *_searchBar;
@property (strong, nonatomic) IBOutlet UITableView *checkList;

@property (strong, nonatomic) IBOutlet UISwitch *isWithTitle;
@property (strong, nonatomic) IBOutlet UISwitch *isWithTraits;
@property (strong, nonatomic) IBOutlet UISwitch *isWithRules;
@property (strong, nonatomic) IBOutlet UISwitch *isWithInt;
@property (strong, nonatomic) IBOutlet UISwitch *isWithMil;
@property (strong, nonatomic) IBOutlet UISwitch *isWithPow;

@property (strong, nonatomic) IBOutlet UIButton *btnSet;
@property (strong, nonatomic) IBOutlet UIButton *btnCrest;
@property (strong, nonatomic) IBOutlet UIButton *btnType;

@property (strong, nonatomic) IBOutlet UIButton *btnMask;

-(IBAction) tapPicker:(UIButton*)button;
-(IBAction) tapSearchButton:(UIButton*)button;
-(IBAction) tapMask:(UIButton*)button;


@end
