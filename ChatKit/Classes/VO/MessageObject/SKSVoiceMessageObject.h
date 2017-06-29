//
//  SKSVoiceMessageObject.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/10.
//  Copyright (c) 2016 Sachsen. All rights reserved.
//

#import "SKSChatMessageConstant.h"
#import "SKSChatMessageObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKSVoiceMessageObject : NSObject<SKSChatMessageObject>


/**
 本地缓存的语音地址
 */
@property(nonatomic, strong) NSString *voiceUrl;


/**
 语音格式类型
 */
@property(nonatomic, assign) SKSVoiceMessageFormat voiceFormat;


/**
 语音持续时间, 单位毫秒
 */
@property(nonatomic, assign) int32_t duration;


/**
 语音是否是第一次播放（跟语音已读作出区分）
 */
@property(nonatomic, assign) BOOL isFirstTimePlay;

/**
 * 当前语音的播放状态
 * */
@property (nonatomic, assign) SKSVoicePlayState voicePlayState;

/**
 * 语音播放进度的回调, 只有当 voicePlayState == SKSVoicePlayStatePlaying 的时候才有意义
 * */
@property (nonatomic, assign) NSUInteger positionMs;
@property (nonatomic, assign) NSUInteger durationMs;


/**
 消息体所在的消息对象, 实现 SKSChatMessageObject 协议
 */
@property(nonatomic, nullable, weak) SKSChatMessage *message;

/*
 *
 */
@property(nonatomic, strong) UIImage *voiceStartButtonImage;

/*
 * */
@property(nonatomic, strong) UIImage *voiceStopButtonImage;

/*
 *
 * */
@property(nonatomic, strong) UIImage *voiceLoadingTopImage;

/*
 * */
@property(nonatomic, strong) UIImage *voiceStartNoReadButtonImage;

/*
 *
 * */
@property(nonatomic, strong) UIImage *voiceLoadingBottomImage;


/**
 语音实例构造方法

 @param voiceUrl 本地缓存的语音地址
 @param voiceFormat 语音格式类型
 @param duration 语音持续时间
 @param isFirstTimePlay 语音是否是第一次播放（跟语音已读作出区分）
 @return 语音实例对象
 */
- (instancetype)initWithVoiceUrl:(NSString *)voiceUrl
                     voiceFormat:(SKSVoiceMessageFormat)voiceFormat
                        duration:(int32_t)duration
                 isFirstTimePlay:(BOOL)isFirstTimePlay;

@end

NS_ASSUME_NONNULL_END
