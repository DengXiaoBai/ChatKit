//
//  EmotionFullScreenPreviewView.m
//  AtFirstSight
//
//  Created by iCrany on 15/12/24.
//  Copyright (c) 2015 Sachsen. All rights reserved.
//

#import <pop/POPAnimatableProperty.h>
#import <pop/POPSpringAnimation.h>
#import <pop/POPBasicAnimation.h>
#import <Masonry/MASConstraintMaker.h>
#import <Masonry/View+MASAdditions.h>
#import <YYImage/YYAnimatedImageView.h>
#import <YYImage/YYImage.h>
#import "SKSEmotionFullScreenPreviewView.h"
#import "SKSChatMessageConstant.h"


//static CGFloat kEmoticonFullScreenPreviewLeftPadding = 15.0f;
//static CGFloat kEmoticonFullScreenPreviewRightPadding = 15.0f;
//static CGFloat kEmoticonDescLabelTop2ApngBottomPadding = 5.0f;

static BOOL isOpenEmoticonDescNameFunticon = NO;

@interface SKSEmotionFullScreenPreviewView()

@property (nonatomic, strong) NSDictionary *emotionDict;
@property (nonatomic, strong) YYAnimatedImageView *apngImageView2;


@property (nonatomic, strong) UIWindow *mainWindow;

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation SKSEmotionFullScreenPreviewView

- (instancetype)initWithEmotionDict:(NSDictionary *)emotionDict {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.emotionDict = emotionDict;
        [self setupContentView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.emotionDict = nil;
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView {

    CGFloat screen_width = UIScreen.mainScreen.bounds.size.width;
    CGFloat screen_height = UIScreen.mainScreen.bounds.size.height;
    _mainWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    _mainWindow.windowLevel = UIWindowLevelStatusBar;
    _mainWindow.rootViewController = [[UIViewController alloc] init];


    self.backgroundColor = RGBA(0, 0, 0, 0.2);
    self.hidden = YES;

//    NSData *data = [[SKSEmotionManager shareManager] getEmotionData:_emotionDict];
    //TODO: get Emoticon Data
    NSData *data = nil;
    YYImage *apngImage = nil;
    if (data) {
        apngImage = [YYImage imageWithData:data];
    }

    _apngImageView2 = [[YYAnimatedImageView alloc] initWithImage:apngImage];
    _apngImageView2.translatesAutoresizingMaskIntoConstraints = NO;
    _apngImageView2.autoPlayAnimatedImage = YES;
    _apngImageView2.runloopMode = NSDefaultRunLoopMode;
    [self addSubview:_apngImageView2];

    [_apngImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-60);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];

    if (isOpenEmoticonDescNameFunticon) {
//        _descLabel = [UIView createLabelWithText:nil textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:11] textColor:RGB(132, 132, 132)];
//        [self addSubview:_descLabel];
//        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_centerY).offset(kEmoticonDescLabelTop2ApngBottomPadding);
//            make.left.equalTo(self.mas_left).offset(kEmoticonFullScreenPreviewLeftPadding);
//            make.right.equalTo(self.mas_right).offset(-kEmoticonFullScreenPreviewRightPadding);
//        }];
    }
}

#pragma mark - Helper Method
- (void)resetEmotionDict:(NSDictionary *)emotionDict {
//    NSData *data = [[SKSEmotionManager shareManager] getEmotionData:emotionDict];
    
    //TODO: Get Emoticon Data
    NSData *data = nil;
    YYImage *apngImage;
    if (data) {
        apngImage = [[YYImage alloc] initWithData:data];
    }

    _apngImageView2.image = apngImage;
    _apngImageView2.autoPlayAnimatedImage = YES;

    if (isOpenEmoticonDescNameFunticon) {
        //reset descLabel text
//        NSString *descText;
//#ifdef EN
//        descText = [emotionDict objectForKey:kEMOTION_NAME];
//#else
//        descText = [emotionDict objectForKey:kEMOTION_NAME_ZH];
//#endif
//
//        _descLabel.text = descText;
//        [_descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.mas_centerY).offset(kEmoticonDescLabelTop2ApngBottomPadding);
//            make.left.equalTo(self.mas_left).offset(kEmoticonFullScreenPreviewLeftPadding);
//            make.right.equalTo(self.mas_right).offset(-kEmoticonFullScreenPreviewRightPadding);
//        }];
    }
}

- (void)doShow:(BOOL)isShow {

    CGFloat screen_width = UIScreen.mainScreen.bounds.size.width;
    CGFloat screen_height = UIScreen.mainScreen.bounds.size.height;
    
    if (isShow) {
        self.hidden = !isShow;
        _mainWindow.hidden = NO;
//        [_mainWindow makeKeyAndVisible];//will hide keyboard in iOS10
        [_mainWindow addSubview: self];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_mainWindow);
        }];

        //动画2
        POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(screen_width/2, screen_height/2 - 60)];

        [_apngImageView2.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];

        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
        scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];

        [_apngImageView2.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];

    } else {
        [self pauseAllAnimations:YES forLayer:_apngImageView2.layer];

        POPBasicAnimation *positionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(screen_width/2, screen_height/2 - 60)];
        [_apngImageView2.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];

        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
        scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
        [_apngImageView2.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];


        scaleAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            _mainWindow.hidden = YES;
            self.hidden = !isShow;
            [self removeFromSuperview];
        };
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - Public Method
- (void)showEmotionFullScreenPreviewView:(BOOL)isShow {
    [self doShow:isShow];
}

- (void)pauseAllAnimations:(BOOL)pause forLayer:(CALayer *)layer {
    for (NSString *key in layer.pop_animationKeys) {
        POPAnimation *animation = [layer pop_animationForKey:key];
        [animation setPaused:pause];
    }
}

@end
