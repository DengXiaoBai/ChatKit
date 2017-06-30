//
//  ChatYOContentView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/11.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSImageView.h>
#import "ChatYOContentView.h"
#import "ChatYOMessageObject.h"

@interface ChatYOContentView()

@property (nonatomic, strong) UILabel *yoLabel;
@property (nonatomic, strong) ChatYOMessageObject *yoMessageObject;

@end

@implementation ChatYOContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[ChatYOMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of ChatYOMessageObject");
        return;
    }
    
    _yoMessageObject = self.messageModel.message.messageAdditionalObject;
    
    _yoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _yoLabel.textAlignment = NSTextAlignmentCenter;
    _yoLabel.text = @"YO";
    
    [self addSubview:self.yoLabel];
    
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
    _yoMessageObject = self.messageModel.message.messageAdditionalObject;

    self.bubbleImageView.hidden = true;
    _yoLabel.font = _yoMessageObject.yoFont;
    _yoLabel.textColor = _yoMessageObject.yoColor;

    CGSize contentViewSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;

    self.yoLabel.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
