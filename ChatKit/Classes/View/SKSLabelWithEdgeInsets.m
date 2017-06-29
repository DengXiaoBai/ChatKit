//
//  SKSLabelWithEdgeInsets.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSLabelWithEdgeInsets.h"

@interface SKSLabelWithEdgeInsets()

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end

@implementation SKSLabelWithEdgeInsets

- (instancetype)initWIthEdgeInsets:(UIEdgeInsets)edgeInsets {
    self = [super init];
    if (self) {
        self.edgeInsets = edgeInsets;
    }

    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
