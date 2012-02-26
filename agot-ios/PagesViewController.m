//
//  PagesViewController.m
//  agot-ios
//
//  Created by mebusw on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PagesViewController.h"
#import "CharacterCardViewController.h"
#import "EventCardViewController.h"
#import "CardBrief.h"
#import "AGoTCard.h"
#import "dictKeys.h"

enum {
    kEventCard = 1,
    kCharacterCard = 4,
    kAgenda,
    kAttachment,
    kLocation,
    kPlot
    };

@implementation PagesViewController
@synthesize cards, cursor;



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

-(UIViewController*) buildACardView  {
    CardBrief *card = [cards objectAtIndex:cursor];
    UIViewController *viewCtrl;
    if ([card.type isEqualToString:EVENT_CARD]) {
        EventCardViewController *v = [[EventCardViewController alloc] init];
        v.card = card;
        viewCtrl = v;
    } else if ([card.type isEqualToString:CHARACTER_CARD]) {
        CharacterCardViewController *v = [[CharacterCardViewController alloc] init];
        v.card = card;
        viewCtrl = v;
    }
    return viewCtrl;    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"");
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"Pages";
    self.delegate = (id)self;
    self.dataSource = (id)self;

    UIViewController *startCtrl = [self buildACardView];
    
    [self setViewControllers:[NSArray arrayWithObject:startCtrl] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];

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

#pragma mark -  page view delegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {  

    NSLog(@"%d", cursor);
    if (cursor <= 0) {
        return nil;
    } else {
        cursor--;
        return [self buildACardView];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    NSLog(@"%d", cursor);
    if (cursor >= [cards count]) {
        return nil;
    } else {
        cursor++;
        return [self buildACardView];
    }

}
                                                                                                                                                

@end
