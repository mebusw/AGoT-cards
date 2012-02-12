


#import "CardDao.h"
#import "AGoTCard.h"
#import "AGoTHouse.h"
#import "AGoTSet.h"
#import "AGoTType.h"
#import "CardBrief.h"
#import "dictKeys.h"

@implementation CardDao

@synthesize _conditions;

-(NSString *)setTable:(NSString *)sql{
    return [NSString stringWithFormat:sql,  @"t_cards"];
}

-(AGoTCard*) parseSelectResult: (FMResultSet*)rs {
    AGoTCard *card = [[AGoTCard alloc] init];
    
    return card;
    
}

// SELECT All
-(NSMutableArray*)select {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    FMResultSet *rs = [db executeQuery:[self setTable:@"SELECT * FROM %@"]];
    while ([rs next]) {
        [result addObject:[self parseSelectResult:rs]];
    }
    [rs close];
    return result;
}

-(NSString*) buildHouseWhereClause {
    NSSet *houseSelected = [_conditions objectForKey:HOUSE_SELECTED];
    BOOL multiHouseFlag = [(NSNumber*)[_conditions objectForKey:MULTI_HOUSE_FLAG] boolValue];
    NSString *connector;
    NSMutableString *result = [NSMutableString stringWithString:@""];
            
    if (0 == [houseSelected count]) {
        return @"(1)";
    }
    
    if (multiHouseFlag) {
        connector = @" and ";
        [result appendString:@"(1 and house like '%,%'"];
    } else {
        connector = @" or ";
        [result appendString:@"(0"];
    }
    for (AGoTHouse *house in houseSelected) {
        [result appendFormat:@"%@house like '%%%d%%'", connector, house._id, nil];
    }
    [result appendString:@")"];
    NSLog(@"result=%@", result);
    
    return result;
}


-(NSString*) buildCrestWhereClause {
    return @"";
    
}

-(NSString*) buildTypeWhereClause {
    return @"";
    
}


-(NSString*) buildSetWhereClause {
    AGoTSet *set = [_conditions objectForKey:SET_SELECTED];
    if (0 == set.setsId) {
        return @"(1)";
    }
    if (set.isBigExpansion) {
        return [NSString stringWithFormat:@"(setsID=%d)", set.setsId];
    } else {
        return [NSString stringWithFormat:@"(expID=%d)", set.expId];        
    }
}

-(NSString*) buildWheres {
    NSArray *wheres = [NSArray arrayWithObjects:[self buildHouseWhereClause], nil];
    return [wheres componentsJoinedByString:@" and "];
}

- (CardBrief*) parseCardBrief: (FMResultSet*)rs {
    CardBrief *cardBrief = [[CardBrief alloc] init];
    cardBrief._id = [rs stringForColumnIndex:0];
    cardBrief.title = [rs stringForColumnIndex:1];
    cardBrief.type = [rs stringForColumnIndex:2];
    cardBrief.set = [rs stringForColumnIndex:3];
    return cardBrief;
    
}

-(NSMutableArray*)selectCardBrieves: (NSDictionary*) conditions {
    _conditions = conditions;
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    //TODO
    FMResultSet *rs = [db executeQuery: [NSString stringWithFormat:@"select _id, title, type_name, set_name from v_main_search where %@", [self buildWheres]]];
    while ([rs next]) {
        [result addObject:[self parseCardBrief:rs]];
    }
    [rs close];
    return result;
}
/*
// INSERT
-(void)insertWithTitle:(NSString *)title Body:(NSString *)body{
  [db executeUpdate:[self setTable:@"INSERT INTO %@ (title, body) VALUES (?,?)"], title, body];
  if ([db hadError]) {
    NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
  }
}
// UPDATE
-(BOOL)updateAt:(int)index Title:(NSString *)title Body:(NSString *)body{
  BOOL success = YES;
  [db executeUpdate:[self setTable:@"UPDATE %@ SET title=?, body=? WHERE id=?"], title, body, [NSNumber numberWithInt:index]];
  if ([db hadError]) {
    NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    success = NO;
  }
  return success;
}
// DELETE
- (BOOL)deleteAt:(int)index{
  BOOL success = YES;
  [db executeUpdate:[self setTable:@"DELETE FROM %@ WHERE id = ?"], [NSNumber numberWithInt:index]];
  if ([db hadError]) {
    NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    success = NO;
  }
  return success;
}
 */


@end