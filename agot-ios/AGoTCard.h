//
//  AGoTCard.h
//  agot-ios
//
//  Created by mebusw on 12-2-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface AGoTCard : NSObject {
    
}

@property (nonatomic) int _id;
@property (nonatomic) int sortID;
@property (nonatomic, strong) NSString *sets_s;
@property (nonatomic) int setsID;
@property (nonatomic) int expID;
@property (nonatomic) int cardID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *uniques;
@property (nonatomic, strong) NSString *house;
@property (nonatomic, strong) NSString *onlys;
@property (nonatomic, strong) NSString *types;
@property (nonatomic, strong) NSString *cost;
@property (nonatomic, strong) NSString *strength;
@property (nonatomic, strong) NSString *traits;
@property (nonatomic, strong) NSString *challenge;
@property (nonatomic, strong) NSString *keywords;
@property (nonatomic, strong) NSString *rules;
@property (nonatomic, strong) NSString *crests;
@property (nonatomic, strong) NSString *influence;
@property (nonatomic, strong) NSString *income;
@property (nonatomic, strong) NSString *initiative;
@property (nonatomic, strong) NSString *golds;
@property (nonatomic, strong) NSString *prior;
@property (nonatomic, strong) NSString *efficacy;
@property (nonatomic, strong) NSString *pub;
@property (nonatomic, strong) NSString *old_title;


@end