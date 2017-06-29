//
//  SKSDateCallMessageObject.m
//  ChatKit
//
//  Created by iCrany on 2016/12/24.
//
//

#import "SKSDateCallMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSDateCallMessageObject

- (instancetype)initWithSessionId:(int64_t)sessionId
                       activityId:(NSString *)activityId
                 activityAuthorId:(NSString *)activityAuthorId
                        callState:(SKSMessageCallState)callState
                         duration:(int32_t)duration
                          message:(SKSChatMessage *)message {
    self = [super init];
    if (self) {
        self.sessionId = sessionId;
        self.activityId = activityId;
        self.activityAuthorId = activityAuthorId;
        self.callState = callState;
        self.duration = duration;
        self.message = message;
    }

    return self;
}

- (NSString *)iconImageName {
    return @"chat-session-date-call";
}

- (NSString *)descText {
    if (_isCallbackSuccess) {
        return @"已回拨";
    } else {
        return @"轻触回拨";
    }
}

- (NSString *)titleText {
    switch (_callState) {
        case SKSMessageCallStateNoResponse: {
            switch (_message.messageSourceType) {
                case SKSMessageSourceTypeReceive: {
                    return @"未接视频呼叫";
                }
                default: {
                    return @"对方无应答";
                }
            }
        }
        case SKSMessageCallStateCancel: {
            switch (_message.messageSourceType) {
                case SKSMessageSourceTypeReceive: {
                    return @"对方已取消视频呼叫";
                }
                default: {
                    return @"已取消视频呼叫";
                }
            }
        }
        case SKSMessageCallStateReject: {
            switch (_message.messageSourceType) {
                case SKSMessageSourceTypeReceive: {
                    return @"未接视频呼叫";
                }
                default: {
                    return @"对方已拒绝";
                }
            }
        }
        case SKSMessageCallStateAccept: {
            NSString *durationStr = @"00:01";
            if (_duration > 0) {
                NSInteger m = _duration / 60;
                NSInteger s = _duration % 60;
                durationStr = [NSString stringWithFormat:@"%02ld:%02ld", (long)m, (long)s];
            }
            return [NSString stringWithFormat:@"视频时长 %@", durationStr];
        }
        case SKSMessageCallStateReconnectFail:
        case SKSMessageCallStateFail: {
            return  @"视频连接失败";
        }
        case SKSMessageCallStateBusy: {
            switch (_message.messageSourceType) {
                case SKSMessageSourceTypeReceive: {
                    return @"未接视频呼叫";
                }
                default: {
                    return @"对方正忙，请稍后再拨";
                }
            }
        }
        default: {
            return @"";
        }
    }
}


@end
