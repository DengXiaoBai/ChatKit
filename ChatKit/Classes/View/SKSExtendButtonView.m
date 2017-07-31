//
//  SKSExtendButtonView.m
//  ChatKit
//
//  Created by iCrany on 2017/7/31.
//
//

#import "SKSExtendButtonView.h"

@interface SKSExtendButtonView()

@property (nonatomic, assign) CGPoint insetPoint;

@end

@implementation SKSExtendButtonView

- (instancetype)initWithFrame:(CGRect)frame insetPoint:(CGPoint)insetPoint {
    self = [super initWithFrame:frame];
    if (self) {
        self.insetPoint = insetPoint;
    }
    return self;
}

#pragma mark - Override method

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event {
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {

    CGRect extendButtonRect = CGRectInset(self.bounds, self.insetPoint.x, self.insetPoint.y);
    if (CGRectContainsPoint(extendButtonRect, point)) {
        return YES;
    }
    return [super pointInside:point withEvent:event];
}


@end
