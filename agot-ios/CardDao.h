//
//  CardDao.h
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseDao.h"

@interface CardDao : BaseDao {
}

@property (nonatomic, strong) NSDictionary* _conditions;

-(NSMutableArray *)select;
//-(void)insertWithTitle:(NSString *)title Body:(NSString *)body;
//-(BOOL)updateAt:(int)index Title:(NSString *)title Body:(NSString *)body;
//- (BOOL)deleteAt:(int)index;

-(NSMutableArray*)selectCardBrieves: (NSDictionary*) conditions;


-(NSString*) buildHouseWhereClause;
-(NSString*) buildSetWhereClause;
-(NSString*) buildCrestWhereClause;
-(NSString*) buildTypeWhereClause;
-(NSString*) buildChallengeWhereClause;

@end
