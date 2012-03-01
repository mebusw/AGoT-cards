//
//  PlotCardViewController.m
//  agot-ios
//
//  Created by mebusw on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlotCardViewController.h"

@implementation PlotCardViewController

@synthesize lblPrior, lblGold, lblEfficacy;

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

-(void) drawGPE {
    lblGold.text = self.card.golds;
    lblEfficacy.text = self.card.efficacy;
    lblPrior.text = self.card.prior;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self drawGPE];
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
