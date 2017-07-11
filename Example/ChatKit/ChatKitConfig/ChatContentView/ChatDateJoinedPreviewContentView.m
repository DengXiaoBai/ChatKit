//
//  ChatDateJoinedPreviewContentView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/29.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSImageView.h>
#import "ChatDateJoinedPreviewContentView.h"
#import "ChatDateJoinedPreviewContentConfig.h"
#import "ChatDateJoinedPreviewView.h"

@interface ChatDateJoinedPreviewContentView()

@property (nonatomic, strong) ChatDateJoinedPreviewContentConfig *contentConfig;
@property (nonatomic, strong) ChatDateJoinedPreviewView *dateJoinedPreviewView;

@end

@implementation ChatDateJoinedPreviewContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_dateJoinedPreviewView) {
        _dateJoinedPreviewView = [[ChatDateJoinedPreviewView alloc] initWithMessageModel:self.messageModel];
        [self addSubview:_dateJoinedPreviewView];
    }
}


- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    [super updateUIWithMessageModel:messageModel force:force];

    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    if (self.messageModel.message.messageSourceType == SKSMessageSourceTypeCenter
            || self.messageModel.message.messageSourceType == SKSMessageSourceTypeSendCenter
            || self.messageModel.message.messageSourceType == SKSMessageSourceTypeReceiveCenter) {
        self.bubbleImageView.hidden = YES;
    }

    self.messageModel = messageModel;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    [self.dateJoinedPreviewView updateWithMessageModel:self.messageModel force:force];

    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;
    CGSize contentViewSize = self.messageModel.contentViewSize;

    _dateJoinedPreviewView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
}

@end
