//
//  SearchViewController.h
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

-(IBAction) tapTypes;
-(IBAction) tapNext;

@end
