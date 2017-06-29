//
//  SKSRealTimeVideoAudioMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSRealTimeVideoOrVoiceMessageObject : NSObject<SKSChatMessageObject>


/**
 实时视频或语音回话的唯一标识
 */
@property(nonatomic, assign) int64_t sessionId;


/**
 实时视频或语音的呼叫状态
 */
@property(nonatomic, assign) SKSMessageCallState callState;


/**
 实时视频或语音的通话时长
 */
@property(nonatomic, assign) int32_t duration;


/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property (nonatomic, nullable, weak) SKSChatMessage *message;


/**
 实时视频或语音实例构造函数

 @param sessionId 实时视频会话的唯一标识
 @param callState 实时视频的呼叫状态
 @param duration 实时视频的通话时长
 @return 实时视频对象实例
 */
- (instancetype)initWithSessionId:(int64_t)sessionId
                        callState:(SKSMessageCallState)callState
                         duration:(int32_t)duration;



/**
 实时视频或语音聊天中的 Icon 图片以供视图计算大小

 @return 实时视频聊天 Icon 对象
 */
- (UIImage *)realTimeVideoOrVoiceIconImage;


/**
 实时视频或语音中的文案展示
 @discussion 根据视频持续时间的长度来计算该字符串出来的, 子类重写覆盖该方法即可
 @return 实时视频中的文案内容
 */
- (NSString *)realTimeVideoOrVoiceIconDescription;

@end

NS_ASSUME_NONNULL_END
