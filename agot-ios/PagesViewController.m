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


@implementation PagesViewController
@synthesize cards, startPageId;

ADBannerView *adView;



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
-(void) addAdView {
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.delegate = (id)self;
    CGSize size = self.view.frame.size;
    adView.center = CGPointMake(size.width / 2, size.height);
    [self.view addSubview:adView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"卡牌";
    self.delegate = (id)self;
    self.dataSource = (id)self;

    CardViewController *startCtrl = [self buildACardViewForPageId:startPageId];
    
    [self setViewControllers:[NSArray arrayWithObject:startCtrl] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    [self addAdView];
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
    int pageId = ((CardViewController*)viewController).pageId;
    if (pageId <= 0) {
        return nil;
    } else {
        pageId--;
        return [self buildACardViewForPageId:pageId];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    int pageId = ((CardViewController*)viewController).pageId;
    if (pageId >= [cards count] - 1) {
        return nil;
    } else {
        pageId++;
        return [self buildACardViewForPageId:pageId];
    }

}
                                                                                                                                            
#pragma mark - AD Delegate Function

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
	NSLog(@"ad: bannerViewActionShouldBegin");

    
	return YES;
}

-(void) bannerViewActionDidFinish:(ADBannerView *)banner
{
	NSLog(@"ad: bannerViewActionDidFinish");

}

-(void) bannerViewDidLoadAd:(ADBannerView *)banner
{
	NSLog(@"ad: bannerViewDidLoadAd");
	
    [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
    // banner is invisible now and moved out of the screen on 50 px
    [UIView setAnimationDuration:1.0];
    CGSize size = self.view.frame.size;
    adView.center = CGPointMake(size.width / 2, size.height - 25);
    adView.hidden = NO;
    [UIView commitAnimations];

	
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
	NSLog(@"ad: bannerView error:%@", error);
	
    [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
    // banner is visible and we move it out of the screen, due to connection issue
    adView.hidden = YES;
    [UIView commitAnimations];
    
}


@end
