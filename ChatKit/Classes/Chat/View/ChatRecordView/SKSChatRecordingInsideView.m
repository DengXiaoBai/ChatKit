//
//  SKSChatRecordingInsideView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/31.
//
//

#import "SKSChatRecordingInsideView.h"
#import "SKSChatKeyboardConfig.h"
#import "View+MASAdditions.h"
#import "SKSVolumeDecibelView.h"
#import "UIColor+SKS.h"

@interface SKSChatRecordingInsideView()

@property (nonatomic, strong) id<SKSChatKeyboardConfig> keyboardConfig;
@property (nonatomic, strong) UIImageView *recordingImageView;
@property (nonatomic, strong) SKSVolumeDecibelView *volumeDecibelView;

@end

@implementation SKSChatRecordingInsideView

- (instancetype)initWithFrame:(CGRect)frame keyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig {
    self = [super initWithFrame:frame];
    if (self) {
        _keyboardConfig = keyboardConfig;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    NSString *imageName = [_keyboardConfig chatKeyboardRecordImageNameWithVoiceRecordState:SKSVoiceRecordStateRecordingInSide];
    if (!_recordingImageView) {
        _recordingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [self addSubview:_recordingImageView];
        _recordingImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_recordingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_centerX).offset(-15);
        }];
    }

    CGSize volumeDecibelSize = CGSizeMake(52, 84);
    if (!_volumeDecibelView) {
        _volumeDecibelView = [[SKSVolumeDecibelView alloc] initWithViewSize:volumeDecibelSize];
        [self addSubview:_volumeDecibelView];
        _volumeDecibelView.translatesAutoresizingMaskIntoConstraints = NO;
        [_volumeDecibelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_recordingImageView.mas_bottom);
            make.left.equalTo(self.mas_centerX).offset(15);
            make.size.mas_equalTo(volumeDecibelSize);//TODO: 需要进行计算的, 弄成可配置的方式, 可以放 3 个 Cell
        }];
    }
}

#pragma mark - Helper method
- (void)clearResource {
    [_volumeDecibelView clearResource];
}

- (void)updateLevel:(NSInteger)level {
    [_volumeDecibelView updateLevel:level];
}

- (void)startVoiceRecording {
    [_volumeDecibelView startVoiceRecording];
}

@end
