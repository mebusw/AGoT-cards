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

-(void) testBuildHouseWhereClauseNoneSelected {
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


@end
