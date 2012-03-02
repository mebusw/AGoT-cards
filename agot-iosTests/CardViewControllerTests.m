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



-(void) testReplaceMarksOfRuleWithSpecialIcon {
    STAssertEqualStr(@"更多的%[贵族]角色", [vc replaceMarksOfRuleWithSpecialIcon:@"更多的（hs)[贵族]角色"], @"");
    STAssertEqualStr(@"每名~角色", [vc replaceMarksOfRuleWithSpecialIcon:@"每名(ht)角色"], @"");
    STAssertEqualStr(@"选择一名^角色", [vc replaceMarksOfRuleWithSpecialIcon:@"选择一名(hl)角色"], @"");
    STAssertEqualStr(@"独有_角色专用<br>", [vc replaceMarksOfRuleWithSpecialIcon:@"独有(hg)角色专用<br>"], @"");
    STAssertEqualStr(@">角色专用<br>如果你赢得一次所附属角色独自参与进攻的#争夺", [vc replaceMarksOfRuleWithSpecialIcon:@"(hm)角色专用<br>如果你赢得一次所附属角色独自参与进攻的(i)争夺"], @"");
    STAssertEqualStr(@"下一张%或&角色", [vc replaceMarksOfRuleWithSpecialIcon:@"下一张(hs)或(hb)角色"], @"");
    STAssertEqualStr(@"一名\\、}、{或<角色", [vc replaceMarksOfRuleWithSpecialIcon:@"一名(ch)、(cl)、(cn)或(cw)角色"], @"");
    STAssertEqualStr(@"一张|卡牌", [vc replaceMarksOfRuleWithSpecialIcon:@"一张(cs)卡牌"], @"");
    STAssertEqualStr(@"拥有@和#和$符号的角色", [vc replaceMarksOfRuleWithSpecialIcon:@"拥有(m)和(i)和(p)符号的角色"], @"");
}


@end
