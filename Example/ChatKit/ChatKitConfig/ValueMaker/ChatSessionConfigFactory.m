//
//  ChatSessionConfigFactory.m
//  AtFirstSight
//
//  Created by iCrany on 2016/12/14.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <ChatKit/SKSChatMessageConstant.h>
#import <ChatKit/SKSNotSupportContentConfig.h>
#import <ChatKit/SKSYOContentConfig.h>
#import <ChatKit/SKSTextContentConfig.h>
#import <ChatKit/SKSEmoticonContentConfig.h>
#import <ChatKit/SKSVoiceContentConfig.h>
#import <ChatKit/SKSTypingContentConfig.h>
#import <ChatKit/SKSLocationContentConfig.h>
#import <ChatKit/SKSRealTimeVideoOrVoiceContentConfig.h>
#import <ChatKit/SKSTipContentConfig.h>
#import <ChatKit/SKSCoreTextContentConfig.h>
#import <ChatKit/SKSDateCallContentConfig.h>
#import <ChatKit/SKSImpressContentConfig.h>
#import <ChatKit/SKSUnReadYellowContentConfig.h>
#import <ChatKit/SKSChatMessageModel.h>
#import <ChatKit/SKSChatMessage.h>
#import "ChatSessionConfigFactory.h"
#import "ChatPrivacyDateOfferContentConfig.h"
#import "ChatPrivacyGiftOfferContentConfig.h"
#import "ChatDateOfferContentConfig.h"
#import "ChatDateJoinedPreviewContentConfig.h"

@interface ChatSessionConfigFactory()

@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation ChatSessionConfigFactory

+ (instancetype)shareInstance {
    static ChatSessionConfigFactory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ChatSessionConfigFactory alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dict = @{
                @(SKSMessageMediaTypeUnsupport) : [SKSNotSupportContentConfig new],
                @(SKSMessageMediaTypeYO) : [SKSYOContentConfig new],
                @(SKSMessageMediaTypeText) : [SKSTextContentConfig new],
                @(SKSMessageMediaTypeEmoticon) : [SKSEmoticonContentConfig new],
                @(SKSMessageMediaTypeVoice) : [SKSVoiceContentConfig new],
                @(SKSMessageMediaTypeTyping) : [SKSTypingContentConfig new],
                @(SKSMessageMediaTypeLocation) : [SKSLocationContentConfig new],
                @(SKSMessageMediaTypeRealTimeVideo) : [SKSRealTimeVideoOrVoiceContentConfig new],
                @(SKSMessageMediaTypeRealTimeVoice) : [SKSRealTimeVideoOrVoiceContentConfig new],
                @(SKSMessageMediaTypeTipLabel) : [SKSTipContentConfig new],
                @(SKSMessageMediaTypeCoreText) : [SKSCoreTextContentConfig new],
                @(SKSMessageMediaTypeDataCall) : [SKSDateCallContentConfig new],
                @(SKSMessageMediaTypeDateOffer) : [ChatDateOfferContentConfig new],
                @(SKSMessageMediaTypeDateJoinedPreview) : [ChatDateJoinedPreviewContentConfig new],
                @(SKSMessageMediaTypeConfirmMeet) : [ChatDateOfferContentConfig new],
                @(SKSMessageMediaTypeImpress) : [SKSImpressContentConfig new],
                @(SKSMessageMediaTypeUnReadTip) : [SKSUnReadYellowContentConfig new],
                @(SKSMessageMediaTypePrivacyActivity): [ChatPrivacyDateOfferContentConfig new],
                @(SKSMessageMediaTypePrivacyGiftOffer): [ChatPrivacyGiftOfferContentConfig new],
        };
    }
    return self;
}

- (id<SKSChatContentConfig>)getConfigWithMessageModel:(SKSChatMessageModel *)messageModel {
    SKSMessageMediaType messageMedia = messageModel.message.messageMediaType;
    id<SKSChatContentConfig> contentConfig = [_dict objectForKey:@(messageMedia)];
    if (!contentConfig) {//没有支持的类型就选择该选项
        contentConfig = [_dict objectForKey:@(SKSMessageMediaTypeUnsupport)];
    }
    [contentConfig updateWithMessageModel:messageModel];

    return contentConfig;
}

@end
