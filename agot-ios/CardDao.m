


#import "CardDao.h"
#import "AGoTCard.h"
#import "AGoTHouse.h"
#import "AGoTSet.h"
#import "AGoTType.h"
#import "AGotCrest.h"
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
    
    return result;
}


-(NSString*) buildCrestWhereClause {
    AGotCrest *crest = [_conditions objectForKey:CREST_SELECTED];
    if (0 == crest._id) {
        return @"(1)";
    } else {
        return [NSString stringWithFormat:@"(crests=%d)", crest._id];
    }
}

-(NSString*) buildTypeWhereClause {
    AGoTType *type = [_conditions objectForKey:TYPE_SELECTED];
    if (0 == type._id) {
        return @"(1)";
    } else {
        return [NSString stringWithFormat:@"(types=%d)", type._id];
    }
}


-(NSString*) buildSetWhereClause {
    AGoTSet *set = [_conditions objectForKey:SET_SELECTED];
    if (0 == set.setsId) {
        return @"(1)";
    }

    NSLog(@"%d-%d", set.setsId, set.expId);
    if (set.isBigExpansion) {
        return [NSString stringWithFormat:@"(setsID='%d')", set.setsId];
    } else {
        return [NSString stringWithFormat:@"(expID='%d')", set.expId];        
    }
}


-(NSString*) buildChallengeWhereClause {
    NSMutableString *result = [NSMutableString stringWithString:@"(1)"];
    NSSet *challengesSelected = [_conditions objectForKey:CHALLENGES_SELECTED];

    for (NSString *challenge in challengesSelected) {
        [result appendFormat:@" and challenge like '%%%@%%'", challenge];
    }
    return result;
}

-(NSString*) buildSearchCriteriaWhereClause {
    BOOL titleFlag = [(NSNumber*)[_conditions objectForKey:TITLE_FLAG] boolValue];
    BOOL traitsFlag = [(NSNumber*)[_conditions objectForKey:TRAITS_FLAG] boolValue];
    BOOL rulesFlag = [(NSNumber*)[_conditions objectForKey:RULES_FLAG] boolValue];
    NSString *searchText = [_conditions objectForKey:SEARCH_TEXT];
    if ([searchText isEqualToString:@""] || !(titleFlag || traitsFlag || rulesFlag)) {
        return @"(1)";
    }
    
    NSMutableString *result = [NSMutableString stringWithString:@"(0"];
    if (titleFlag) {
        [result appendFormat:@" or title like '%%%@%%'", searchText];
    }
    if (traitsFlag) {
        [result appendFormat:@" or traits like '%%%@%%'", searchText];
    }    
    if (rulesFlag) {
        [result appendFormat:@" or rules like '%%%@%%'", searchText];
    }
    [result appendString:@")"];
    return result;
}


-(NSString*) buildWheres {
    NSArray *wheres = [NSArray arrayWithObjects:[self buildHouseWhereClause], [self buildSearchCriteriaWhereClause], [self buildChallengeWhereClause], [self buildSetWhereClause], [self buildCrestWhereClause], [self buildTypeWhereClause], nil];
    return [wheres componentsJoinedByString:@" and "];
}


- (AGoTCard*) parseCards: (FMResultSet*)rs {
    AGoTCard *card = [[AGoTCard alloc] init];
    card._id = [rs stringForColumnIndex:0];
    card.title = [rs stringForColumnIndex:6];
    card.uniques = [rs stringForColumnIndex:7];
    card.house = [rs stringForColumnIndex:8];
    card.onlys = [rs stringForColumnIndex:9];
    card.types = [rs stringForColumnIndex:10];
    card.cost = [rs stringForColumnIndex:11];
    card.strength = [rs stringForColumnIndex:12];
    card.traits = [rs stringForColumnIndex:13];    
    card.challenge = [rs stringForColumnIndex:14];    
    card.keywords = [rs stringForColumnIndex:15];
    card.rules = [rs stringForColumnIndex:16];    
    card.crests = [rs stringForColumnIndex:17];    
    card.influence = [rs stringForColumnIndex:18];    
    card.income = [rs stringForColumnIndex:19];    
    card.initiative = [rs stringForColumnIndex:20];
    card.golds = [rs stringForColumnIndex:21];    
    card.prior = [rs stringForColumnIndex:22];
    card.efficacy = [rs stringForColumnIndex:23];
    card.type_name = [rs stringForColumnIndex:26];
    card.set_name = [rs stringForColumnIndex:27];    
    
    return card;
    
}


-(NSMutableArray*)selectCards: (NSDictionary*) conditions {
    _conditions = conditions;
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];

    FMResultSet *rs = [db executeQuery: [NSString stringWithFormat:@"select * from v_main_search where %@", [self buildWheres]]];
    while ([rs next]) {
        [result addObject:[self parseCards:rs]];
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