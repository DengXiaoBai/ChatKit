//
//  ChatPrivacyDateOfferMessageObject.h
//  ChatKit
//
//  Created by iCrany on 2017/6/5.
//
//

#import <ChatKit/SKSDateActivityMessageObject.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 私人邀约
 */
@interface ChatPrivacyDateOfferMessageObject : SKSDateActivityMessageObject

@property (nonatomic, strong) NSString *aid;
@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *place;
@property (nonatomic, strong) NSString *detailPlace;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double placeLat;
@property (nonatomic, assign) double placeLng;
@property (nonatomic, assign) int32_t withCrash;//附带的现金数量
@property (nonatomic, assign) SKSPrivacyActivityState privacyActivityState;


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
       privacyActivityState:(SKSPrivacyActivityState)privacyActivityState;

- (NSString *)durationStr;
- (NSString *)leftBtnTitle;
- (NSString *)middleBtnTitle;
- (NSString *)rightBtnTitle;

- (NSString *)acceptedBtnTitle;
- (NSString *)rejectedBtnTitle;

- (NSString *)coverDescTitle;
- (NSString *)cashTitle;
- (NSString *)distinctTitle;
- (NSString *)placeTitle;

@end


NS_ASSUME_NONNULL_END
