//
//  SKSDefaultCellLayoutConfig.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/9.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSDefaultCellLayoutConfig.h"
#import "SKSChatMessage.h"
#import "SKSChatContentConfig.h"
#import "SKSChatSessionConfig.h"
#import "SKSChatMessageModel.h"


@interface SKSDefaultCellLayoutConfig()

@end

@implementation SKSDefaultCellLayoutConfig

+ (instancetype)shareInstance {
    static SKSDefaultCellLayoutConfig *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[SKSDefaultCellLayoutConfig alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UIEdgeInsets)getContentViewInsetsWithMessageModel:(SKSChatMessageModel *)messageModel {
    id<SKSChatContentConfig> contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    return [contentConfig contentViewInsets];
}

- (UIEdgeInsets)getBubbleViewInsetsWithMessageModel:(SKSChatMessageModel *)messageModel {

    //Timestamp view
    UIEdgeInsets timestampInsets = UIEdgeInsetsZero;
    CGSize timestampSize = CGSizeZero;
    
    //Avatar view or not show avatar placeholder insets
    UIEdgeInsets avatarViewInsets = UIEdgeInsetsZero;
    CGSize avatarViewSize = CGSizeZero;
    
    UIEdgeInsets noTimestampBubbleViewInsets = UIEdgeInsetsZero;
    UIEdgeInsets bubbleViewInsets = UIEdgeInsetsZero;
    
    //Get Avatar Insets and size
    avatarViewInsets = messageModel.avatarViewInsets;
    avatarViewSize = messageModel.avatarViewSize;
    
    //Get Timestamp Insets and size
    timestampSize = messageModel.timelabelSize;
    timestampInsets = messageModel.timelabelViewInsets;
    
    //Get BubbleView regardless of the timestamp situation Insets
    noTimestampBubbleViewInsets = messageModel.noTimestampBubbleViewInsets;
    
    //Get content Insets and size
    CGSize contentSize = messageModel.contentViewSize;
    CGFloat screen_width = UIScreen.mainScreen.bounds.size.width;
    UIEdgeInsets contentInsets = messageModel.contentViewInsets;
    
    //Calculate the bubbleView UIEdgeInsets(top2CellTop, left2CellLeft, bottom2CellBottom, right2CellRight)
    switch (messageModel.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            bubbleViewInsets = UIEdgeInsetsMake(timestampInsets.top + timestampSize.height + timestampInsets.bottom + noTimestampBubbleViewInsets.top,
                    avatarViewInsets.left + avatarViewSize.width + avatarViewInsets.right + noTimestampBubbleViewInsets.left + noTimestampBubbleViewInsets.right,
                    noTimestampBubbleViewInsets.bottom,
                    noTimestampBubbleViewInsets.right);
            
            break;
        }
        case SKSMessageSourceTypeSend: {
            CGFloat left = screen_width - (avatarViewInsets.right + avatarViewSize.width + avatarViewInsets.left) - (contentInsets.left + contentSize.width + contentInsets.right) - noTimestampBubbleViewInsets.left;
            bubbleViewInsets = UIEdgeInsetsMake(timestampInsets.top + timestampSize.height + timestampInsets.bottom + noTimestampBubbleViewInsets.top,
                    left,
                    noTimestampBubbleViewInsets.bottom,
                    noTimestampBubbleViewInsets.right + (avatarViewInsets.right + avatarViewSize.width + avatarViewInsets.left));

            break;
        }
        case SKSMessageSourceTypeSendCenter:
        case SKSMessageSourceTypeReceiveCenter:
        case SKSMessageSourceTypeCenter: {
            CGFloat left = (screen_width - contentSize.width - contentInsets.left - contentInsets.right) / 2;
            bubbleViewInsets = UIEdgeInsetsMake(timestampInsets.top + timestampSize.height + timestampInsets.bottom + noTimestampBubbleViewInsets.top,
                    left,
                    noTimestampBubbleViewInsets.bottom,
                    noTimestampBubbleViewInsets.right + (avatarViewInsets.right + avatarViewSize.width + avatarViewInsets.left));
            
            break;
        }
    }
    
    messageModel.timelabelSize = timestampSize;
    messageModel.timelabelViewInsets = timestampInsets;
    messageModel.bubbleViewInsets = bubbleViewInsets;
    return bubbleViewInsets;
}

- (UIEdgeInsets)getBubbleViewInsetsRegardlessOfTheTimestampSituationWithMessageModel:(SKSChatMessageModel *)messageModel {
    id<SKSChatContentConfig> config = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    return [config bubbleViewInsetsRegardlessOfTheTimestampSituation];
}

- (CGSize)getContentSizeWithMessageModel:(SKSChatMessageModel *)messageModel cellWidth:(CGFloat)cellWidth {
    id<SKSChatContentConfig> config = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    return [config contentSizeWithCellWidth:cellWidth];
}


- (NSString *)getCellContentViewClassNameWithMessageModel:(SKSChatMessageModel *)messageModel {
    id<SKSChatContentConfig> config = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    return [config cellContentClass];
}

- (NSString *)getCellIdentifierWithMessageModel:(SKSChatMessageModel *)messageModel {
    id<SKSChatContentConfig> config = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    return [config cellContentIdentifier];
}


- (BOOL)shouldShowAvatar:(SKSChatMessageModel *)messageModel {
    return messageModel.shouldShowAvatar;
}

- (UIEdgeInsets)avatarViewInsets:(SKSChatMessageModel *)messageModel {
    return UIEdgeInsetsMake(0, 25, 5, 5);
}

- (CGSize)avatarViewSize:(SKSChatMessageModel *)messageModel {
    return CGSizeMake(40, 40);
}

- (UIEdgeInsets)notShowAvatarViewInsets:(SKSChatMessageModel *)messageModel {
    return UIEdgeInsetsMake(0, 9, 0, 9);
}


- (BOOL)shouldShowTimestamp:(SKSChatMessageModel *)messageModel {
    return messageModel.shouldShowTimestamp;
}

- (UIEdgeInsets)timestampViewInsets:(SKSChatMessageModel *)messageModel {
    return UIEdgeInsetsMake(5, 0, 0, 0);//默认是居中，所有左右两边的边距忽略, 下面的边距由时间标签下面的控件来控制
}

- (CGSize)timestampViewSize:(SKSChatMessageModel *)messageModel {
    id<SKSChatContentConfig> contentConfig = [messageModel.sessionConfig chatContentConfigWithMessageModel:messageModel];
    if ([contentConfig respondsToSelector:@selector(timestampViewSize)]) {
        return [contentConfig timestampViewSize];
    } else {
        return CGSizeMake(0, 24);
    }
}

- (UIEdgeInsets)readLabelViewInsets:(SKSChatMessageModel *)messageModel {
    return UIEdgeInsetsMake(10, 0, 0, 10);
}

@end
