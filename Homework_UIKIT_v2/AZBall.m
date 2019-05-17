//
//  Ball.m
//  Homework_UIKIT_v2
//
//  Created by igor on 16/05/2019.
//  Copyright © 2019 Zolotoverkhov. All rights reserved.
//

#import "AZBall.h"

@implementation AZBall

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.image = [UIImage imageNamed:@"ball"];
        self.bounds = CGRectMake(0, 0, 20, 20);
    }
    return self;
}
- (void)move
{
    self.frame = CGRectMake(self.frame.origin.x + self.vector.width, self.frame.origin.y + self.vector.height, self.frame.size.width, self.frame.size.width);
}

-(void)launch
{
    self.vector = CGSizeMake(1, -1);
}

-(void) flipX
{
    self.vector = CGSizeMake(-self.vector.width, self.vector.height);
}

-(void) flipY
{
    self.vector = CGSizeMake(self.vector.width, -self.vector.height);
}

-(void) stop {
    self.vector = CGSizeMake(0, 0);
}

@end
