//
//  ChatPrivacyGiftOfferContentView.m
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import "ChatPrivacyGiftOfferContentView.h"
#import "ChatPrivacyGiftOfferMessageObject.h"
#import "ChatPrivacyGiftOfferContentConfig.h"
#import "ChatPrivacyGiftOfferView.h"


@interface ChatPrivacyGiftOfferContentView() <ChatPrivacyGiftOfferViewDelegate>

@property (nonatomic, strong) ChatPrivacyGiftOfferView *contentView;
@property (nonatomic, strong) ChatPrivacyGiftOfferMessageObject *messageObject;
@property (nonatomic, strong) ChatPrivacyGiftOfferContentConfig *contentConfig;

@end

@implementation ChatPrivacyGiftOfferContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[ChatPrivacyGiftOfferMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of ChatPrivacyGiftOfferMessageObject class");
    }

    self.contentView = [[ChatPrivacyGiftOfferView alloc] initWithMessageModel:self.messageModel];
    self.contentView.delegate = self;
    [self addSubview:self.contentView];

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

    UIEdgeInsets contentInset = self.messageModel.contentViewInsets;
    CGSize contentSize = self.messageModel.contentViewSize;

    self.contentView.frame = CGRectMake(contentInset.left, contentInset.top, contentSize.width, contentSize.height);
}

#pragma mark - SKSPrivacySendRosesViewDelegate
- (void)privacySendRosesViewButtonTapIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(chatBaseContentViewBtnActionAtIndex:)]) {
        [self.delegate chatBaseContentViewBtnActionAtIndex:index];
    }
}

@end
