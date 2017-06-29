//
//  SKSChatRecordingOutsideView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/31.
//
//

#import "SKSChatRecordingOutsideView.h"
#import "View+MASAdditions.h"
#import "SKSChatKeyboardConfig.h"
#import "SKSChatMessageConstant.h"

@interface SKSChatRecordingOutsideView()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) id<SKSChatKeyboardConfig> keyboardConfig;

@end

@implementation SKSChatRecordingOutsideView

- (instancetype)initWithFrame:(CGRect)frame keyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig {
    self = [super initWithFrame:frame];
    if (self) {
        _keyboardConfig = keyboardConfig;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_iconImageView) {
        NSString *imageName = [_keyboardConfig chatKeyboardRecordImageNameWithVoiceRecordState:SKSVoiceRecordStateRecordingOutside];
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [self addSubview:_iconImageView];
        _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_iconImageView.image.size);
            make.center.equalTo(self);
        }];
    }
}

+ (CGSize)getViewSizeWithKeyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig {
    return [UIImage imageNamed:[keyboardConfig chatKeyboardRecordImageNameWithVoiceRecordState: SKSVoiceRecordStateRecordingOutside]].size;
}

@end
