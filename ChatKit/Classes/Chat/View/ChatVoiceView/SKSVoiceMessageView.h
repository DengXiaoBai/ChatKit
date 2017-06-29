//
//  SKSVoiceMessageView.h
//  AtFirstSight
//
//  Created by iCrany on 2016/12/7.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatMessageConstant.h"

@class SKSVoiceMessageView;
@class SKSChatMessageModel;

@protocol SKSVoiceMessageViewDelegate <NSObject>

/*
 * 用户点击了开始或者暂停播放按钮
 * */
- (void)voiceMessageViewDidTapStartOrStopButton:(SKSVoiceMessageView *)view;

@end

@interface SKSVoiceMessageView : UIView

@property (nonatomic, weak) id<SKSVoiceMessageViewDelegate> delegate;

- (instancetype)initWithMessage:(SKSChatMessageModel *)messageModel;

//Helper method
- (void)stopPlayVoice;//停止播放语音
- (void)pausePlayVoice;//暂停播放音乐
- (void)startOrResumePlayVoice;//开始或继续播放语音
- (void)playProgressWithPosition:(NSUInteger)positionMs duration:(NSUInteger)durationMs;
- (void)changeMessageStatus:(SKSMessageDeliveryState)messageStatus;//根据消息的不同状态显示不同的UI

//public method
+ (CGSize)voiceMessageSizeWithMessage:(SKSChatMessageModel *)messageModel;


@end
