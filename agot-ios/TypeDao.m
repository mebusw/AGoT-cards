//
//  TypeDao.m
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TypeDao.h"
#import "AGoTType.h"

@implementation TypeDao

-(NSString *)setTable:(NSString *)sql{
    return [NSString stringWithFormat:sql,  @"t_types"];
}

-(AGoTType*) parseSelectResult: (FMResultSet*)rs {
    AGoTType *type = [[AGoTType alloc] init];
    type._id = [rs intForColumnIndex:0];
    type.name = [rs stringForColumnIndex:1];
    return type;
    
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
