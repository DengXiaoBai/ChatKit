//
//  SKSChatUnReadTipContentView.m
//  ChatKit
//
//  Created by iCrany on 2017/2/17.
//
//

#import "SKSChatUnReadTipContentView.h"
#import "SKSUnReadContentConfig.h"
#import "SKSChatMessage.h"
#import "SKSUnReadMessageObject.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatMessageModel.h"

@interface SKSChatUnReadTipContentView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) SKSUnReadContentConfig *contentConfig;
@property (nonatomic, strong) SKSUnReadMessageObject *messageObject;

@end

@implementation SKSChatUnReadTipContentView

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


    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = self.contentConfig.backgroundColor;
        _backgroundView.layer.cornerRadius = self.contentConfig.contentHeight / 2;
        _backgroundView.layer.masksToBounds = YES;
        _backgroundView.layer.borderColor = [self.contentConfig.borderColor CGColor];
        _backgroundView.layer.borderWidth = 0.5;
        [self addSubview:_backgroundView];
    }

    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.numberOfLines = 1;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = self.contentConfig.textColor;
        _tipLabel.font = self.contentConfig.textFont;
        [self addSubview:_tipLabel];
    }

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

    UIEdgeInsets contentInsets = self.messageModel.contentViewInsets;

    self.backgroundView.frame = CGRectMake(0, 0, self.contentConfig.textInsets.left + tipLabelSize.width + self.contentConfig.textInsets.right, self.contentConfig.contentHeight);
    self.backgroundView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    self.tipLabel.frame = CGRectMake(contentInsets.left + self.contentConfig.textInsets.left, contentInsets.top + self.contentConfig.textInsets.top, tipLabelSize.width, tipLabelSize.height);
    self.tipLabel.center = self.backgroundView.center;
}

@end
