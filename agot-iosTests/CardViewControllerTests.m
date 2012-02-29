//
//  CardViewControllerTests.m
//  agot-ios
//
//  Created by mebusw on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CardViewControllerTests.h"

@implementation CardViewControllerTests

CardViewController *vc;

// All code under test must be linked into the Unit Test bundle
- (void)setUp
{
    [super setUp];
    vc = [[CardViewController alloc] init];
    vc.card = [[AGoTCard alloc] init]; 
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

-(void) testDrawHouseIconsOneHouse {
    vc.card.house = @"0";
    [vc drawHouseIcons];
    //TODO  kiwi is Mock class for iOS
}

@end
