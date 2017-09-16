//
//  SKSChatEmoticonContentView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSChatEmoticonContentView.h"
#import "SKSChatMessage.h"
#import "SKSChatMessageModel.h"
#import "SKSImageView.h"

@interface SKSChatEmoticonContentView()

@property (nonatomic, strong) UILabel *emoticonLabel;

@end

@implementation SKSChatEmoticonContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_emoticonLabel) {
        _emoticonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _emoticonLabel.textAlignment = NSTextAlignmentCenter;
        _emoticonLabel.text = @"表情，请重载该方法";
        _emoticonLabel.numberOfLines = 0;
        [self addSubview:_emoticonLabel];
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

    if (messageModel.message.messageMediaType != SKSMessageMediaTypeEmoticon) {
        DLog(@"[Error] in SKSChatEmoticonContentView but messageMediaType != SKSMessageMediaTypeEmoticon");
        return;
    }

    self.messageModel = messageModel;

    self.bubbleImageView.hidden = YES;
    CGSize contentViewSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;

    _emoticonLabel.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
    _emoticonLabel.backgroundColor = [UIColor blueColor];

}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
