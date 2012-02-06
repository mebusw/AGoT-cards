

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "CardDao.h"
#import "AGoTCard.h"

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
        AGoTCard *card = [self parseSelectResult:rs];
        [result addObject:card];
    }
    [rs close];
    return result;
}

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


@end