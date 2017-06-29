//
//  SKSChatRecordingTipView.m
//  ChatKit
//
//  Created by iCrany on 2017/1/4.
//
//

#import "SKSChatRecordingTipView.h"
#import "SKSChatKeyboardConfig.h"
#import "View+MASAdditions.h"

@interface SKSChatRecordingTipView()

@property (nonatomic, strong) id<SKSChatKeyboardConfig> keyboardConfig;
@property (nonatomic, assign) SKSVoiceRecordState voiceRecordState;
@property (nonatomic, strong) UIImageView *imageView;//Tip 是图标的情况
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation SKSChatRecordingTipView

- (instancetype)initWithFrame:(CGRect)frame
               keyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig
             voiceRecordState:(SKSVoiceRecordState)voiceRecordState {
    self = [super initWithFrame:frame];
    if (self) {
        _keyboardConfig = keyboardConfig;
        _voiceRecordState = voiceRecordState;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_imageView) {
        NSString *imageName = [_keyboardConfig chatKeyboardRecordImageNameWithVoiceRecordState:_voiceRecordState];
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [self addSubview:_imageView];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }

    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _tipLabel.hidden = YES;//default is hidden
        _tipLabel.font = [_keyboardConfig chatKeyboardRecordCountTipTextFont];
        _tipLabel.textColor = [UIColor whiteColor];
        [self addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
}

- (void)updateWithVoiceRecordState:(SKSVoiceRecordState)voiceRecordState countDown:(NSInteger)countDown {
    _voiceRecordState = voiceRecordState;
    switch (voiceRecordState) {
        case SKSVoiceRecordStateCountDownStateInside: {
            _tipLabel.hidden = NO;
            _imageView.hidden = YES;
            NSInteger maxLimit = [_keyboardConfig chatKeyboardRecordMaxLimitCount];
            _tipLabel.text = [NSString stringWithFormat:@"%ld", (long)(maxLimit - countDown)];
            break;
        }
        default: {
            _tipLabel.hidden = YES;
            _imageView.hidden = NO;
            NSString *imageName = [_keyboardConfig chatKeyboardRecordImageNameWithVoiceRecordState:_voiceRecordState];
            _imageView.image = [UIImage imageNamed:imageName];
            break;
        }
    }
}

@end
