
#import "AGoTSet.h"

@implementation AGoTSet
@synthesize sets_s, setsId, expId, _id, setName, expName;

- (BOOL)isBigExpansion {
    return (expName == nil || [expName isEqual:@""]);
}

@end
