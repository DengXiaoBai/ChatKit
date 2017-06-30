//
//  SKSRealTimeVoiceMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSRealTimeVoiceMessageObject : NSObject<SKSChatMessageObject>

/**
 实时语音回话的唯一标识
 */
@property(nonatomic, assign) int64_t sessionId;


/**
 实时语音的呼叫状态
 */
@property(nonatomic, assign) SKSMessageCallState callState;


/**
 实时语音的通话时长
 */
@property(nonatomic, assign) int32_t duration;


/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property (nonatomic, nullable, weak) SKSChatMessage *message;


/**
 实时语音实例构造函数
 
 @param sessionId 实时语音会话的唯一标识
 @param callState 实时语音的呼叫状态
 @param duration 实时语音的通话时长
 @return 实时语音对象实例
 */
- (instancetype)initWithSessionId:(int64_t)sessionId
                        callState:(SKSMessageCallState)callState
                         duration:(int32_t)duration;

@end

NS_ASSUME_NONNULL_END
