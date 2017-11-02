//
//  ChatAdminNormalCoreTextContentView.m
//  ChatKit_Example
//
//  Created by stringstech-macmini1 on 2017/11/2.
//  Copyright © 2017年 iCrany. All rights reserved.
//


#import "ChatAdminNormalCoreTextContentView.h"

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/SKSChatSessionConfig.h>

#import "ChatAdminNormalCoreTextMessageObject.h"
#import "ChatAdminNormalCoreTextView.h"
#import "ChatAdminNormalCoreTextConfig.h"

@interface ChatAdminNormalCoreTextContentView()

@property (nonatomic, strong) ChatAdminNormalCoreTextView * contentView;
@property (nonatomic, strong) ChatAdminNormalCoreTextMessageObject *messageObject;
@property (nonatomic, strong) ChatAdminNormalCoreTextConfig *contentConfig;


@end

@implementation ChatAdminNormalCoreTextContentView

- (instancetype)initWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    self = [super initWithSKSMessageModel:messageModel];
    if (self) {
        self.messageModel = messageModel;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (![self.messageModel.message.messageAdditionalObject isKindOfClass:[ChatAdminNormalCoreTextMessageObject class]]) {
        NSAssert(NO, @"MessageAdditionalObject is not kind of ChatAdminNormalCoreTextMessageObject class");
    }
    
    self.contentView = [[ChatAdminNormalCoreTextView alloc] initWithMessageModel:self.messageModel];
    [self addSubview:self.contentView];
    
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
    
    // content layout
    self.messageModel = messageModel;
    self.messageObject = self.messageModel.message.messageAdditionalObject;
    self.contentConfig = [self.messageModel.sessionConfig chatContentConfigWithMessageModel:self.messageModel];
    
    [self.contentView updateUIWithMessageModel:self.messageModel force:force];
    
    UIEdgeInsets contentInset = self.messageModel.contentViewInsets;
    CGSize contentSize = self.messageModel.contentViewSize;
    
    self.contentView.frame = CGRectMake(contentInset.left, contentInset.top, contentSize.width, contentSize.height);
    
}




@end
