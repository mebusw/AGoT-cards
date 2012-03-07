//
//  CardViewController.m
//  agot-ios
//
//  Created by mebusw on 12-2-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CardViewController.h"

@implementation CardViewController
@synthesize card, pageId;
@synthesize lblCost, lblTitle, lblTraits, wvRules, imgCrest, lblIncome, lblInfuluence, lblInitiative, imgCost, imgIncome, imgInfuluence, imgInitiative;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(BOOL) isEmptyString:(NSString*) str {
    return (!str || [str isEqualToString:@""] || [str isEqualToString:@"NULL"]);
}

-(NSString*) replaceMarksOfRuleWithSpecialIcon:(NSString*)text {
    NSString *replaced = text;
    NSDictionary *mapping = [NSDictionary dictionaryWithObjectsAndKeys:@"{", @"cn", @"}", @"cl", @"<", @"cw", @"\\", @"ch", @"|", @"cs", @"%", @"hs", @"^", @"hl", @"&", @"hb", @"~", @"ht", @"_", @"hg", @">", @"hm", @"@", @"m", @"#", @"i", @"$", @"p", nil];
    for (NSString *key in mapping) {
        NSString *value = [mapping objectForKey:key];
        
        replaced = [replaced stringByReplacingOccurrencesOfString:STR(@"(%@)", key) withString:value];
        replaced = [replaced stringByReplacingOccurrencesOfString:STR(@"（%@)", key) withString:value];
        replaced = [replaced stringByReplacingOccurrencesOfString:STR(@"(%@）", key) withString:value];
        replaced = [replaced stringByReplacingOccurrencesOfString:STR(@"（%@）", key) withString:value];        
    }

    return replaced;
}

-(NSString*) formatRules:(NSString*) ruleText {
    
    return STR(@"<p style='font-family:\"TimesGoT\"'>%@</p>", [self replaceMarksOfRuleWithSpecialIcon:ruleText]);
    
}

-(void) drawHouseIcons {
    NSArray *houseImages = [NSArray arrayWithObjects:ICON_STARK, ICON_BARATHEON, ICON_TARGRARYEN, ICON_LANNISTER, ICON_MARTELL, ICON_GREYJOY, ICON_NEUTRAL, ICON_UNIQUE, nil];
    NSArray *housesNumStrings = [card.house componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，"]];
    
    int y = 8;
    for (NSString *h in housesNumStrings) {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(290, y, 24, 24)];
        icon.image = [UIImage imageNamed:[houseImages objectAtIndex:[h intValue]]];
        [self.view addSubview:icon];    
        y += 24;
    }   
}

-(void) drawCostIcon {
    if ([self isEmptyString:card.cost]) {
        lblCost.hidden = YES;
        imgCost.hidden = YES;
    } else {
        lblCost.text = card.cost;
    }
}


-(void) drawCrestIcon {
    NSArray *iconArray = [NSArray arrayWithObjects:ICON_BW_WAR, ICON_BW_LEARNED, ICON_BW_HOLY, ICON_BW_SHADOWS, ICON_BW_NOBLE, nil];
    if ([self isEmptyString:card.crests]) {
        imgCrest.hidden = YES;
    } else {
        imgCrest.image = [UIImage imageNamed:[iconArray objectAtIndex:[card.crests intValue] - 1]]; //TODO magic number, because in DB it starts from 1
    }
}

-(void) draw3I {
    if ([self isEmptyString:card.influence]) {
        lblInfuluence.hidden = YES;
        imgInfuluence.hidden = YES;
    } else {
        lblInfuluence.text = card.influence;
    }
    
    if ([self isEmptyString:card.income]) {
        lblIncome.hidden = YES;
        imgIncome.hidden = YES;
    } else {
        lblIncome.text = card.income;
    }
    
    if ([self isEmptyString:card.initiative]) {
        lblInitiative.hidden = YES;
        imgInitiative.hidden = YES;
    } else {
        lblInitiative.text = card.initiative;
    }
}

-(void) drawGold {
    if ([card.crests isEqualToString:@"4"]) { //TODO magic number, need to align with DB
        lblCost.text = STR(@"s%@", card.cost);
    } else {
        lblCost.text = card.cost;
    }
    
}

-(void) drawTitle {
    NSArray *strings = [card.uniques componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",，"]];
    NSMutableString *formatedTitle = [NSMutableString stringWithString:@""];
    NSLog(@"%@--%@", card.uniques, strings);

    for (NSString *s in strings) {
        if ([s isEqualToString:STR_UNIQUE]) {
            [formatedTitle appendFormat:@"⚑"];
        } else if ([s isEqualToString:STR_INFINITE]) {
            [formatedTitle appendFormat:@"∞"];
        }
    }
    [formatedTitle appendFormat:card.title];
    lblTitle.text = formatedTitle;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@", self.card.title);
    lblTraits.text = card.traits;
    [self drawTitle];
    [self.wvRules loadHTMLString:[self formatRules:card.rules] baseURL:nil];
    [self drawHouseIcons];
    [self drawCostIcon];
    [self drawCrestIcon];
    [self draw3I];
    [self drawGold];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
