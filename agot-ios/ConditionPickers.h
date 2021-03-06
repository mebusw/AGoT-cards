//
//  ConditionPickers.h
//  agot-ios
//
//  Created by mebusw on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ConditionPicker <NSObject> 

-(NSString*) titleForIndex:(int)index;
-(int) count;

@property (nonatomic, retain) NSArray *elements;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) NSString *conditionKey;

@end




@interface CrestPicker : UIPickerView <ConditionPicker>


@end

@interface SetPicker : UIPickerView <ConditionPicker>


@end


@interface TypePicker : UIPickerView <ConditionPicker>


@end
