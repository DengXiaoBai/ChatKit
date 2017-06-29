//
//  SKSRealTimeVideoAudioMessageObject.m
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSRealTimeVideoOrVoiceMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSRealTimeVideoOrVoiceMessageObject

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

- (UIImage *)realTimeVideoOrVoiceIconImage {
    switch (self.messageMediaType) {
        case SKSMessageMediaTypeRealTimeVideo: {
            return [UIImage imageNamed:@"chat-room-video"];
        }
            
        case SKSMessageMediaTypeRealTimeVoice: {
            return [UIImage imageNamed:@"chat-room-phone"];
        }
        default: {
            NSAssert(NO, @"未识别的 MessageMediaType 类型");
            break;
        }
    }
    return nil;
}


- (NSString *)realTimeVideoOrVoiceIconDescription {
    NSString *durationStr = @"00:01";
    if (_duration > 0) {
        NSInteger m = _duration / 60;
        NSInteger s = _duration % 60;
        durationStr = [NSString stringWithFormat:@"%02ld:%02ld", (long)m, (long)s];
    }
    switch (_callState) {
        case SKSMessageCallStateNoResponse: {
            if ([self isReceiveMessage]) {
                return @"未接听";
            } else {
                return @"对方无应答";
            }
        }
        case SKSMessageCallStateAccept: {
            return [@"通话时长 " stringByAppendingString:durationStr];
        }
        case SKSMessageCallStateCancel: {
            if ([self isReceiveMessage]) {
                return @"对方已取消";
            } else {
                return @"已取消";
            }
        }
        case SKSMessageCallStateReject: {
            if ([self isReceiveMessage]) {
                return @"已拒绝";
            } else {
                return @"对方已拒绝";
            }
        }
        case SKSMessageCallStateReconnectFail:
        case SKSMessageCallStateFail: {
            return @"未连通";
        }
        case SKSMessageCallStateBusy: {
            if ([self isReceiveMessage]) {
                return @"未接听";
            } else {
                return @"对方正忙";
            }
        }
        default:{
            return nil;
        }
    }
}

#pragma mark - Private method
- (BOOL)isReceiveMessage {
    switch (self.message.messageSourceType) {
        case SKSMessageSourceTypeSend:
            return NO;
            
        case SKSMessageSourceTypeReceive: {
            return YES;
        }
        default:
            NSAssert(NO, @"未知的 messageSourceType 类型");
            break;
    }
    return NO;
}

#pragma mark - SKSChatMessageObject
- (SKSMessageMediaType)messageMediaType {
    if (self.message) {
        return self.message.messageMediaType;
    }
    return SKSMessageMediaTypeRealTimeVideo;
}

@end
