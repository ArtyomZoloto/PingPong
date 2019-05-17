#import "ViewController.h"
#import "AZPlate.h"
#import "AZBall.h"

@interface ViewController ()
@property (strong, nonatomic) AZBall *ball;
@property (strong, nonatomic) AZPlate *plate;
@property (strong, nonatomic) AZPlate *opponentPate;
@property (strong, nonatomic) UIButton *startButton;
@property (assign, nonatomic) BOOL isStarted;
@property (assign, nonatomic) long yourScore;
@property (assign, nonatomic) long opponentScore;
@property (strong, nonatomic) UILabel *opponentScoreLabel;
@property (strong, nonatomic) UILabel *yourScoreLabel;
@property (strong, nonatomic) NSArray<NSTimer*>* timers;
@property (strong, nonatomic) NSTimer *stickTimer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addStartButton];
    [self addPlate];
    [self addOpponentPlate];
    [self addBall];
    [self addControls];
    [self stopGame];
}



- (BOOL)isOnPlayerPlate
{
    return self.ball.frame.origin.y + self.ball.frame.size.height > self.plate.frame.origin.y
    && self.ball.center.x > self.plate.frame.origin.x && self.ball.center.x < self.plate.frame.origin.x + self.plate.frame.size.width;
}

- (BOOL)isOnOpponentPlate
{
    return self.ball.frame.origin.y < self.opponentPate.frame.origin.y + self.opponentPate.frame.size.height
    && self.ball.center.x > self.opponentPate.frame.origin.x
    && self.ball.center.x < self.opponentPate.frame.origin.x + self.opponentPate.frame.size.width;
}

-(void) checkCollision
{
    if ([self isOnScreenBorder]){
        [self.ball flipX];
    }
    if ([self isOnPlayerPlate] || [self isOnOpponentPlate]){
        [self.ball flipY];
    }
    
}

- (BOOL)isOnScreenBorder
{
    return self.ball.frame.origin.x <= CGRectGetMinX(self.view.bounds)
    || self.ball.frame.origin.x + self.ball.frame.size.width >= CGRectGetMaxX(self.view.bounds);
}

-(void) checkOutside
{
    
    BOOL youWin = (self.ball.frame.origin.y > self.plate.frame.origin.y);
    BOOL youLoose = (self.ball.frame.origin.y < self.opponentPate.frame.origin.y);
    
    if (youWin){
        self.opponentScoreLabel.text = [NSString stringWithFormat:@"%ld", ++self.opponentScore];
    }
    if (youLoose){
        self.yourScoreLabel.text = [NSString stringWithFormat:@"%ld", ++self.yourScore];
        
        
    }
    
    if (youWin || youLoose){
        [self stopGame];
    }
    
}


-(void) fixBallToPlate
{
    self.ball.frame = CGRectMake(self.plate.frame.origin.x+50, self.plate.frame.origin.y - self.ball.frame.size.height, 20, 20);
}

- (void)addStartButton
{
    
}

-(void) startGame
{
    [self.stickTimer invalidate];
    self.stickTimer = nil;
    [self.ball launch];
    [self.startButton removeTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    [self.startButton addTarget:self action:@selector(pauseGame) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.startButton setTitle:@"pause" forState:UIControlStateNormal];
    
    __weak ViewController *weakSelf = self;
    NSTimer *ballTimer = [NSTimer scheduledTimerWithTimeInterval:0.003f repeats:YES block:^(NSTimer * _Nonnull timer)
                          {
                              __strong ViewController *strongSelf = weakSelf;
                              [strongSelf.ball move];
                              [strongSelf checkCollision];
                              [self checkOutside];
                          }];
    
    NSTimer *opponentTimer = [NSTimer scheduledTimerWithTimeInterval:0.1f repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.opponentPate.center = CGPointMake(self.ball.center.x, self.opponentPate.center.y);
    }];
    
    self.timers = @[ballTimer,opponentTimer];
}

-(void) pauseGame
{
    [self stopTimers];
    [self.startButton removeTarget:self action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
    [self.startButton addTarget:self action:@selector(startGame) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.startButton setTitle:@"continue" forState:UIControlStateNormal];
}

- (void)stopTimers {
    for(NSTimer *t in self.timers){
        [t invalidate];
    }
    self.timers = nil;
}

-(void) stopGame {
    [self stopTimers];
    self.stickTimer = [NSTimer scheduledTimerWithTimeInterval:0.001f repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self fixBallToPlate];
    }];
    
    [self.startButton setTitle:@"Play" forState:UIControlStateNormal];
    [self.startButton removeTarget:self action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
    [self.startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
}


- (void)addBall
{
    self.ball = [[AZBall alloc] init];
    self.ball.frame = CGRectMake(self.plate.frame.origin.x+50, self.plate.frame.origin.y - self.ball.frame.size.height, 20, 20);
    [self.view addSubview:self.ball];
}

- (void)addPlate
{
    self.plate = [[AZPlate alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    self.plate.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds)-50);
    [self.view addSubview:self.plate];
}

-(void) addOpponentPlate
{
    self.opponentPate = [[AZPlate alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    self.opponentPate.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMinY(self.view.bounds)+50);
    [self.view addSubview:self.opponentPate];
}

-(void) addControls
{
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startButton.frame = CGRectMake(0, 0, 0, 0);
    [self.startButton setTitle:@"play" forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.startButton];
    
    
    self.opponentScoreLabel = [UILabel new];
    self.yourScoreLabel = [UILabel new];
    self.opponentScoreLabel.textAlignment = self.yourScoreLabel.textAlignment = NSTextAlignmentCenter;
    UIStackView *board = [[UIStackView alloc] initWithArrangedSubviews:@[self.opponentScoreLabel, self.yourScoreLabel, self.startButton]];
    //board.center = CGPointMake(50, CGRectGetMidY(self.view.bounds));
    board.axis = UILayoutConstraintAxisVertical;
    board.spacing = 50.0f;
    board.frame = CGRectMake(0, CGRectGetMidY(self.view.bounds)-100, 100, 200);
    [self.view addSubview:board];
    
    self.yourScore = self.opponentScore = 0;
    self.opponentScoreLabel.text = self.yourScoreLabel.text = @"0";
}

@end
