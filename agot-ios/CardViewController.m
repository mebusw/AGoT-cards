//
//  CardViewController.m
//  agot-ios
//
//  Created by mebusw on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CardViewController.h"

@implementation CardViewController
@synthesize card;
@synthesize lblCost, lblTitle, lblTraits, wvRules, imgCrest, lblIncome, lblInfuluence, lblInitiative;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


-(NSString*) formatRules:(NSString*) ruleText {
    return STR(@"<p style='font-family:\"TimesGoT\"'>%@ ^@&</p>", ruleText);
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", self.card.title);
    lblTitle.text = card.title;
    lblTraits.text = card.traits;
    lblCost.text = card.cost;
    [self.wvRules loadHTMLString:[self formatRules:card.rules] baseURL:nil];
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

@end