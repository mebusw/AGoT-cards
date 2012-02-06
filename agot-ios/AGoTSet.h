//
//  AGoTSet.h
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface AGoTSets : NSObject {
    
}

@property (nonatomic) int setId;
@property (nonatomic) int expId;
@property (nonatomic, strong) NSString *setName;
@property (nonatomic, strong) NSString *expName;
@property (nonatomic) BOOL isBigExpansion; 

- (id)initWithSet:(int)setId setName:(NSString*)sName Exp:(int)expId expName:(NSString*)eName;


@end
