//
//  SKSChatRealVoiceAndVideoContentView.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright (c) 2016 iCrany. All rights reserved.
//

#import "SKSChatRealTimeVideoOrVoiceContentView.h"
#import "SKSRealTimeVideoOrVoiceView.h"
#import "SKSChatMessageModel.h"
#import "SKSImageView.h"
#import "SKSChatMessage.h"

@interface SKSChatRealTimeVideoOrVoiceContentView()

@property (nonatomic, strong) SKSRealTimeVideoOrVoiceView *realTimeVideoOrVoiceView;

@end

@implementation SKSChatRealTimeVideoOrVoiceContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_realTimeVideoOrVoiceView) {
        _realTimeVideoOrVoiceView = [[SKSRealTimeVideoOrVoiceView alloc] initWithMessageModel:self.messageModel];
        [self addSubview:_realTimeVideoOrVoiceView];
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

    //检测类型
    if (messageModel.message.messageMediaType != SKSMessageMediaTypeRealTimeVideo
            && messageModel.message.messageMediaType != SKSMessageMediaTypeRealTimeVoice) {
        DLog(@"[Error] in SKSChatRealTimeVideoOrVoiceContentView but messageMediaType != SKSMessageMediaTypeRealTimeVideo && messageMediaType != SKSMessageMediaTypeRealTimeVoice");
        return;
    }

    self.messageModel = messageModel;

    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;
    CGSize contentViewSize = self.messageModel.contentViewSize;

    [_realTimeVideoOrVoiceView updateWithMessageModel:messageModel force:force];
    _realTimeVideoOrVoiceView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
