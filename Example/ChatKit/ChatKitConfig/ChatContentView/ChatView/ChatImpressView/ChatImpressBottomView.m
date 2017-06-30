//
//  SKSChatCompressBottomView.m
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>
#import "ChatImpressBottomView.h"
#import "ChatImpressMessageObject.h"
#import "ChatImpressContentConfig.h"

@interface ChatImpressBottomView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) ChatImpressMessageObject *messageObject;
@property (nonatomic, strong) ChatImpressContentConfig *contentConfig;

@property (nonatomic, strong) UIButton *goToImpressBtn;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation ChatImpressBottomView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        self.messageObject = self.messageModel.message.messageAdditionalObject;
        self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    switch (self.messageObject.impressStatus) {
        case SKSImpressStatusNotProgress: {
            [self addSubview:self.goToImpressBtn];
            [self addSubview:self.descLabel];

            self.descLabel.hidden = YES;//default is hidden
            break;
        }
        case SKSImpressStatusSuccess:
        case SKSImpressStatusInvalid: {
            [self addSubview:self.descLabel];
            break;
        }
        default: {
            NSAssert(NO, @"[Error]: Not support impressStatus");
            break;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (self.messageModel.message.messageId != messageModel.message.messageId && messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    self.descLabel.text = self.messageObject.bottomDesc;
    CGSize descSize = [self.descLabel sizeThatFits:CGSizeMake(self.contentConfig.cellWidth, FLT_MAX)];

    CGSize goToImpressBtnSize = [self.goToImpressBtn sizeThatFits:CGSizeMake(self.contentConfig.cellWidth, FLT_MAX)];
    self.goToImpressBtn.frame = CGRectMake(0, 0, goToImpressBtnSize.width, self.contentConfig.bottomDescHeight);

    switch (self.messageObject.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            self.descLabel.frame = CGRectMake(0, 0, descSize.width, descSize.height);
            self.descLabel.center = CGPointMake(self.descLabel.center.x, _contentConfig.bottomDescHeight / 2);

            self.goToImpressBtn.center = CGPointMake(self.goToImpressBtn.center.x, _contentConfig.bottomDescHeight / 2);
            break;
        }
        case SKSMessageSourceTypeReceive: {
            self.descLabel.frame = CGRectMake(self.contentConfig.cellWidth - descSize.width, 0, descSize.width, descSize.height);
            self.descLabel.center = CGPointMake(self.descLabel.center.x, _contentConfig.bottomDescHeight / 2);

            self.goToImpressBtn.frame = CGRectMake(self.contentConfig.cellWidth - goToImpressBtnSize.width, 0, goToImpressBtnSize.width, self.contentConfig.bottomDescHeight);
            self.goToImpressBtn.center = CGPointMake(self.goToImpressBtn.center.x, _contentConfig.bottomDescHeight / 2);
            break;
        }
        default: {
            break;
        }
    }

    switch (self.messageObject.impressStatus) {
        case SKSImpressStatusSuccess:
        case SKSImpressStatusInvalid: {
            self.goToImpressBtn.hidden = YES;
            self.descLabel.hidden = NO;
            break;
        }
        default: {
            self.descLabel.hidden = YES;
            self.goToImpressBtn.hidden = NO;
            break;
        }
    }
}


+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel {
    ChatImpressContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    return CGSizeMake(contentConfig.cellWidth, contentConfig.bottomDescHeight);
}

#pragma mark - Event Response
- (void)goToImpressBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(impressBottomViewDidTapBtnIndex:)]) {
        [self.delegate impressBottomViewDidTapBtnIndex:0];
    }
}

#pragma mark - getter/setter
- (UIButton *)goToImpressBtn {
    if (!_goToImpressBtn) {
        _goToImpressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goToImpressBtn setTitle:self.messageObject.goToImpressBtnTitle forState:UIControlStateNormal];
        [_goToImpressBtn addTarget:self action:@selector(goToImpressBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_goToImpressBtn setTitleColor:self.contentConfig.goToImpressColor forState:UIControlStateNormal];
        _goToImpressBtn.titleLabel.font = self.contentConfig.goToImpressFont;
    }
    return _goToImpressBtn;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.numberOfLines = 0;
        _descLabel.font = self.contentConfig.bottomDescFont;
        _descLabel.textColor = self.contentConfig.bottomDescColor;
        _descLabel.textAlignment = NSTextAlignmentRight;
    }
    return _descLabel;
}

@end
