//
//  SKSButtonInputView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSButtonInputView.h"

@implementation SKSButtonInputView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (UIView *)inputView {
    return _buttonInputView;
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
