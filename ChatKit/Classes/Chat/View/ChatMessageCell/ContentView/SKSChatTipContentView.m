//
//  SKSChatTipContentView.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSChatTipContentView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSImageView.h"
#import "SKSTipContentConfig.h"
#import "SKSChatSessionConfig.h"
#import "UIColor+SKS.h"

@interface SKSChatTipContentView()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) SKSTipContentConfig *contentConfig;

@end

@implementation SKSChatTipContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.textColor = _contentConfig.tipColor;
        _tipLabel.font = _contentConfig.tipFont;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.numberOfLines = 0;
        [self addSubview:_tipLabel];
    }

    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    [super updateUIWithMessageModel:messageModel force:force];

    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }

    if (messageModel.message.messageMediaType != SKSMessageMediaTypeTipLabel) {
        DLog(@"[Error] in SKSChatTipContentView but messageMediaType != SKSMessageMediaTypeTipLabel");
        return;
    }

    self.messageModel = messageModel;
    _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    self.bubbleImageView.hidden = YES;
    _tipLabel.text = self.messageModel.message.text;
    CGSize contentViewSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;
    _tipLabel.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
}

@end
