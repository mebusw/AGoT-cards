//
//  CharacterCardViewController.h
//  agot-ios
//
//  Created by mebusw on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewController.h"

@interface CharacterCardViewController : CardViewController


@property (nonatomic, strong) IBOutlet UILabel *lblStrenth;
@property (nonatomic, strong) IBOutlet UIImageView *imgMil;
@property (nonatomic, strong) IBOutlet UIImageView *imgPow;
@property (nonatomic, strong) IBOutlet UIImageView *imgInt;




@end
