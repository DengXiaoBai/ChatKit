//
//  SKSChatLocationContentView.m
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright © 2016年 iCrany. All rights reserved.
//

#import "SKSChatLocationContentView.h"
#import "SKSLocationMessageObject.h"
#import "SKSLocationContentConfig.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSChatLocationView.h"
#import "SKSImageView.h"
#import "SKSNewDrawBubbleView.h"

@interface SKSChatLocationContentView()

@property (nonatomic, strong) SKSLocationContentConfig *contentConfig;

@property (nonatomic, strong) SKSChatLocationView *locationView;
@property (nonatomic, strong) SKSNewDrawBubbleView *drawBubbleView;

@end

@implementation SKSChatLocationContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    if (!_drawBubbleView) {
        _drawBubbleView = [[SKSNewDrawBubbleView alloc] init];
        [self addSubview:_drawBubbleView];
    }
    
    if (!_locationView) {
        _locationView = [[SKSChatLocationView alloc] initWithMessageModel:self.messageModel];
        [self addSubview:_locationView];
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

    if (messageModel.message.messageMediaType != SKSMessageMediaTypeLocation) {
        DLog(@"[Error] in SKSChatLocationContentView but messageMediaType != SKSMessageMediaTypeLocation");
        return;
    }

    self.messageModel = messageModel;

    CGRect bubbleFrame = self.bubbleImageView.frame;

    CGSize contentViewSize = self.messageModel.contentViewSize;
    UIEdgeInsets contentViewInsets = self.messageModel.contentViewInsets;

    [_locationView updateUIWithMessageModel:self.messageModel force:force];

    BOOL isSendMessage = self.messageModel.message.messageSourceType == SKSMessageSourceTypeSend ? YES : NO;

    [_drawBubbleView resetWidth:contentViewInsets.left + contentViewSize.width + contentViewInsets.right + 2
                         height:contentViewInsets.top + contentViewSize.height + contentViewInsets.bottom + 2
                  isSendMessage:isSendMessage];
    _drawBubbleView.frame = CGRectMake(bubbleFrame.origin.x - 1, bubbleFrame.origin.y - 1, bubbleFrame.size.width + 2, bubbleFrame.size.height + 2);
    [_drawBubbleView setNeedsDisplay];

    _locationView.frame = CGRectMake(contentViewInsets.left, contentViewInsets.top, contentViewSize.width, contentViewSize.height);
    _locationView.layer.mask = self.bubbleImageView.layer;
    _locationView.layer.masksToBounds = YES;
    _locationView.layer.borderWidth = 1;
    _locationView.layer.borderColor = [[UIColor clearColor] CGColor];

}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}

@end
