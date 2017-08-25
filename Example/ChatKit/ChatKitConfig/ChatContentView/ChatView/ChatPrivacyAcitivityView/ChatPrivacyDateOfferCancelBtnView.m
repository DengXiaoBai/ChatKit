//
//  ChatPrivacyDateOfferCancelBtnView.m
//  ChatKit
//
//  Created by iCrany on 2017/7/31.
//  Copyright (c) 2017 iCrany. All rights reserved.
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/SKSExtendButtonView.h>
#import "ChatPrivacyDateOfferCancelBtnView.h"
#import "ChatPrivacyDateOfferBtnView.h"
#import "ChatPrivacyDateOfferMessageObject.h"
#import "ChatPrivacyDateOfferContentConfig.h"

@interface ChatPrivacyDateOfferCancelBtnView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatPrivacyDateOfferContentConfig *contentConfig;
@property (nonatomic, strong) ChatPrivacyDateOfferMessageObject *messageObject;

@property (nonatomic, strong) SKSExtendButtonView *cancelBtn;

@end

@implementation ChatPrivacyDateOfferCancelBtnView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
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

    self.backgroundColor = [UIColor clearColor];

    CGRect frame = CGRectMake(self.contentConfig.cancelBtnInsets.left, self.contentConfig.cancelBtnInsets.top, self.contentConfig.cancelBtnSize.width, self.contentConfig.cancelBtnSize.height);
    self.cancelBtn = [[SKSExtendButtonView alloc] initWithFrame:frame insetPoint:CGPointMake(0, 24)];
    [self.cancelBtn setTitle:self.messageObject.cancelBtnTitle forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:self.contentConfig.cancelBtnColor forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = self.contentConfig.cancelBtnFont;
    self.cancelBtn.backgroundColor = self.contentConfig.cancelBtnBgColor;
    self.cancelBtn.layer.cornerRadius = self.contentConfig.cancelBtnSize.height / 2;
    [self.cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];

}

#pragma mark - Event response
- (void)cancelBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(privacyActivityBtnIndex:)]) {
        [self.delegate privacyActivityBtnIndex:0];
    }
}

#pragma mark - Public method

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;

    switch (self.messageObject.privacyDateOfferState) {
        case SKSPrivacyDateOfferStateReject:
        case SKSPrivacyDateOfferStateMet: {
            self.hidden = YES;
            break;
        }
        default: {
            self.hidden = NO;
            break;
        }
    }
}

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel maxWidth:(CGFloat)maxWidth {
    ChatPrivacyDateOfferContentConfig *config = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    return CGSizeMake(config.cancelBtnInsets.left + config.cancelBtnSize.width + config.cancelBtnInsets.right, config.cancelBtnInsets.top + config.cancelBtnSize.height + config.cancelBtnInsets.bottom);
}


@end
