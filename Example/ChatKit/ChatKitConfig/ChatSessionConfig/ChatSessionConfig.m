//
//  ChatSessionConfig.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/13.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import <ChatKit/UIImage+SKS.h>
#import "ChatSessionConfig.h"
#import "ChatSessionConfigFactory.h"
#import "ChatDefaultValueMaker.h"

@implementation ChatSessionConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        //配置ChatContentViewConfig 类型的配置

    }
    return self;
}

- (UIImage *)defaultAvatar {
    return [UIImage imageWithColor:[UIColor grayColor]];
}

- (CGFloat)getBubbleViewArrowWidth {
    return 3;
}

- (NSString *)bubbleImageNameWithSKSMessageModel:(SKSChatMessageModel *)messageModel {
    switch (messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeSend: {
            return @"chat-send-bubble";
        }
        case SKSMessageSourceTypeReceive: {
            return @"chat-receive-bubble";
        }
        default: {
            break;
        }
    }
    return @"";
}

- (NSString *)getReadLabelTextWithMessageModel:(SKSChatMessageModel *)messageModel {
    switch (messageModel.message.messageDeliveryState) {
        case SKSMessageDeliveryStateRead: {
            return @"已读";
        }
        default: {
            return @"未读";
        }
    }
}

- (NSString *)getAvatarButtonClassNameWithMessageModel:(SKSChatMessageModel *)messageModel {
    return @"ChatMessageAvatarButton";
}

- (id<SKSChatCellLayoutConfig>)layoutConfigWithMessage:(SKSChatMessage *)message {
    id<SKSChatCellLayoutConfig> layoutConfig = [[ChatDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig];
    return layoutConfig;
}

- (id<SKSChatCellConfig>)chatCellConfigWithMessage:(SKSChatMessage *)message {
    id<SKSChatCellConfig> chatCellConfig = [[ChatDefaultValueMaker shareInstance] getDefaultChatCellConfig];
    return chatCellConfig;
}

- (id<SKSChatContentConfig>)chatContentConfigWithMessageModel:(SKSChatMessageModel *)messageModel {
    id<SKSChatContentConfig> config = [[ChatSessionConfigFactory shareInstance] getConfigWithMessageModel:messageModel];
    return config;
}

- (id<SKSChatKeyboardConfig>)chatKeyboardConfig {
    id<SKSChatKeyboardConfig> config = [[ChatDefaultValueMaker shareInstance] getChatKeyboardConfig];
    return config;
}

- (NSTimeInterval)showTimestampInterval {
    return 5 * 60;
}

- (NSTimeInterval)maxRecordDuration {
    return 1 * 60;
}


@end
