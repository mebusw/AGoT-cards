//
//  PlotCardViewController.h
//  agot-ios
//
//  Created by mebusw on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardViewController.h"
@interface PlotCardViewController : CardViewController

@property (nonatomic, strong) IBOutlet UILabel *lblGold;
@property (nonatomic, strong) IBOutlet UILabel *lblPrior;
@property (nonatomic, strong) IBOutlet UILabel *lblEfficacy;

@end
