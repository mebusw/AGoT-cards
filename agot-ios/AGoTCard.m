#import "AGoTCard.h"

enum {
	kAgenda, kAttachment, kCharacter, kEvent, kLocation, kPlot
} CardType;


enum  {
	Main, Agenda, Attachment, Character,Event, Location, Plot, SearchResult
} ScreenType;

// "t_cards" ("_id" Integer PRIMARY KEY  NOT NULL ,"sortID" ,"sets_s" ,"setsID" ,"expID" ,"cardID" ,"title" ,"uniques" ,"house" ,"onlys" ,"types" ,"cost" ,"strength" ,"traits" ,"challenge" ,"keywords" ,"rules" ,"crests" ,"influence" ,"income" ,"initiative" ,"golds" ,"prior" ,"efficacy" ,"pub" ,"old_title" );





@implementation AGoTCard
@synthesize _id, pub, cost, expID, golds, house, onlys, prior, rules, title, types, cardID, crests, income, sets_s, setsID, sortID, traits, uniques, efficacy, keywords, strength, challenge, influence, old_title, initiative;



@end