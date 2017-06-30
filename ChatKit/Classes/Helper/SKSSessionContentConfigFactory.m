//
//  SKSSessionContentConfigFactory.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/14.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSSessionContentConfigFactory.h"
#import "SKSChatMessageConstant.h"
#import "SKSTextContentConfig.h"
#import "SKSYOContentConfig.h"
#import "SKSEmoticonContentConfig.h"
#import "SKSVoiceContentConfig.h"
#import "SKSTypingContentConfig.h"
#import "SKSLocationContentConfig.h"
#import "SKSTipContentConfig.h"
#import "SKSNotSupportContentConfig.h"
#import "SKSChatMessage.h"
#import "SKSRealTimeVideoOrVoiceContentConfig.h"
#import "SKSCoreTextContentConfig.h"
#import "SKSDateCallContentConfig.h"
#import "SKSImpressContentConfig.h"
#import "SKSUnReadContentConfig.h"
#import "SKSUnReadYellowContentConfig.h"

@interface SKSSessionContentConfigFactory()

@property (nonatomic, strong) NSDictionary *dict;

@end

@implementation SKSSessionContentConfigFactory

+ (instancetype)shareInstance {
    static SKSSessionContentConfigFactory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SKSSessionContentConfigFactory alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //TODO: 设置配置实例
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
                @(SKSMessageMediaTypeImpress) : [SKSImpressContentConfig new],
                @(SKSMessageMediaTypeUnReadTip) : [SKSUnReadYellowContentConfig new],
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
