//
//  PagesViewController.m
//  agot-ios
//
//  Created by mebusw on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PagesViewController.h"
#import "Another.h"

@implementation PagesViewController

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"");
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"Pages";
    self.delegate = (id)self;
    self.dataSource = (id)self;

    UIViewController *startCtrl = [[UIViewController alloc] init];
    startCtrl.view.backgroundColor = [UIColor blueColor];
    
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

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSLog(@"");    
    if ([viewController.view.backgroundColor isEqual:[UIColor blackColor]]) {
        return nil;
    } 
    
    UIViewController *viewCtrl = [[UIViewController alloc] init];
    if ([viewController.view.backgroundColor isEqual:[UIColor blueColor]]) {
        viewCtrl.view.backgroundColor = [UIColor blackColor];
    } else {
        viewCtrl.view.backgroundColor = [UIColor blueColor];
    }
        return viewCtrl;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSLog(@"");
    if ([viewController.view.backgroundColor isEqual:[UIColor redColor]]) {
        return nil;
    } 
    
    UIViewController *viewCtrl = [[UIViewController alloc] init];
    if ([viewController.view.backgroundColor isEqual:[UIColor blueColor]]) {
        viewCtrl.view.backgroundColor = [UIColor redColor];
    } else {
        viewCtrl.view.backgroundColor = [UIColor blueColor];
    }
    
    
    return viewCtrl;
}
                                                                                                                                                

@end
