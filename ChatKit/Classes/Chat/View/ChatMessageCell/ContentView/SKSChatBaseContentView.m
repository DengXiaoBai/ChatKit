//
//  ChatBaseContentView.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatBaseContentView.h"
#import "SKSChatMessageModel.h"
#import "SKSImageView.h"
#import "SKSChatMessage.h"
#import "SKSChatSessionConfig.h"
#import "SKSMenuItemBaseObject.h"

/**
 消息聊天中的UI基础类
 */
@interface SKSChatBaseContentView()



@end

@implementation SKSChatBaseContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.messageModel = messageModel;
        [self addTargetAction];
        [self setupBubbleView];
    }
    return self;
}

- (void)addTargetAction {
    //Add Gesture Action
    [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(onTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)setupBubbleView {
    if (!_bubbleImageView) {
        _bubbleImageView = [[SKSImageView alloc] init];
        _bubbleImageView.translatesAutoresizingMaskIntoConstraints = YES;
        _bubbleImageView.bounds = self.bounds;
        _bubbleImageView.userInteractionEnabled = YES;
        _bubbleImageView.clipsToBounds = YES;
        [self addSubview:_bubbleImageView];
    }

    [self updateUIWithMessageModel:self.messageModel force:YES];
}

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force {
    if (self.messageModel.message.messageId == messageModel.message.messageId && self.messageModel.message.messageId != 0 && !force) {
        return;
    }
    self.messageModel = messageModel;

    NSString *bubbleImageName = [self.messageModel.sessionConfig bubbleImageNameWithSKSMessageModel:self.messageModel];
    _bubbleImageView.image = [UIImage imageNamed: bubbleImageName];
    CGFloat width = self.messageModel.contentViewInsets.left + self.messageModel.contentViewSize.width + self.messageModel.contentViewInsets.right;
    CGFloat height = self.messageModel.contentViewInsets.top + self.messageModel.contentViewSize.height + self.messageModel.contentViewInsets.bottom;
    _bubbleImageView.frame = CGRectMake(0, 0, width, height);
}

#pragma mark - Event Response
- (void)onTouchDown:(id)sender {
    DLog(@"SKSChatBaseContentView onTouchDown method");
}

- (void)onTouchUpInside:(id)sender {
    DLog(@"SKSChatBaseContentView onTouchUpInside method");
}

- (void)onTouchUpOutside:(id)sender {
    DLog(@"SKSChatBaseContentView onTouchUpOutside method");
}

#pragma mark - Override method
- (BOOL)canBecomeFirstResponder {
    return YES;
}


@end
