#import <Foundation/Foundation.h>

extern NSString *const YOUR_SCORE;
extern NSString *const OPPONENT_SCORE;

NS_ASSUME_NONNULL_BEGIN

@interface AZScore : NSObject <NSCoding>
@property (assign, nonatomic) NSInteger yourScore;
@property (assign, nonatomic) NSInteger opponentScore;
@end

NS_ASSUME_NONNULL_END
