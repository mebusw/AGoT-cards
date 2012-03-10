//
//  PagesViewController.h
//  agot-ios
//
//  Created by mebusw on 12-2-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface PagesViewController : UIPageViewController

@property (nonatomic, strong) NSArray *cards;
@property (nonatomic) int startPageId;


@end

