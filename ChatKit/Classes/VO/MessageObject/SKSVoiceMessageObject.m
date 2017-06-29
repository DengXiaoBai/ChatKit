//
//  SKSVoiceMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSVoiceMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSVoiceMessageObject

- (instancetype)initWithVoiceUrl:(NSString *)voiceUrl
                     voiceFormat:(SKSVoiceMessageFormat)voiceFormat
                        duration:(int32_t)duration
                 isFirstTimePlay:(BOOL)isFirstTimePlay {
    self = [super init];
    if (self) {
        self.voiceUrl = voiceUrl;
        self.voiceFormat = voiceFormat;
        self.duration = duration;
        self.isFirstTimePlay = isFirstTimePlay;
        self.voicePlayState = SKSVoicePlayStateNormal;
        
        [self prepareImage];
    }
    return self;
}

- (void)prepareImage {
    if (self.message.messageSourceType == SKSMessageSourceTypeReceive) {
        self.voiceStartButtonImage = [UIImage imageNamed:@"chat-voice-play-dark-gray"];
        self.voiceStopButtonImage = [UIImage imageNamed:@"chat-voice-stop-dark-gray"];
        self.voiceLoadingBottomImage = [UIImage imageNamed:@"chat-voice-loading-bottom-gray"];
        self.voiceLoadingTopImage = [UIImage imageNamed:@"chat-voice-loading-top-gray"];
        
    } else {
        self.voiceStartButtonImage = [UIImage imageNamed:@"chat-voice-play-dark-gray"];
        self.voiceStopButtonImage = [UIImage imageNamed:@"chat-voice-stop-dark-gray"];
        self.voiceLoadingBottomImage = [UIImage imageNamed:@"chat-voice-loading-bottom-white"];
        self.voiceLoadingTopImage = [UIImage imageNamed:@"chat-voice-loading-top-white"];
    }
    
    self.voiceStartNoReadButtonImage = [UIImage imageNamed:@"chat-voice-play-dark-gray"];
}


#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    return SKSMessageMediaTypeVoice;
}

@end
