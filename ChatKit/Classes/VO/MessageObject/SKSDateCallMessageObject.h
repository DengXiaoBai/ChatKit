//
//  SKSDateCallMessageObject.h
//  ChatKit
//
//  Created by iCrany on 2016/12/24.
//
//



#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSDateCallMessageObject : NSObject <SKSChatMessageObject>

@property (nonatomic, strong) NSString *titleText;

@property (nonatomic, strong) NSString *descText;

/**
 实时视频或语音回话的唯一标识
 */
@property (nonatomic, assign) int64_t sessionId;

/**
 * 约会视频中相关联的约会ID
 * */
@property (nonatomic, strong) NSString *activityId;

/**
 * 约会发布者的 userId
 * */
@property (nonatomic, strong) NSString *activityAuthorId;


/**
 实时视频或语音的呼叫状态, 回拨成功并且联通之后之后需要更新这个状态
 */
@property (nonatomic, assign) SKSMessageCallState callState;

/**
 * 是否回拨成功
 * */
@property (nonatomic, assign) BOOL isCallbackSuccess;


/**
 实时视频或语音的通话时长
 */
@property (nonatomic, assign) int32_t duration;

/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property (nonatomic, nullable, weak) SKSChatMessage *message;

/**
 * DateCall 中的图标
 * */
@property (nonatomic, strong) NSString *iconImageName;


- (instancetype)initWithSessionId:(int64_t)sessionId
                       activityId:(NSString *)activityId
                 activityAuthorId:(NSString *)activityAuthorId
                        callState:(SKSMessageCallState)callState
                         duration:(int32_t)duration
                          message:(SKSChatMessage *)message;


@end

NS_ASSUME_NONNULL_END
