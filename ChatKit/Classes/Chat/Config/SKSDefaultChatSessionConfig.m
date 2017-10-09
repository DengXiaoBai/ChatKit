//
//  SKSDefaultChatSessionConfig.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSDefaultChatSessionConfig.h"
#import "SKSDefaultValueMaker.h"
#import "SKSChatMessageModel.h"
#import "SKSChatMessage.h"
#import "SKSSessionContentConfigFactory.h"
#import "SKSMessageAvatarButton.h"

@implementation SKSDefaultChatSessionConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        //配置ChatContentViewConfig 类型的配置
        
    }
    return self;
}

- (UIImage *)defaultAvatar {
    return nil;
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
    return NSStringFromClass([SKSMessageAvatarButton class]);
}


- (id<SKSChatCellLayoutConfig>)layoutConfigWithMessage:(SKSChatMessage *)message {
    id<SKSChatCellLayoutConfig> layoutConfig = [[SKSDefaultValueMaker shareInstance] getDefaultChatCellLayoutConfig];
    return layoutConfig;
}

- (id<SKSChatCellConfig>)chatCellConfigWithMessage:(SKSChatMessage *)message {
    id<SKSChatCellConfig> chatUIConfig = [[SKSDefaultValueMaker shareInstance] getDefaultChatCellConfig];
    return chatUIConfig;
}

- (id<SKSChatContentConfig>)chatContentConfigWithMessageModel:(SKSChatMessageModel *)messageModel {
    id<SKSChatContentConfig> contentConfig = [[SKSSessionContentConfigFactory shareInstance] getConfigWithMessageModel:messageModel];
    return contentConfig;
}

- (id<SKSChatKeyboardConfig>)chatKeyboardConfig {
    id<SKSChatKeyboardConfig> keyboardConfig = [[SKSDefaultValueMaker shareInstance] getDefaultKeyboardConfig];
    return keyboardConfig;
}

- (NSTimeInterval)showTimestampInterval {
    return 5 * 60;
}

- (NSTimeInterval)maxRecordDuration {
    return 1 * 60;
}


@end
