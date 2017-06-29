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
- (NSString *)durationStr {
    return @"今天 12：30 ~ 13：30";
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


@end
