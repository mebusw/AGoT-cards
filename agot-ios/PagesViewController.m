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
#import "AttachmentCardViewController.h"
#import "AgendaCardViewController.h"
#import "LocationCardViewController.h"
#import "PlotCardViewController.h"
#import "AGoTCard.h"
#import "dictKeys.h"
#import "CardImageViewController.h"

@implementation PagesViewController
@synthesize cards, startPageId;

NSArray *cardImages;
int cursor;

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

-(CardViewController*) buildACardViewForPageId:(int)pageId  {
    AGoTCard *card = [cards objectAtIndex:pageId];
    
    CardViewController *viewCtrl;
    
    if ([card.type_name isEqualToString:EVENT_CARD]) {
        EventCardViewController *v = [[EventCardViewController alloc] init];
        v.card = card;
        viewCtrl = v;
    } else if ([card.type_name isEqualToString:CHARACTER_CARD]) {
        CharacterCardViewController *v = [[CharacterCardViewController alloc] init];
        v.card = card;
        viewCtrl = v;
    } else if ([card.type_name isEqualToString:ATTACHMENT_CARD]) {
        AttachmentCardViewController *v = [[AttachmentCardViewController alloc] init];
        v.card = card;
        viewCtrl = v;
    } else if ([card.type_name isEqualToString:AGENDA_CARD]) {
        AgendaCardViewController *v = [[AgendaCardViewController alloc] init];
        v.card = card;
        viewCtrl = v;
    } else if ([card.type_name isEqualToString:LOCATION_CARD]) {
        LocationCardViewController *v = [[LocationCardViewController alloc] init];
        v.card = card;
        viewCtrl = v;
    } else if ([card.type_name isEqualToString:PLOT_CARD]) {
        PlotCardViewController *v = [[PlotCardViewController alloc] init];
        v.card = card;
        viewCtrl = v;
    }
    
    viewCtrl.pageId = pageId;

    return viewCtrl;    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"卡牌";
    self.delegate = (id)self;
    self.dataSource = (id)self;
    
    //TODO poc to use images for card details
    cardImages = [NSArray arrayWithObjects:@"cs/B73.jpg", @"cs/L55.jpg", @"cs/B146.jpg", nil];

    //CardViewController *startCtrl = [self buildACardViewForPageId:startPageId];
    cursor = 0;
    CardImageViewController *startCtrl = [[CardImageViewController alloc] init];
    startCtrl.imageName = [cardImages objectAtIndex:cursor];
    
    
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
    
    cursor = (cursor - 1 + [cardImages count]) % [cardImages count];
    CardImageViewController *vc = [[CardImageViewController alloc] init];
    vc.imageName = [cardImages objectAtIndex:cursor];

    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    cursor = (cursor + 1) % [cardImages count];
    CardImageViewController *vc = [[CardImageViewController alloc] init];
    vc.imageName = [cardImages objectAtIndex:cursor];
    return vc;
}
                                                                                                                                                

@end
