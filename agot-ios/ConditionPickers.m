//
//  ConditionPickers.m
//  agot-ios
//
//  Created by mebusw on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConditionPickers.h"
#import "AGoTType.h"
#import "AGotCrest.h"
#import "AGoTSet.h"


@implementation CrestPicker
@synthesize elements, button, conditionKey;

-(int) count {
    return [elements count];
}

-(NSString*) titleForIndex:(int)index {
    return ((AGotCrest*)[elements objectAtIndex:index]).name;
}


@end


@implementation TypePicker
@synthesize elements, button, conditionKey;

-(int) count {
    return [elements count];
}

-(NSString*) titleForIndex:(int)index {
    return ((AGoTType*)[elements objectAtIndex:index]).name;
}


@end


@implementation SetPicker
@synthesize elements, button, conditionKey;

-(int) count {
    return [elements count];
}

-(NSString*) titleForIndex:(int)index {
    return [(AGoTSet*)[elements objectAtIndex:index] composeNames];
}

@end