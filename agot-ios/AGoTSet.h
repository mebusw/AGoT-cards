//
//  AGoTSet.h
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface AGoTSet : NSObject {
    
}


@property (nonatomic, strong) NSString * sets_s;
@property (nonatomic) int setsId;
@property (nonatomic) int expId;
@property (nonatomic) int _id;
@property (nonatomic, strong) NSString *setName;
@property (nonatomic, strong) NSString *expName;

-(BOOL)isBigExpansion; 

@end
