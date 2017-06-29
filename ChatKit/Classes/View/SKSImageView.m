//
//  SKSImageView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSImageView.h"

@implementation SKSImageView

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {//用于 UIMenuController 的显示
    return YES;
}

- (BOOL)canResignFirstResponder {
    return YES;
}

- (UIResponder *)nextResponder {
    if (_overrideNextResponder != nil) {
        if (_overrideNextResponder == self) {
            return [super nextResponder];
        } else {
            return _overrideNextResponder;
        }
    } else {
        return [super nextResponder];
    }
}

@end
