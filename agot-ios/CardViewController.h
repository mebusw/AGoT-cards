//
//  CardViewController.h
//  agot-ios
//
//  Created by mebusw on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardBrief.h"

@interface CardViewController : UIViewController

@property (nonatomic, strong) CardBrief *card;

@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblTraits;
@property (nonatomic, strong) IBOutlet UILabel *lblCost;
@property (nonatomic, strong) IBOutlet UIWebView *wvRules;
@property (nonatomic, strong) IBOutlet UIImageView *imgCrest;
@property (nonatomic, strong) IBOutlet UILabel *lblInfuluence;
@property (nonatomic, strong) IBOutlet UILabel *lblIncome;
@property (nonatomic, strong) IBOutlet UILabel *lblInitiative;

@end
