//
//  HouseDao.m
//  agot-ios
//
//  Created by mebusw on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HouseDao.h"
#import "AGoTHouse.h"

@implementation HouseDao

-(NSString *)setTable:(NSString *)sql{
    return [NSString stringWithFormat:sql,  @"t_houses"];
}

-(AGoTHouse*) parseSelectResult: (FMResultSet*)rs {
    AGoTHouse *house = [[AGoTHouse alloc] init];
    house._id = [rs stringForColumnIndex:0];
    house.name = [rs stringForColumnIndex:1];
    return house;
    
}

// SELECT
-(NSMutableArray*)select {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    FMResultSet *rs = [db executeQuery:[self setTable:@"SELECT * FROM %@"]];
    while ([rs next]) {
        [result addObject:[self parseSelectResult:rs]];
    }
    [rs close];
    return result;
    
}

@end
