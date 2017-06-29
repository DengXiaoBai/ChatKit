//
//  SKSVoiceLoadingView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSVoiceLoadingView.h"
#import <Masonry/MASConstraint.h>
#import <Masonry/Masonry.h>
#import "UIImageView+SKS.h"

@interface SKSVoiceLoadingView()

@property (nonatomic, strong) UIImage *bottomImage;
@property (nonatomic, strong) UIImageView *bottomImageView;//底部不动的图层

@property (nonatomic, strong) UIImage *topImage;
@property (nonatomic, strong) UIImageView *topImageView;//顶部进行360度旋转的动画层

@end

@implementation SKSVoiceLoadingView

- (instancetype)initWithBottomImage:(UIImage *)bottomImage topImage:(UIImage *)topImage {
    self = [super init];
    if (self) {
        self.bottomImage = bottomImage;
        self.topImage = topImage;
        [self setupContent];
    }
    return self;
}

- (void)setupContent {
    _bottomImageView = [[UIImageView alloc] initWithImage:_bottomImage];
    _bottomImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_bottomImageView];
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];

    _topImageView = [[UIImageView alloc] initWithImage:_topImage];
    _topImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_topImageView];
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

#pragma mark - Helper Method
- (void)doAnimation:(BOOL)isAnimation {
    if (isAnimation) {
        self.hidden = NO;
        [_topImageView startRotation];
    } else {
        self.hidden = YES;
        [_topImageView stopRotation];
    }
}

@end
