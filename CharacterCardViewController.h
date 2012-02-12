//
//  CharacterCardViewController.h
//  agot-ios
//
//  Created by mebusw on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardBrief.h"

@interface CharacterCardViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *lblCardTitle;
@property (nonatomic, strong) CardBrief *card;


@end
