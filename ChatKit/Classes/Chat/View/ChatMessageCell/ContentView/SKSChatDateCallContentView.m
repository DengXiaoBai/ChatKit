//
//  SKSChatDateCallContentView.m
//  ChatKit
//
//  Created by iCrany on 2016/12/24.
//
//

#import "SKSChatDateCallContentView.h"
#import "SKSDateCallView.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSImageView.h"
#import "SKSDateCallContentConfig.h"
#import "SKSChatSessionConfig.h"

@interface SKSChatDateCallContentView()

@property (nonatomic, strong) SKSDateCallView *dateCallView;
@property (nonatomic, strong) SKSDateCallContentConfig *contentConfig;

@end

@implementation SKSChatDateCallContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_dateCallView) {
        _dateCallView = [[SKSDateCallView alloc] initWithMessageModel:self.messageModel];
        [self addSubview:_dateCallView];
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
    _contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];

    [_dateCallView updateWithMessageModel:self.messageModel force:force];

    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;
    CGSize contentViewSize = self.messageModel.contentViewSize;

    _dateCallView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
    _dateCallView.layer.mask = self.bubbleImageView.layer;
}

@end
