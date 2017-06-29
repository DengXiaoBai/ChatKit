//
//  ChatPrivacyDateOfferBtnView.m
//  ChatKit
//
//  Created by iCrany on 2017/6/7.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import "ChatPrivacyDateOfferBtnView.h"
#import "ChatPrivacyGiftOfferDescView.h"
#import "ChatPrivacyDateOfferContentConfig.h"
#import "ChatPrivacyDateOfferMessageObject.h"
#import <Masonry/Masonry.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import <ChatKit/UIImage+SKS.h>

@interface ChatPrivacyDateOfferBtnView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatPrivacyDateOfferContentConfig *contentConfig;
@property (nonatomic, strong) ChatPrivacyDateOfferMessageObject *messageObject;


@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *middleBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation ChatPrivacyDateOfferBtnView

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

    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setTitle:self.messageObject.leftBtnTitle forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:self.contentConfig.btnColor forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:self.contentConfig.btnDisableColor forState:UIControlStateDisabled];
    [self.leftBtn setBackgroundImage:[UIImage imageWithColor:UIColor.lightGrayColor] forState:UIControlStateHighlighted];
    self.leftBtn.titleLabel.font = self.contentConfig.btnFont;
    self.leftBtn.backgroundColor = self.contentConfig.backgroundColor;
    self.leftBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.leftBtn];
    self.leftBtn.tag = 0;
    self.leftBtn.layer.cornerRadius = self.contentConfig.btnCornerRadius;
    self.leftBtn.layer.masksToBounds = YES;
    self.leftBtn.layer.borderColor = self.contentConfig.btnBorderColor.CGColor;
    self.leftBtn.layer.borderWidth = 1;
    [self.leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.contentConfig.btnInsets.top);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.contentConfig.btnSize.width, self.contentConfig.btnSize.height));
    }];

    self.middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.middleBtn setTitle:self.messageObject.middleBtnTitle forState:UIControlStateNormal];
    [self.middleBtn setTitleColor:self.contentConfig.btnColor forState:UIControlStateNormal];
    [self.middleBtn setTitleColor:self.contentConfig.btnDisableColor forState:UIControlStateDisabled];
    [self.middleBtn setBackgroundImage:[UIImage imageWithColor:UIColor.lightGrayColor] forState:UIControlStateHighlighted];
    self.middleBtn.titleLabel.font = self.contentConfig.btnFont;
    self.middleBtn.backgroundColor = self.contentConfig.backgroundColor;
    self.middleBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.middleBtn.tag = 1;
    self.middleBtn.layer.cornerRadius = self.contentConfig.btnCornerRadius;
    self.middleBtn.layer.masksToBounds = YES;
    self.middleBtn.layer.borderColor = self.contentConfig.btnBorderColor.CGColor;
    self.middleBtn.layer.borderWidth = 1;
    [self.middleBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.middleBtn];
    [self.middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.contentConfig.btnInsets.top);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.contentConfig.btnSize.width, self.contentConfig.btnSize.height));
    }];

    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitle:self.messageObject.rightBtnTitle forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:self.contentConfig.btnColor forState:UIControlStateNormal];
    [self.rightBtn setBackgroundImage:[UIImage imageWithColor:UIColor.lightGrayColor] forState:UIControlStateHighlighted];
    self.rightBtn.titleLabel.font = self.contentConfig.btnFont;
    self.rightBtn.backgroundColor = self.contentConfig.backgroundColor;
    self.rightBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.rightBtn.tag = 2;
    self.rightBtn.layer.cornerRadius = self.contentConfig.btnCornerRadius;
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.layer.borderColor = self.contentConfig.btnBorderColor.CGColor;
    self.rightBtn.layer.borderWidth = 1;
    [self.rightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(self.contentConfig.btnInsets.top);
        make.right.equalTo(self.mas_right);
        make.size.mas_equalTo(CGSizeMake(self.contentConfig.btnSize.width, self.contentConfig.btnSize.height));
    }];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;

    switch (self.messageObject.privacyActivityState) {
        case SKSPrivacyActivityStateThinkAbout: {
            self.middleBtn.enabled = NO;
            break;
        }
        case SKSPrivacyActivityStateAccept: {
            [self.leftBtn setTitleColor:self.contentConfig.btnDisableColor forState:UIControlStateNormal];
            [self.leftBtn setTitle:self.messageObject.acceptedBtnTitle  forState:UIControlStateNormal];
            self.leftBtn.enabled = NO;
            self.middleBtn.hidden = YES;
            self.rightBtn.hidden = YES;
            break;
        }
        case SKSPrivacyActivityStateReject: {
            [self.leftBtn setTitleColor:self.contentConfig.btnDisableColor forState:UIControlStateNormal];
            [self.leftBtn setTitle:self.messageObject.rejectedBtnTitle forState:UIControlStateNormal];
            self.leftBtn.enabled = NO;
            self.middleBtn.hidden = YES;
            self.rightBtn.hidden = YES;
            break;
        }
        default: {
            break;
        }
    }

    if (self.messageObject.privacyActivityState == SKSPrivacyActivityStateThinkAbout) {
        self.middleBtn.enabled = NO;
    }

}

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel maxWidth:(CGFloat)maxWidth {
    ChatPrivacyDateOfferContentConfig *config = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];

    UIEdgeInsets btnInsets = config.btnInsets;
    CGSize btnSize = config.btnSize;

    CGSize contentSize = CGSizeMake(maxWidth, btnInsets.top + btnSize.height + btnInsets.bottom);
    return contentSize;
}


#pragma mark - Event Response
- (void)btnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(privacyActivityBtnIndex:)]) {
        [self.delegate privacyActivityBtnIndex:sender.tag];
    }
}


@end
