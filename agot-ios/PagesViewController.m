//
//  PagesViewController.m
//  agot-ios
//
//  Created by mebusw on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PagesViewController.h"
#import "AGoTCard.h"
#import "dictKeys.h"
#import "CardImageViewController.h"

@implementation PagesViewController
@synthesize cards, startPageId;


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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

-(NSString*) imageNameForPageId:(int)pageId {
    AGoTCard *card = (AGoTCard*)[cards objectAtIndex:pageId];
    NSString *imageName = [NSString stringWithFormat:@"images/%@/%@.jpg", card.sets_s, card.cardID];
    NSLog(@"%d | image=%@", pageId, imageName);
    return imageName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"卡牌";
    self.delegate = (id)self;
    self.dataSource = (id)self;
    
    CardImageViewController *startCtrl = [[CardImageViewController alloc] init];
    startCtrl.imageName = [self imageNameForPageId:startPageId];
    startCtrl.pageId = startPageId;
    
    UIBarButtonItem *copyrightBtn = [[UIBarButtonItem alloc] initWithTitle:@"关于我" style:UIBarButtonItemStyleBordered target:self action:@selector(showCopyright)];
    self.navigationItem.rightBarButtonItem = copyrightBtn;
    

    
    NSLog(@"%@%@ %@", copyrightBtn, self.navigationItem, self.navigationItem.backBarButtonItem);
    
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

#pragma mark - button delegate
- (void) showCopyright {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关于我" message:@"本软件系爱好者个人开发，如有反馈或意见请发邮件至unplugged_game@163.com\n\n所有卡牌内容版权属于游人码头®和Fantasy Flight Publishing®。\n更多相关游戏信息，请访问游人官方网站www.gameharbor.com.cn，以获得详实信息。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert show];
}

#pragma mark -  page view delegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    int pageId = ((CardImageViewController*)viewController).pageId;
    CardImageViewController *vc = nil;
    
    if (pageId > 0) {
        vc = [[CardImageViewController alloc] init];
        pageId -= 1;
        vc.imageName = [self imageNameForPageId:pageId];
        vc.pageId = pageId;
    }
    return vc;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    int pageId = ((CardImageViewController*)viewController).pageId;
    CardImageViewController *vc = nil;
    
    if (pageId < [cards count] - 1) {
        vc = [[CardImageViewController alloc] init];
        pageId += 1;
        vc.imageName = [self imageNameForPageId:pageId];
        vc.pageId = pageId;
    }
    return vc;
}
                                                                                                                                                

@end
