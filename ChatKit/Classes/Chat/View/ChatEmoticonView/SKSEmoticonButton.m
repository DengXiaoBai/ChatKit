//
//  SKSEmoticonButton.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/14.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <pop/POPSpringAnimation.h>
#import "SKSEmoticonButton.h"
#import "SKSEmoticonMeta.h"

@implementation SKSEmoticonButton


#pragma mark - Public method
- (void)doScaleSmallAnimation:(BOOL)isSmallAnimation {
    [self.layer removeAllAnimations];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    scaleAnimation.springBounciness = 10;
    
    if (!isSmallAnimation) {
        scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
        [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    } else {
        scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.6, 0.6)];
        [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}

- (void)updateEmoticonMeta:(SKSEmoticonMeta *)emoticonMeta {
    self.emoticonMeta = emoticonMeta;
    if (emoticonMeta.isEmoji) {
        [self setTitle:emoticonMeta.emoticonId forState:UIControlStateNormal];
    }
}

@end
