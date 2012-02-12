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
    STAssertTrue([expect isEqual:result], @"where clause not correct");
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
    STAssertTrue([expect isEqual:result], @"actual=%@", result);
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
    STAssertTrue([expect isEqual:result], @"actual=%@", result);
}

#pragma mark -

-(void) testBuildSetWhereClauseAnySet {
    AGoTSet *set1 = [[AGoTSet alloc] init];
    set1.setsId = 0;
    [conditions setValue:set1 forKey:SET_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSetWhereClause];
    
    NSString *expect = @"(1)"; 
    STAssertTrue([expect isEqual:result], @"actual=%@", result);
}


-(void) testBuildSetWhereClauseBigExp {
    AGoTSet *set1 = [[AGoTSet alloc] init];
    set1.setsId = 5;
    set1.expName = nil;
    [conditions setValue:set1 forKey:SET_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSetWhereClause];
    
    NSString *expect = @"(setsID=5)"; 
    STAssertTrue([expect isEqual:result], @"actual=%@", result);
}

-(void) testBuildSetWhereClauseSmallExp {
    AGoTSet *set1 = [[AGoTSet alloc] init];
    set1.setsId = 5;
    set1.expId = 6;
    set1.expName = @"six";
    [conditions setValue:set1 forKey:SET_SELECTED];
    dao._conditions = conditions;
    
    NSString *result = [dao buildSetWhereClause];
    
    NSString *expect = @"(expID=6)"; 
    STAssertTrue([expect isEqual:result], @"actual=%@", result);
}

@end
