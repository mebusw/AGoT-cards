
#import "AGoTSet.h"

@implementation AGoTSets
@synthesize setId, expId, setName, expName, isBigExpansion;

- (id)initWithSet:(int)sId setName:(NSString*)sName Exp:(int)eId expName:(NSString*)eName {
    self = [super init];
    if (self) {
		self.setId=sId;
		self.expId=eId;
		self.setName=sName;
		self.expName=eName;
		self.isBigExpansion = (eName==nil || [eName isEqual:@""]);
    }
    return self;
}

@end
