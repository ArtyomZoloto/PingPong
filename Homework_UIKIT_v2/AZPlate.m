#import "AZPlate.h"

@interface AZPlate ()
@property (strong, nonatomic) UIGestureRecognizer *panGestureRecognizer;
@property (assign, nonatomic) CGSize offset;
@end

@implementation AZPlate

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self addGestureRecognizer: self.panGestureRecognizer];
    }
    return self;
}

-(void) handlePan: (UIGestureRecognizer*) panGestureRecognizer
{
    CGPoint locationInParent = [panGestureRecognizer locationInView:self.window];
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan){
        self.offset = CGSizeMake(self.center.x - locationInParent.x,
                                 self.center.y - locationInParent.y);
    }
    
    self.center = CGPointMake(locationInParent.x + self.offset.width,
                              self.center.y);
}

-(UIPanGestureRecognizer*) panGestureRecognizer
{
    return [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
}

@end
