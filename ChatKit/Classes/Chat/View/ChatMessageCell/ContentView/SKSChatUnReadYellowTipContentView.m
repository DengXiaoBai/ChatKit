//
//  SKSChatUnReadYellowTipContentView.m
//  ChatKit
//
//  Created by iCrany on 2017/2/22.
//
//

#import "SKSChatUnReadYellowTipContentView.h"
#import "SKSUnReadMessageObject.h"
#import "SKSUnReadYellowContentConfig.h"
#import "SKSChatMessage.h"
#import "SKSChatSessionConfig.h"
#import "UIColor+SKS.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"

@interface SKSChatUnReadYellowTipContentView()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) SKSUnReadYellowContentConfig *contentConfig;
@property (nonatomic, strong) SKSUnReadMessageObject *messageObject;

@end

@implementation SKSChatUnReadYellowTipContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[SKSUnReadMessageObject class]]) {
        NSAssert(NO, @"messageAdditionalObject is not kind of SKSUnReadMessageObject");
        return;
    }

    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.numberOfLines = 1;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = self.contentConfig.textColor;
        _tipLabel.font = self.contentConfig.textFont;
        [self addSubview:_tipLabel];
    }

    self.backgroundColor = self.contentConfig.backgroundColor;
    self.layer.shadowOffset = CGSizeMake(0, 4);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 4;
    self.layer.shadowColor = [RGB(222, 222, 222) CGColor];
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

    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    self.messageObject = self.messageModel.message.messageAdditionalObject;

    self.tipLabel.text = self.messageObject.content;
    CGSize tipLabelSize = [self.tipLabel sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width - self.messageModel.contentViewInsets.left - self.messageModel.contentViewInsets.right - self.contentConfig.textInsets.left - self.contentConfig.textInsets.right, FLT_MAX)];
    self.tipLabel.frame = CGRectMake(self.contentConfig.textInsets.left, self.contentConfig.textInsets.top, tipLabelSize.width, tipLabelSize.height);
    self.tipLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, self.contentConfig.contentHeight / 2);
}

@end
