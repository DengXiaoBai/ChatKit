//
//  SKSRealTimeVoiceMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSRealTimeVoiceMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSRealTimeVoiceMessageObject

- (instancetype)initWithSessionId:(int64_t)sessionId
                        callState:(SKSMessageCallState)callState
                         duration:(int32_t)duration {
    self = [super init];
    if (self) {
        self.sessionId = sessionId;
        self.callState = callState;
        self.duration = duration;
    }
    return self;
}

#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    return SKSMessageMediaTypeRealTimeVoice;
}

@end
