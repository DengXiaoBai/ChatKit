//
//  ChatPrivacyGiftOfferDescView.m
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//

#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/UIColor+SKS.h>
#import "ChatPrivacyGiftOfferDescView.h"
#import "ChatPrivacyGiftOfferMessageObject.h"
#import "ChatPrivacyGiftOfferContentConfig.h"

@interface ChatPrivacyGiftOfferDescView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatPrivacyGiftOfferContentConfig *contentConfig;
@property (nonatomic, strong) ChatPrivacyGiftOfferMessageObject *messageObject;

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation ChatPrivacyGiftOfferDescView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[ChatPrivacyGiftOfferMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of ChatPrivacyGiftOfferMessageObject class");
        return;
    }

    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    self.descLabel = [[UILabel alloc] init];
    self.descLabel.textColor = self.contentConfig.bottomDescColor;
    self.descLabel.font = self.contentConfig.bottomDescFont;
    self.descLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.descLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    self.descLabel.text = self.messageObject.bottomDescContent;

    UIEdgeInsets descLabelInset = self.contentConfig.bottomDescInsets;
    self.descLabel.frame = CGRectMake(descLabelInset.left, descLabelInset.top, self.frame.size.width - descLabelInset.left - descLabelInset.right, self.frame.size.height - descLabelInset.top - descLabelInset.bottom);
}


@end
