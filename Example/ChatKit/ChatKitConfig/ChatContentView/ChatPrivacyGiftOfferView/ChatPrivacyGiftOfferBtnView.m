//
//  ChatPrivacyGiftOfferBtnView.m
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//

#import "ChatPrivacyGiftOfferBtnView.h"
#import "ChatPrivacyGiftOfferContentConfig.h"
#import "ChatPrivacyGiftOfferMessageObject.h"
#import <Masonry/Masonry.h>
#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>

@interface ChatPrivacyGiftOfferBtnView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatPrivacyGiftOfferContentConfig *contentConfig;
@property (nonatomic, strong) ChatPrivacyGiftOfferMessageObject *messageObject;

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation ChatPrivacyGiftOfferBtnView

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

    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setTitleColor:self.contentConfig.leftBtnTitleColor forState:UIControlStateNormal];
    [self.leftBtn setTitle:self.messageObject.leftBtnTitle forState:UIControlStateNormal];
    self.leftBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.leftBtn setTitle:self.messageObject.leftBtnTitle forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];
    self.leftBtn.tag = 0;

    UIEdgeInsets leftBtnInsets = self.contentConfig.leftBtnInsets;
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(-leftBtnInsets.right);
        make.centerY.equalTo(self.mas_centerY);
    }];

    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = self.contentConfig.lineColor;
    self.lineView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(self.contentConfig.vLineInsets.top);
        make.height.mas_equalTo(self.contentConfig.bottomViewHeight - self.contentConfig.vLineInsets.top - self.contentConfig.vLineInsets.bottom);
        make.width.mas_equalTo(1);
    }];

    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitleColor:self.contentConfig.rightBtnTitleColor forState:UIControlStateNormal];
    [self.rightBtn setTitle:self.messageObject.rightBtnTitle forState:UIControlStateNormal];
    self.rightBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.rightBtn addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBtn];
    self.rightBtn.tag = 1;

    UIEdgeInsets rightBtnInsets = self.contentConfig.rightBtnInsets;
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(rightBtnInsets.left);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
}


#pragma mark - Event Response
- (void)tapButtonAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(privacyGiftOfferButtonTapIndex:)]) {
        [self.delegate privacyGiftOfferButtonTapIndex:button.tag];
    }
}


@end
