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
        self.vector = CGVectorMake(0, 0);
    }
    return self;
}
- (void)move
{
    
    if (self.vector.dx == 0 && self.vector.dy == 0){
        self.vector = CGVectorMake(1, -1);
    }
    
    self.frame = CGRectMake(self.frame.origin.x + self.vector.dx, self.frame.origin.y + self.vector.dy, self.frame.size.width, self.frame.size.width);
}



-(void) flipX
{
    self.vector = CGVectorMake(-self.vector.dx, self.vector.dy);
}

-(void) flipY
{
    self.vector = CGVectorMake(self.vector.dx, -self.vector.dy);
}

-(void) stop {
    self.vector = CGVectorMake(0, 0);
}

@end
