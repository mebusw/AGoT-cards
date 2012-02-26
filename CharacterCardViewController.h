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
@property (nonatomic, strong) IBOutlet UILabel *lblCardSet;
@property (nonatomic, strong) IBOutlet UILabel *lblCardRules;
@property (nonatomic, strong) IBOutlet UILabel *lblGold;
@property (nonatomic, strong) IBOutlet UILabel *lblCardStr;
@property (nonatomic, strong) IBOutlet UILabel *lblCardFamily;
@property (nonatomic, strong) IBOutlet UIImageView *imgMil;
@property (nonatomic, strong) IBOutlet UIImageView *imgPow;
@property (nonatomic, strong) IBOutlet UIImageView *imgInt;
@property (nonatomic, strong) IBOutlet UIImageView *imgFamily;
@property (nonatomic, strong) IBOutlet UIImageView *imgIcon;



@property (nonatomic, strong) CardBrief *card;


@end
