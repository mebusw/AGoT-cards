
#import "AGoTSet.h"

@implementation AGoTSets
@synthesize sets_s, setsId, expId, _id, setName, expName;

- (BOOL)isBigExpansion {
    return (expName == nil || [expName isEqual:@""]);
}

@end
