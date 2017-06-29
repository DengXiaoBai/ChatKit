//
//  SKSInputTextView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSInputTextView.h"

@implementation SKSInputTextView

- (BOOL)canBecomeFirstResponder {
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

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_overrideNextResponder != nil) {
        return NO;
    } else {
        return [super canPerformAction:action withSender:sender];
    }
}

@end
