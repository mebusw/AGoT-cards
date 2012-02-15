//
//  CardDaoTests.m
//  agot-ios
//
//  Created by mebusw on 12-2-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CardDaoTests.h"
#import "CardDao.h"
#import "dictKeys.h"
#import "AGoTHouse.h"
#import "AGoTSet.h"
#import "AGotCrest.h"
#import "AGoTType.h"

@implementation CardDaoTests

CardDao *dao;
NSMutableDictionary *conditions;

// All code under test must be linked into the Unit Test bundle
- (void)setUp
{
    [super setUp];
    dao = [[CardDao alloc] init];
    conditions = [[NSMutableDictionary alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testMath
{
    STAssertTrue((1 + 1) == 2, @"Compiler isn't feeling well today :-(");
}

-(void) testBuildHouseWhereClauseWithNoHoused {
    [conditions setValue:nil forKey:HOUSE_SELECTED];
    [conditions setObject:[NSNumber numberWithBool:NO] forKey:MULTI_HOUSE_FLAG];
    
    NSString *result = [dao buildHouseWhereClause];
    
    NSString *expect = @"(1)"; 
    STAssertEqualStr(expect, result, @"");

}

-(void) testBuildHouseWhereClauseWithOneHouses {
    AGoTHouse *house1 = [[AGoTHouse alloc] init];
    house1._id = 1;
    house1.name = @"zerg";
   
    NSSet *houseSelected = [NSSet setWithObjects:house1,  nil];
    [conditions setValue:houseSelected forKey:HOUSE_SELECTED];
    [conditions setObject:[NSNumber numberWithBool:NO] forKey:MULTI_HOUSE_FLAG];
    dao._conditions = conditions;
    
    NSString *result = [dao buildHouseWhereClause];
    
    NSString *expect = @"(0 or house like '%1%')"; 
    STAssertEqualStr(expect, result, @"");
}


-(void) testBuildHouseWhereClauseWithOneHousesAndMHFlag {
    AGoTHouse *house1 = [[AGoTHouse alloc] init];
    house1._id = 1;
    house1.name = @"zerg";
    
    NSSet *houseSelected = [NSSet setWithObjects:house1,  nil];
    [conditions setValue:houseSelected forKey:HOUSE_SELECTED];
    [conditions setObject:[NSNumber numberWithBool:YES] forKey:MULTI_HOUSE_FLAG];
    dao._conditions = conditions;
    
    NSString *result = [dao buildHouseWhereClause];
    
    NSString *expect = @"(1 and house like '%,%' and house like '%1%')"; 
    STAssertEqualStr(expect, result, @"");
}

#pragma mark -

-(void) testBuildSetWhereClauseAnySet {
    AGoTSet *set1 = [[AGoTSet alloc] init];
    set1.setsId = 0;
    [conditions setValue:set1 forKey:SET_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSetWhereClause];
    
    NSString *expect = @"(1)"; 
    STAssertEqualStr(expect, result, @"");
}


-(void) testBuildSetWhereClauseBigExp {
    AGoTSet *set1 = [[AGoTSet alloc] init];
    set1.setsId = 5;
    set1.expName = nil;
    [conditions setValue:set1 forKey:SET_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSetWhereClause];
    
    NSString *expect = @"(setsID='5')"; 
    STAssertEqualStr(expect, result, @"");
}

-(void) testBuildSetWhereClauseSmallExp {
    AGoTSet *set1 = [[AGoTSet alloc] init];
    set1.setsId = 5;
    set1.expId = 6;
    set1.expName = @"six";
    [conditions setValue:set1 forKey:SET_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSetWhereClause];
    
    NSString *expect = @"(expID='6')"; 
    STAssertEqualStr(expect, result, @"");
}

#pragma mark -

-(void) testBuildTypeWhereClauseAnyType {
    AGoTType *type1 = [[AGoTType alloc] init];
    type1._id = 0;
    [conditions setValue:type1 forKey:TYPE_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildTypeWhereClause];
    
    NSString *expect = @"(1)"; 
    STAssertEqualStr(expect, result, @"");
}

-(void) testBuildTypeWhereClauseAType {
    AGoTType *type1 = [[AGoTType alloc] init];
    type1._id = 3;
    [conditions setValue:type1 forKey:TYPE_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildTypeWhereClause];
    
    NSString *expect = @"(types=3)"; 
    STAssertEqualStr(expect, result, @"");
}

#pragma mark -

-(void) testBuildCrestWhereClause {
    AGotCrest *crest1 = [[AGotCrest alloc] init];
    crest1._id = 0;
    [conditions setValue:crest1 forKey:CREST_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildCrestWhereClause];
    
    NSString *expect = @"(1)"; 
    STAssertEqualStr(expect, result, @"");
}


-(void) testBuildCrestWhereClauseACrest {
    AGotCrest *crest1 = [[AGotCrest alloc] init];
    crest1._id = 5;
    [conditions setValue:crest1 forKey:CREST_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildCrestWhereClause];
    
    NSString *expect = @"(crests=5)"; 
    STAssertEqualStr(expect, result, @"");
}


#pragma mark -

-(void) testBuildChallengeWhereClauseNone {
    NSSet *challengesSelected = [NSSet setWithObjects: nil];
    [conditions setValue:challengesSelected forKey:CHALLENGES_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildChallengeWhereClause];
    
    NSString *expect = @"(1)"; 
    STAssertEqualStr(expect, result, @"");
}

-(void) testBuildChallengeWhereClausePowAndInt {
    NSSet *challengesSelected = [NSSet setWithObjects: POWER, INTELIGENCE, nil];
    [conditions setValue:challengesSelected forKey:CHALLENGES_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildChallengeWhereClause];
    
    NSString *expect = STR(@"(1) and challenge like '%%%@%%' and challenge like '%%%@%%'", POWER, INTELIGENCE); 
    STAssertEqualStr(expect, result, @"");
}


#pragma mark -

-(void) testBuildSearchCriteriaWhereClauseEmptyText {
    [conditions setValue:@"" forKey:SEARCH_TEXT];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSearchCriteriaWhereClause];
    
    NSString *expect = @"(1)"; 
    STAssertEqualStr(expect, result, @"");

}

-(void) testBuildSearchCriteriaWhereClauseNoneChecked {
    [conditions setValue:@"abc" forKey:SEARCH_TEXT];
    [conditions setValue:[NSNumber numberWithBool:NO] forKey:TITLE_FLAG];
    [conditions setValue:[NSNumber numberWithBool:NO] forKey:TRAITS_FLAG];
    [conditions setValue:[NSNumber numberWithBool:NO] forKey:RULES_FLAG];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSearchCriteriaWhereClause];
    
    NSString *expect = @"(1)"; 
    STAssertEqualStr(expect, result, @"");
    
}

-(void) testBuildSearchCriteriaWhereClauseRulesAndTitleChecked {
    [conditions setValue:@"abc" forKey:SEARCH_TEXT];
    [conditions setValue:[NSNumber numberWithBool:YES] forKey:TITLE_FLAG];
    [conditions setValue:[NSNumber numberWithBool:NO] forKey:TRAITS_FLAG];
    [conditions setValue:[NSNumber numberWithBool:YES] forKey:RULES_FLAG];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSearchCriteriaWhereClause];
    
    NSString *expect = STR(@"(0 or title like '%%%@%%' or rules like '%%%@%%')", @"abc", @"abc"); 
    STAssertEqualStr(expect, result, @"");
    
}

-(void) testBuildSearchCriteriaWhereClauseRulesAndTraitsChecked {
    [conditions setValue:@"abc" forKey:SEARCH_TEXT];
    [conditions setValue:[NSNumber numberWithBool:NO] forKey:TITLE_FLAG];
    [conditions setValue:[NSNumber numberWithBool:YES] forKey:TRAITS_FLAG];
    [conditions setValue:[NSNumber numberWithBool:YES] forKey:RULES_FLAG];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSearchCriteriaWhereClause];
    
    NSString *expect = STR(@"(0 or traits like '%%%@%%' or rules like '%%%@%%')", @"abc", @"abc"); 
    STAssertEqualStr(expect, result, @"");
    
}



@end

