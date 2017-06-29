//
//  SKSChatDateJoinedPreviewContentView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/29.
//
//

#import "SKSChatDateJoinedPreviewContentView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatSessionConfig.h"
#import "SKSDateJoinedPreviewContentConfig.h"
#import "SKSDateJoinedPreviewView.h"
#import "SKSChatMessage.h"
#import "SKSImageView.h"

@interface SKSChatDateJoinedPreviewContentView()

@property (nonatomic, strong) SKSDateJoinedPreviewContentConfig *contentConfig;
@property (nonatomic, strong) SKSDateJoinedPreviewView *dateJoinedPreviewView;

@end

@implementation SKSChatDateJoinedPreviewContentView

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
        _dateJoinedPreviewView = [[SKSDateJoinedPreviewView alloc] initWithMessageModel:self.messageModel];
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
