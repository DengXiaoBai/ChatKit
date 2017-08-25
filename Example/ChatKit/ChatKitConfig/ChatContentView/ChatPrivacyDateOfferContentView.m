//
//  ChatPrivacyDateOfferContentView.m
//  ChatKit
//
//  Created by iCrany on 2017/6/5.
//
//

#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSImageView.h>
#import <ChatKit/SKSChatMessageModel.h>
#import "ChatPrivacyDateOfferContentView.h"
#import "ChatPrivacyDateOfferContentConfig.h"
#import "ChatPrivacyDateOfferMessageObject.h"
#import "ChatPrivacyDateOfferBtnView.h"
#import "ChatPrivacyActivityOfferCoverView.h"
#import "ChatPrivacyDateOfferCancelBtnView.h"

@interface ChatPrivacyDateOfferContentView() <ChatPrivacyDateOfferBtnViewDelegate>

@property (nonatomic, strong) ChatPrivacyDateOfferContentConfig *contentConfig;
@property (nonatomic, strong) ChatPrivacyDateOfferMessageObject *messageObject;
@property (nonatomic, strong) ChatPrivacyActivityOfferCoverView *topView;
@property (nonatomic, strong) ChatPrivacyDateOfferBtnView *btnView;
@property (nonatomic, strong) ChatPrivacyDateOfferCancelBtnView *cancelBtnView;
@end

@implementation ChatPrivacyDateOfferContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if(self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[ChatPrivacyDateOfferMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of ChatPrivacyDateOfferMessageObject class");
        return;
    }

    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
    self.topView = [[ChatPrivacyActivityOfferCoverView alloc] initWithMessageModel:self.messageModel];
    [self addSubview:self.topView];

    if (self.messageModel.message.messageSourceType != SKSMessageSourceTypeSend) {
        self.btnView = [[ChatPrivacyDateOfferBtnView alloc] initWithMessageModel:self.messageModel];
        self.btnView.delegate = self;
        [self addSubview:self.btnView];
    } else {
        if (self.messageObject.privacyDateOfferState != SKSPrivacyDateOfferStateReject && self.messageObject.privacyDateOfferState != SKSPrivacyDateOfferStateMet) {
            self.cancelBtnView = [[ChatPrivacyDateOfferCancelBtnView alloc] initWithMessageModel:self.messageModel];
            self.cancelBtnView.delegate = self;
            [self addSubview:self.cancelBtnView];
        }
    }

    self.bubbleImageView.hidden = YES;
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
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];


    [self.topView updateWithMessageModel:self.messageModel force:force];

    if (self.messageModel.message.messageSourceType != SKSMessageSourceTypeSend) {
        [self.btnView updateUIWithMessageModel:self.messageModel force:force];
    } else {
        if (self.messageObject.privacyDateOfferState != SKSPrivacyDateOfferStateReject && self.messageObject.privacyDateOfferState != SKSPrivacyDateOfferStateMet) {
            [self.cancelBtnView updateUIWithMessageModel:self.messageModel force:force];
        }
    }

    CGSize contentViewSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;

    CGSize dateJoinedContentSize = [ChatPrivacyActivityOfferCoverView getSizeWithMessageModel:self.messageModel];
    self.topView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, dateJoinedContentSize.width, dateJoinedContentSize.height);

    if (self.messageModel.message.messageSourceType != SKSMessageSourceTypeSend) {
        self.btnView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top + dateJoinedContentSize.height, dateJoinedContentSize.width, contentViewSize.height - dateJoinedContentSize.height);
    } else {
        if (self.messageObject.privacyDateOfferState != SKSPrivacyDateOfferStateReject && self.messageObject.privacyDateOfferState != SKSPrivacyDateOfferStateMet) {
            self.cancelBtnView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top + dateJoinedContentSize.height, dateJoinedContentSize.width, contentViewSize.height - dateJoinedContentSize.height);
        }
    }
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - SKSPrivacyActivityBtnViewDelegate
- (void)privacyActivityBtnIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(chatBaseContentViewBtnActionAtIndex:)]) {
        [self.delegate chatBaseContentViewBtnActionAtIndex:index];
    }
}

@end
