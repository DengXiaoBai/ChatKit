//
// Created by iCrany on 2016/12/12.
//

#import "UIImageView+SKS.h"


@implementation UIImageView (SKS)

- (void)startRotation {
    [self startRotationWithDuration:1.5];
}

- (void)startRotationWithDuration:(float)duration {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.repeatCount = INFINITY;

    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopRotation {
    [self.layer removeAnimationForKey:@"rotationAnimation"];
}

@end