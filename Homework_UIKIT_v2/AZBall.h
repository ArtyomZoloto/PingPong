//
//  Ball.h
//  Homework_UIKIT_v2
//
//  Created by igor on 16/05/2019.
//  Copyright © 2019 Zolotoverkhov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AZBall : UIImageView
@property (assign, nonatomic) CGVector vector;
-(void) move;
-(void) stop;
-(void) flipX;
-(void) flipY;
@end

NS_ASSUME_NONNULL_END
