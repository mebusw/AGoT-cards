//
//  CharacterCardViewController.m
//  agot-ios
//
//  Created by mebusw on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CharacterCardViewController.h"

@implementation CharacterCardViewController
@synthesize lblStrength;
@synthesize imgInt, imgMil, imgPow;

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

-(void) toogleChanllengeIcons {
    imgInt.hidden = YES;
    imgMil.hidden = YES;
    imgPow.hidden = YES;

    NSArray *challengesStrings = [self.card.challenge componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，"]];
    for (NSString *c in challengesStrings) {
        if ([c isEqualToString:MILITARY]) {
            imgMil.hidden = NO;
        } else if ([c isEqualToString:INTELIGENCE]) {
            imgInt.hidden = NO;
        } else if ([c isEqualToString:POWER]) {
            imgPow.hidden = NO;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self toogleChanllengeIcons];
    lblStrength.text = self.card.strength;

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
