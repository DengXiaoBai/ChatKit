//
//  SKSChatVoiceContentView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatVoiceContentView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSVoiceMessageView.h"
#import "SKSImageView.h"
#import "SKSVoiceMessageObject.h"
#import "UIColor+SKS.h"

@interface SKSChatVoiceContentView() <SKSVoiceMessageViewDelegate>

@property (nonatomic, strong) SKSVoiceMessageView *voiceMessageView;
@property (nonatomic, strong) SKSVoiceMessageObject *messageObject;

@end

@implementation SKSChatVoiceContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[SKSVoiceMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of SKSVoiceMessageObject class");
        return;
    }
    _messageObject = self.messageModel.message.messageAdditionalObject;

    if (!_voiceMessageView) {
        _voiceMessageView = [[SKSVoiceMessageView alloc] initWithMessage:self.messageModel];
        _voiceMessageView.delegate = self;
        [self addSubview:_voiceMessageView];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];

    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    [super updateUIWithMessageModel:messageModel force:force];

    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;

    switch (_messageObject.voicePlayState) {
        case SKSVoicePlayStateNormal: {
            break;
        }
        case SKSVoicePlayStatePause: {
            [_voiceMessageView pausePlayVoice];
            break;
        }
        case SKSVoicePlayStatePlaying: {
            [_voiceMessageView playProgressWithPosition:_messageObject.positionMs duration:_messageObject.durationMs];
            break;
        }
        case SKSVoicePlayStateStop: {
            [_voiceMessageView stopPlayVoice];
            break;
        }
        case SKSVoicePlayStateStartPlay:
        case SKSVoicePlayStateStartPlayFromPause: {
            [_voiceMessageView startOrResumePlayVoice];
            break;
        }
        default: {
            break;
        }
    }

    [_voiceMessageView changeMessageStatus:self.messageModel.message.messageDeliveryState];

    CGSize contentViewSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;

    //这里有点特殊，因为要做全局的进度条动画，所以contentView == bubbleView 视图，修改 contentViewInsets 的参数是在 SKSVoiceMessageView 的 leftPadding, rightPadding, topPadding, bottomPadding 参数修改
    _voiceMessageView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
    _voiceMessageView.layer.mask = self.bubbleImageView.layer;
    _voiceMessageView.layer.masksToBounds = YES;
}


#pragma mark - SKSVoiceMessageViewDelegate
- (void)voiceMessageViewDidTapStartOrStopButton:(SKSVoiceMessageView *)view {
    if ([self.delegate respondsToSelector:@selector(chatMessageContentDidTapAction)]) {
        [self.delegate chatMessageContentDidTapAction];
    }
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}


@end
