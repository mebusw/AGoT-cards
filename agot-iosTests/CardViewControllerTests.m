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

-(void) testReplaceMarksOfRuleWithSpecialIcon {
    STAssertEqualStr(@"更多的%[贵族]角色", [vc replaceMarksOfRuleWithSpecialIcon:@"更多的（hs)[贵族]角色"], @"");
    STAssertEqualStr(@"每名%角色", [vc replaceMarksOfRuleWithSpecialIcon:@"每名(hs)角色"], @"");
    STAssertEqualStr(@"下一张%或&角色", [vc replaceMarksOfRuleWithSpecialIcon:@"下一张(hs)或(hb)角色"], @"");
    STAssertEqualStr(@"一名\\、}、{或<角色", [vc replaceMarksOfRuleWithSpecialIcon:@"一名(ch)、(cl)、(cn)或(cw)角色"], @"");
    STAssertEqualStr(@"更多的%[贵族]角色", [vc replaceMarksOfRuleWithSpecialIcon:@"更多的（hs)[贵族]角色"], @"");
    //
}


@end
