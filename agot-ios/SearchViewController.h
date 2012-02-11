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

@property (strong, nonatomic) IBOutlet UISwitch *isWithName;
@property (strong, nonatomic) IBOutlet UISwitch *isWithProperty;
@property (strong, nonatomic) IBOutlet UISwitch *isWithText;
@property (strong, nonatomic) IBOutlet UISwitch *isWithInt;
@property (strong, nonatomic) IBOutlet UISwitch *isWithMil;
@property (strong, nonatomic) IBOutlet UISwitch *isWithPow;

@property (strong, nonatomic) IBOutlet UIButton *btnSet;
@property (strong, nonatomic) IBOutlet UIButton *btnCrest;
@property (strong, nonatomic) IBOutlet UIButton *btnType;



-(IBAction) tapPicker:(UIButton*)button;



@end
