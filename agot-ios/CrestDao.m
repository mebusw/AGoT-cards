//
//  CrestDao.m
//  agot-ios
//
//  Created by mebusw on 12-2-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CrestDao.h"
#import "AGotCrest.h"
@implementation CrestDao


-(NSString *)setTable:(NSString *)sql{
    return [NSString stringWithFormat:sql,  @"t_houses"];
}

-(AGotCrest*) parseSelectResult: (FMResultSet*)rs {
    AGotCrest *crest = [[AGotCrest alloc] init];
    crest._id = [rs stringForColumnIndex:0];
    crest.crest = [rs stringForColumnIndex:1];
    return crest;
    
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
