


#import "CardDao.h"
#import "AGoTCard.h"
#import "CardBrief.h"

@implementation CardDao

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

-(NSString*) buildWheres: (NSDictionary*) conditions {
    return @"_id<5";
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
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    FMResultSet *rs = [db executeQuery: [NSString stringWithFormat:@"select _id, title, type_name, set_name from v_main_search where %@", [self buildWheres:conditions]]];
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