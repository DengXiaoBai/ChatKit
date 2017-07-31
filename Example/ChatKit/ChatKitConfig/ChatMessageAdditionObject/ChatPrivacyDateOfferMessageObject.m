//
//  ChatPrivacyDateOfferMessageObject.m
//  ChatKit
//
//  Created by iCrany on 2017/6/5.
//
//

#import <ChatKit/SKSChatMessage.h>
#import "ChatPrivacyDateOfferMessageObject.h"

@implementation ChatPrivacyDateOfferMessageObject

- (instancetype)initWithAid:(NSString *)aid
                   authorId:(NSString *)authorId
                      title:(NSString *)title
                   coverUrl:(NSString *)coverUrl
                  startTime:(int64_t)startTime
                   duration:(int32_t)duration
                      place:(NSString *)place
                detailPlace:(NSString *)detailPlace
                        lat:(double)lat
                        lng:(double)lng
                   placeLat:(double)placeLat
                   placeLng:(double)placeLng
                   withCash:(int32_t)withCash
       privacyActivityState:(SKSPrivacyActivityState)privacyActivityState {
    self = [super init];

    if (self) {
        self.aid = aid;
        self.authorId = authorId;
        self.title = title;
        self.coverUrl = coverUrl;
        self.startTime = startTime;
        self.duration = duration;
        self.place = place;
        self.detailPlace = detailPlace;
        self.lat = lat;
        self.lng = lng;
        self.placeLat = placeLat;
        self.placeLng = placeLng;
        self.withCrash = withCash;
        self.privacyActivityState = privacyActivityState;
    }
    return self;
}


#pragma mark - Public method

- (NSString *)privacyDateOfferStateStr {
    switch (self.privacyActivityState) {
        case SKSPrivacyActivityStateAccept: {
            return @"对方接受了你的私人邀约";
        }
        case SKSPrivacyActivityStateReject: {
            return @"对方拒绝了你的私人邀约";
        }
        case SKSPrivacyActivityStateUnhandle: {
            return @"等待对方反馈";
        }
        default: {
            return @"";
        }
    }
}

- (NSString *)durationStr {
    return @"尽快";
}

- (NSString *)leftBtnTitle {
    return @"接受";
}

- (NSString *)middleBtnTitle {
    return @"考虑";
}

- (NSString *)rightBtnTitle {
    return @"拒绝";
}

- (NSString *)cancelBtnTitle {
    return @"取消邀约";
}


- (NSString *)bottomDesc {
    return @"";
}

- (NSString *)acceptedBtnTitle {
    return @"已接受";
}

- (NSString *)rejectedBtnTitle {
    return @"已拒绝";
}

- (NSString *)coverDescTitle {
    switch (self.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            return @"来自私人邀约";
        }
        case SKSMessageSourceTypeSend: {
            return @"发起的私人邀约";
        }
        default: {
            return nil;
        }
    }
}

- (NSString *)cashTitle {
    return [NSString stringWithFormat:@"¥%ld元", (long)self.withCrash];
}

- (NSString *)distinctTitle {
    return @"·13.3km";
}


- (NSString *)placeTitle {
    return [NSString stringWithFormat:@"%@", self.place];
}

- (NSString *)privacyOfferTradingTips {
    switch (self.message.messageSourceType) {
        case SKSMessageSourceTypeReceive: {
            NSString *tipDesc = @"对方已向平台支付邀约金，请尽快答复，请注意以下事项：";
            NSString *tip1 = @"1. 请与对方确定好见面时间和时长并按时抵达，见面时请与对方同时点击“见”气球完成支付。";
            NSString *tip2 = @"2. 注意人身安全，拒绝邀约方不合理要求。";
            NSString *tip3 = @"3. 严禁向邀约方索要钱物或私人联系方式，一经查实，平台将做出严厉处罚。";
            NSString *result = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", tipDesc, tip1, tip2, tip3];
            return result;
        }
        case SKSMessageSourceTypeSend: {
            NSString *tipDesc = @"您的邀约已发送成功，请耐心等待对方回复，以下事项请您注意；";
            NSString *tip1 = @"1. 请与应邀方确定好见面时间和时长，若成功见面，请配合对方点击“见”气球完成支付。";
            NSString *tip2 = @"2. 为保障您的权益，请务必在平台内完成订单，平台不承担一切应用外支付造成的损失。";
            NSString *tip3 = @"3. 为防止诈骗风险，请注意隐私保护，谨慎对待应邀方主动添加微信或索要联系号码的行为，必要时您可向平台发起举报。";
            NSString *tip4 = @"4. 尊重应邀者的意愿，若因您的个人原因造成应邀者投诉，您的账号可能会受到处罚甚至封号。";
            NSString *result = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@", tipDesc, tip1, tip2, tip3, tip4];
            return result;
        }
        default: {
            return @"";
        }
    }
}


@end
