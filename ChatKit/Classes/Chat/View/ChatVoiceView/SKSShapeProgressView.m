//
//  SKSShapeProgressView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Masonry/MASConstraint.h>
#import <Masonry/Masonry.h>
#import "SKSShapeProgressView.h"
#import "UIColor+SKS.h"
#import "SKSChatMessageConstant.h"

static const CGFloat kLittleDotHeight = 1;
static const CGFloat kLittleDotWidth = 4;

@interface SKSShapeProgressView()

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIView *lineView;//线
@property (nonatomic, strong) UIView *littleDotView;//小点视图

@end

@implementation SKSShapeProgressView

- (instancetype)initWithLineColor:(UIColor *)lineColor backgroundColor:(UIColor *)backgroundColor {
    self = [super init];
    if (self) {
        _lineColor = lineColor;
        [self setupContent];
        self.backgroundColor = backgroundColor;
    }
    return self;
}

- (void)setupContent {

    _lineView = [[UIView alloc] init];
    _lineView.translatesAutoresizingMaskIntoConstraints = NO;
    _lineView.backgroundColor =_lineColor;
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];

    _littleDotView = [[UIView alloc] init];
    _littleDotView.translatesAutoresizingMaskIntoConstraints = NO;
    _littleDotView.backgroundColor = RGB(255, 220, 0);
    [self addSubview:_littleDotView];
    [_littleDotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right);
        make.size.mas_equalTo(CGSizeMake(kLittleDotWidth, kLittleDotHeight));
    }];
}

- (void)littleDotHidden:(BOOL)hidden {
    _littleDotView.hidden = hidden;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}

@end
