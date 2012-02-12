


#import "CardDao.h"
#import "AGoTCard.h"
#import "CardBrief.h"

@implementation CardDao

NSDictionary* _conditions;

-(NSString *)setTable:(NSString *)sql{
    return [NSString stringWithFormat:sql,  @"t_cards"];
}

-(AGoTCard*) parseSelectResult: (FMResultSet*)rs {
    AGoTCard *card = [[AGoTCard alloc] init];
    
    return card;
    
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

-(NSString*) buildHouseWhereClause {
    NSSet *houseSet = [_conditions objectForKey:@"houseIds"];
    BOOL multiHouse = [(NSNumber*)[_conditions objectForKey:@"multiHouse"] boolValue];
    NSString *connector;
    NSMutableString *result = [NSMutableString stringWithString:@""];
            
    if (0 == [houseSet count]) {
        return @"(1)";
    }
    
    if (multiHouse) {
        connector = @" AND ";
        [result appendString:@"( 1 and house like '%,%' "];
    } else {
        connector = @" OR ";
        [result appendString:@"( 0"];
    }
    for (NSNumber *houseId in houseSet) {
        [result appendFormat:@"%@ house like '%%d%' ", connector, houseId, nil];
    }
    [result appendString:@" )"];
    NSLog(@"result=%@", result);
    
    return result;
}

-(NSString*) buildWheres {
    NSArray *wheres = [NSArray arrayWithObjects:[self buildHouseWhereClause], nil];
    return [wheres componentsJoinedByString:@" AND "];
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
    FMResultSet *rs = [db executeQuery: [NSString stringWithFormat:@"select _id, title, type_name, set_name from v_main_search where %@ and _id < 15", [self buildWheres]]];
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