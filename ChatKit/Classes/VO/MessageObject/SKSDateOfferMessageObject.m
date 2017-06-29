//
//  SKSDateOfferMessageObject.m
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//

#import "SKSDateOfferMessageObject.h"
#import "SKSChatMessage.h"

@implementation SKSDateOfferMessageObject

#pragma mark - getter/setter

- (NSString *)acceptBtnTitle {
    return @"接受";
}

- (NSString *)rejectBtnTitle {
    return @"拒绝";
}

- (NSString *)iconImageName {
    return @"chat-session-select-date";
}

- (NSString *)topDesc {
    return @"我已将你选为约会对象，是否接受邀請?";
}

- (NSString *)bottomDesc {
    switch (self.dateOfferState) {
        case SKSDateOfferStateMakeOffer: {
            return @"你已邀约对方，若对方15分钟没有作出回应，你可以选择其他约会对象";
        }
        case SKSDateOfferStateOfferAccepted: {
            switch (self.message.messageSourceType) {
                case SKSMessageSourceTypeSend: {
                    return @"对方接受了你的邀约请求";
                }
                case SKSMessageSourceTypeReceive: {
                    return @"已接受";
                }
                default: {
                    break;
                }
            }
            break;
        }
        case SKSDateOfferStateOfferRejected: {
            switch (self.message.messageSourceType) {
                case SKSMessageSourceTypeReceive: {
                    return @"已拒绝";
                }
                case SKSMessageSourceTypeSend: {
                    return @"对方拒绝了你的邀约请求";
                }
                default:{
                    return @"";
                }
            }
            break;
        }
        case SKSDateOfferStateOfferAcceptedOverLimit:
        case SKSDateOfferStateOfferInvalid: {
            return @"该邀约已失效";
        }
        default: {
            return [NSString stringWithFormat:@"该状态没有文案的描述, DateOfferState: %ld", (long)self.dateOfferState];
        }
    }
    return @"";
}

@end
