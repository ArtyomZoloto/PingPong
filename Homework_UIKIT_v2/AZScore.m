#import "AZScore.h"
NSString *const YOUR_SCORE = @"YOUR_SCORE";
NSString *const OPPONENT_SCORE = @"OPPONENT_SCORE";

@implementation AZScore
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder
{
    [aCoder encodeInt64:_yourScore forKey:YOUR_SCORE];
    [aCoder encodeInt64:_opponentScore forKey:OPPONENT_SCORE];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _yourScore = [aDecoder decodeIntegerForKey:YOUR_SCORE];
        _opponentScore = [aDecoder decodeIntegerForKey:OPPONENT_SCORE];
    }
    return self;
}

@end
