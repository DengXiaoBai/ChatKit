//
//  SKSChatRecordView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/31.
//
//

#import "SKSChatRecordView.h"
#import "SKSChatRecordingInsideView.h"
#import "SKSChatRecordingOutsideView.h"
#import "SKSChatKeyboardConfig.h"
#import "SKSChatRecordingTipView.h"

#define kChatRecordViewSize CGSizeMake(203, 186)
#define kChatRecordViewBottomLabelInsets UIEdgeInsetsMake(10, 10, 10, 10)
#define kChatRecordViewBottomLabelTextColor RGB(255, 55, 55)

static CGFloat kChatRecordViewBottomLabelHeight = 21;

@interface SKSChatRecordView()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) id<SKSChatKeyboardConfig> keyboardConfig;

@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) SKSChatRecordingInsideView *progressView;
@property (nonatomic, strong) SKSChatRecordingOutsideView *cancelView;
@property (nonatomic, strong) SKSChatRecordingTipView *tipView;

@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation SKSChatRecordView

- (instancetype)initWithKeyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig {
    self = [super init];
    if (self) {
        _keyboardConfig = keyboardConfig;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;

    NSArray *windows = [[UIApplication sharedApplication] windows];
    UIWindow *lastWindow = (UIWindow *) [windows lastObject];

    _window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kChatRecordViewSize.width, kChatRecordViewSize.height)];
    _window.center = CGPointMake(screen_width / 2, screen_height / 2);
    _window.windowLevel = lastWindow.windowLevel + 1;
    _window.rootViewController = [[UIViewController alloc] init];

    _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kChatRecordViewSize.width, kChatRecordViewSize.height)];
    _backgroundView.layer.cornerRadius = 6;
    _backgroundView.layer.masksToBounds = YES;

    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
        [_backgroundView addSubview:_effectView];
        _effectView.alpha = 0.66;
        _effectView.frame = CGRectMake(0, 0, kChatRecordViewSize.width, kChatRecordViewSize.height);
    }

    CGRect frame = CGRectMake(0, 0, kChatRecordViewSize.width, kChatRecordViewSize.height - kChatRecordViewBottomLabelHeight - kChatRecordViewBottomLabelInsets.top - kChatRecordViewBottomLabelInsets.bottom);
    if (!_tipView) {
        _tipView = [[SKSChatRecordingTipView alloc] initWithFrame:frame keyboardConfig:_keyboardConfig voiceRecordState:SKSVoiceRecordStateTooShort];
        [_backgroundView addSubview:_tipView];
        _tipView.hidden = YES;
    }

    if (!_progressView) {
        _progressView = [[SKSChatRecordingInsideView alloc] initWithFrame:frame keyboardConfig:_keyboardConfig];
        [_backgroundView addSubview:_progressView];
    }

    if (!_cancelView) {
        _cancelView = [[SKSChatRecordingOutsideView alloc] initWithFrame:frame keyboardConfig:_keyboardConfig];
        [_backgroundView addSubview:_cancelView];
        _cancelView.hidden = YES;
    }

    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        [_backgroundView addSubview:_bottomLabel];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = [UIColor whiteColor];
        _bottomLabel.frame = CGRectMake(kChatRecordViewBottomLabelInsets.left,
                kChatRecordViewSize.height - kChatRecordViewBottomLabelHeight - kChatRecordViewBottomLabelInsets.bottom,
                kChatRecordViewSize.width - kChatRecordViewBottomLabelInsets.left - kChatRecordViewBottomLabelInsets.right,
                kChatRecordViewBottomLabelHeight);
    }

    _bottomLabel.text = [_keyboardConfig chatKeyboardRecordBottomTextWithVoiceRecordState:SKSVoiceRecordStateStart];
}

#pragma mark - Helper method
- (void)showChatRecordView {
    [_window makeKeyAndVisible];
    [_window addSubview:_backgroundView];
    self.hidden = NO;
}

- (void)dismissChatRecordView {
    [self clearResource];
    [UIView animateWithDuration:0.3 animations:^{
        _backgroundView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(chatRecordViewDidDismiss)]) {
            [self.delegate chatRecordViewDidDismiss];
        }

        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
        _window = nil;
    }];
}

- (void)updateUIWithRecordState:(SKSVoiceRecordState)voiceRecordState countDown:(NSInteger)countDown {
    _bottomLabel.text = [_keyboardConfig chatKeyboardRecordBottomTextWithVoiceRecordState:voiceRecordState];

    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    switch (voiceRecordState) {
        case SKSVoiceRecordStateStart: {//外部调用是否开始录音，因为开启录音是一个耗时操作
            _cancelView.hidden = YES;
            _tipView.hidden = YES;
            _progressView.hidden = NO;
            _bottomLabel.textColor = [UIColor whiteColor];
            [_progressView startVoiceRecording];//开始录制语音消息
            break;
        }
        case SKSVoiceRecordStateRecordingInSide: {
            _cancelView.hidden = YES;
            _tipView.hidden = YES;
            _progressView.hidden = NO;
            _bottomLabel.textColor = [UIColor whiteColor];
            break;
        }
        case SKSVoiceRecordStateCountDownStateOutside:
        case SKSVoiceRecordStateRecordingOutside: {
            _cancelView.hidden = NO;
            _progressView.hidden = YES;
            _tipView.hidden = YES;
            _bottomLabel.textColor = kChatRecordViewBottomLabelTextColor;
            break;
        }
        case SKSVoiceRecordStateOverLimit: {
            _cancelView.hidden = YES;
            _progressView.hidden = YES;
            _tipView.hidden = NO;
            _bottomLabel.textColor = [UIColor whiteColor];
            [_tipView updateWithVoiceRecordState:voiceRecordState countDown:0];
            break;
        }
        case SKSVoiceRecordStateTooShort: {
            _cancelView.hidden = YES;
            _progressView.hidden = YES;
            _tipView.hidden = NO;
            _bottomLabel.textColor = [UIColor whiteColor];
            [_tipView updateWithVoiceRecordState:voiceRecordState countDown:0];
            [self performSelector:@selector(dismissChatRecordView) withObject:nil afterDelay:1];
            break;
        }
        case SKSVoiceRecordStateCountDownStateInside: {
            if (countDown != 0) {//防止 0 跟 SKSVoiceRecordStateOverLimit 的 UI 冲突
                _cancelView.hidden = YES;
                _progressView.hidden = YES;
                _tipView.hidden = NO;
                _bottomLabel.textColor = [UIColor whiteColor];
                [_tipView updateWithVoiceRecordState:voiceRecordState countDown:countDown];
            }
            break;
        }
        default : {
            [self dismissChatRecordView];
            break;
        }
    }
}

- (void)clearResource {
    [_progressView clearResource];
}

- (void)updateLevel:(NSInteger)level {
    [_progressView updateLevel:level];
}



@end
