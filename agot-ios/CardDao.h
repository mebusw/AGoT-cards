//
//  CardDao.h
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BaseDao.h"

@interface CardDao : BaseDao {
}

-(NSMutableArray *)select;
-(void)insertWithTitle:(NSString *)title Body:(NSString *)body;
-(BOOL)updateAt:(int)index Title:(NSString *)title Body:(NSString *)body;
- (BOOL)deleteAt:(int)index;

@end
