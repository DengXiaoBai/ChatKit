//
//  SKSRealTimeVideoAndVoiceView.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright (c) 2016 iCrany. All rights reserved.
//

#import "SKSRealTimeVideoOrVoiceView.h"
#import "SKSChatMessageModel.h"
#import "SKSRealTimeVideoOrVoiceMessageObject.h"
#import "SKSChatMessage.h"
#import "SKSRealTimeVideoOrVoiceContentConfig.h"
#import "SKSChatSessionConfig.h"
#import "UIColor+SKS.h"

@interface SKSRealTimeVideoOrVoiceView()

@property (nonatomic, strong) SKSChatMessageModel *messageModel;
@property (nonatomic, strong) SKSRealTimeVideoOrVoiceMessageObject *messageObject;
@property (nonatomic, strong) SKSRealTimeVideoOrVoiceContentConfig *contentConfig;

@property (nonatomic, strong) UIImageView *callImageView;
@property (nonatomic, strong) UILabel *callLabel;

@end

@implementation SKSRealTimeVideoOrVoiceView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super init];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[SKSRealTimeVideoOrVoiceMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of SKSRealTimeVideoOrVoiceMessageObject class");
        return;
    }

    _messageObject = self.messageModel.message.messageAdditionalObject;
    _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    if (!_callImageView) {
        _callImageView = [[UIImageView alloc] init];
        [self addSubview:_callImageView];
    }

    if (!_callLabel) {
        _callLabel = [[UILabel alloc] init];
        _callLabel.numberOfLines = 1;
        _callLabel.font = _contentConfig.descLabelFont;
        _callLabel.textColor = _contentConfig.descLabelColor;
        [self addSubview:_callLabel];
    }

    _callImageView.image = [_messageObject realTimeVideoOrVoiceIconImage];
    _callLabel.text = [_messageObject realTimeVideoOrVoiceIconDescription];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateWithMessageModel:_messageModel force:YES];
}

#pragma mark - Public method
+ (CGSize)realTimeVideoOrVoiceSizeWithMessageModel:(SKSChatMessageModel *)messageModel {

    SKSRealTimeVideoOrVoiceContentConfig *contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    SKSRealTimeVideoOrVoiceMessageObject *messageObject = messageModel.message.messageAdditionalObject;

    static UILabel *callLabel;
    if (callLabel == nil) {
        callLabel = [UILabel alloc];
        callLabel.font = contentConfig.descLabelFont;
        callLabel.numberOfLines = 1;
    }

    callLabel.text = messageObject.realTimeVideoOrVoiceIconDescription;
    CGSize callLabelSize = [callLabel sizeThatFits:CGSizeMake(UIScreen.mainScreen.bounds.size.width, FLT_MAX)];
    UIEdgeInsets callLabelInset = contentConfig.descLabelInsets;

    UIImage *iconImage = messageObject.realTimeVideoOrVoiceIconImage;
    CGSize iconImageSize = iconImage.size;
    UIEdgeInsets iconImageInset = contentConfig.iconImageInsets;

    CGSize resultSize = CGSizeMake(callLabelInset.left + callLabelSize.width + callLabelInset.right + iconImageInset.left + iconImageSize.width + iconImageInset.right,
            MAX(callLabelInset.top + callLabelSize.height + callLabelInset.bottom, iconImageInset.top + iconImageSize.height + iconImageInset.bottom));

    return resultSize;
}

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (messageModel.message.messageId == self.messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    self.messageModel = messageModel;
    _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    _messageObject = self.messageModel.message.messageAdditionalObject;

    _callLabel.text = _messageObject.realTimeVideoOrVoiceIconDescription;
    _callImageView.image = _messageObject.realTimeVideoOrVoiceIconImage;

    CGSize callLabelSize = [_callLabel sizeThatFits:CGSizeMake(UIScreen.mainScreen.bounds.size.width, FLT_MAX)];
    UIEdgeInsets callLabelInset = _contentConfig.descLabelInsets;

    CGSize iconImageSize = _messageObject.realTimeVideoOrVoiceIconImage.size;
    UIEdgeInsets iconImageInset = _contentConfig.iconImageInsets;

    switch (self.messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            _callLabel.frame = CGRectMake(callLabelInset.left, callLabelInset.top, callLabelSize.width, callLabelSize.height);
            _callImageView.frame = CGRectMake(callLabelInset.left + callLabelSize.width + callLabelInset.right + iconImageInset.left,
                    iconImageInset.top, iconImageSize.width, iconImageSize.height);
            _callImageView.center = CGPointMake(_callImageView.center.x, _callLabel.center.y);
            break;
        }
        case SKSMessageSourceTypeReceive: {
            _callImageView.frame = CGRectMake(iconImageInset.left, iconImageInset.top, iconImageSize.width, iconImageSize.height);
            _callLabel.frame = CGRectMake(iconImageInset.left + iconImageSize.width + iconImageInset.right + callLabelInset.left,
                    callLabelInset.top, callLabelSize.width, callLabelSize.height);
            _callImageView.center = CGPointMake(_callImageView.center.x, _callLabel.center.y);
            break;
        }
        default:
            break;
    }
}


@end
