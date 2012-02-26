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

@property (nonatomic, strong) IBOutlet UILabel *lblCardTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblCardRules;
@property (nonatomic, strong) IBOutlet UILabel *lblCardSet;


@end
