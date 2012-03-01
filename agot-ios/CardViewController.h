//
//  CardViewController.h
//  agot-ios
//
//  Created by mebusw on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGoTCard.h"

@interface CardViewController : UIViewController

@property (nonatomic, strong) AGoTCard *card;
@property (nonatomic) int pageId;


@property (nonatomic, strong) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblTraits;
@property (nonatomic, strong) IBOutlet UILabel *lblCost;
@property (nonatomic, strong) IBOutlet UIWebView *wvRules;
@property (nonatomic, strong) IBOutlet UIImageView *imgCrest;
@property (nonatomic, strong) IBOutlet UIImageView *imgCost;
@property (nonatomic, strong) IBOutlet UILabel *lblInfuluence;
@property (nonatomic, strong) IBOutlet UILabel *lblIncome;
@property (nonatomic, strong) IBOutlet UILabel *lblInitiative;
@property (nonatomic, strong) IBOutlet UIImageView *imgInfuluence;
@property (nonatomic, strong) IBOutlet UIImageView *imgIncome;
@property (nonatomic, strong) IBOutlet UIImageView *imgInitiative;

-(void) drawHouseIcons;
-(NSString*) replaceMarksOfRuleWithSpecialIcon:(NSString*)text;
@end
