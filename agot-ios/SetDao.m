//
//  SetDao.m
//  agot-ios
//
//  Created by mebusw on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SetDao.h"
#import "AGoTSet.h"
@implementation SetDao


-(NSString *)setTable:(NSString *)sql{
    return [NSString stringWithFormat:sql,  @"t_houses"];
}

-(AGoTSet*) parseSelectResult: (FMResultSet*)rs {
    AGoTSet *set = [[AGoTSet alloc] init];
    set._id = [rs stringForColumnIndex:0];
    set.crest = [rs stringForColumnIndex:1];
    return set;
    
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
