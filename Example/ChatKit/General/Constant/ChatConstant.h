//
//  ChatConstant.h
//  ChatKit
//
//  Created by iCrany on 2017/8/14.
//  Copyright (c) 2017 iCrany. All rights reserved.
//

#ifndef ChatConstant_h
#define ChatConstant_h

/**
 * 私人邀约的当前状态
 */
typedef NS_ENUM(NSInteger, SKSPrivacyActivityState) {
    SKSPrivacyActivityStateUnhandle                 = 0,//未处理
    SKSPrivacyActivityStateAccept                   = 1,//接受
    SKSPrivacyActivityStateThinkAbout               = 2,//考虑
    SKSPrivacyActivityStateReject                   = 3,//拒绝
    SKSPrivacyActivityStateInvalid                  = 4,//无效
    SKSPrivacyActivityStateSuccess                  = 5,//完成
    SKSPrivacyActivityStateUnhandleButSendAnaly     = 6,//未处理，但是发送了统计
};

/**
 * 私人送玫瑰的当前状态
 */
typedef NS_ENUM(NSInteger, SKSPrivacyGiftOfferState) {
    SKSPrivacyGiftOfferStateUnhandle                = 0,//未处理
    SKSPrivacyGiftOfferStateAccept                  = 1,//接受
    SKSPrivacyGiftOfferStateReject                  = 2,//拒绝
    SKSPrivacyGiftOfferStateInvalid                 = 3,//无效
    SKSPrivacyGiftOfferStateUnhandleButSendAnaly    = 4,//未处理，但是发送了统计
};


typedef NS_ENUM(NSInteger, SKSDateOfferState) {
    SKSDateOfferStateNotProcessed           = 0,//未做任何操作的状态
    SKSDateOfferStateWillGiveOffer          = 1,//未来的某个时间点将邀约对方
    SKSDateOfferStateMakeOffer              = 2,//已经发出邀约
    SKSDateOfferStateCancelOffer            = 3,//自己主动取消邀约
    SKSDateOfferStateOfferRejected          = 4,//邀约被拒绝
    SKSDateOfferStateOfferAccepted          = 5,//邀约被接受
    SKSDateOfferStateOfferNoResponse        = 6,//邀约未被受邀者响应
    SKSDateOfferStateOfferAcceptedOverLimit = 7,//应邀者已达上限
    SKSDateOfferStateOfferInvalid           = 8,//无效的 DateOffer 状态
    SKSDateOfferStateNotProcessedButSendAnaly = 9,//未做任何操作，但是发送了统计的状态
};


#endif /* ChatConstant_h */
