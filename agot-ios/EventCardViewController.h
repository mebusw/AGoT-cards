//
//  EventCardViewController.h
//  agot-ios
//
//  Created by mebusw on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardBrief.h"

@interface EventCardViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *lblCardTitle;
@property (nonatomic, strong) IBOutlet UILabel *lblCardSet;
@property (nonatomic, strong) IBOutlet UILabel *lblCardType;

@property (nonatomic, strong) CardBrief *card;

@end
