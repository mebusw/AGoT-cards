
#import "AGoTSet.h"

@implementation AGoTSet
@synthesize sets_s, setsId, expId, _id, setName, expName;

- (BOOL)isBigExpansion {
    return (expName == nil || [expName isEqual:@""]);
}

- (NSString*) composeNames {
    if (nil != self.expName) {
        return [NSString stringWithFormat:@"%@ - %@", self.setName, self.expName];
    } else {
        return self.setName;
    }
    
}

@end
