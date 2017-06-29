//
// Created by iCrany on 2016/11/12.
// Copyright (c) 2016 Sachsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKSChatMessageConstant.h"

@class SKSEmoticonMeta;

@protocol SKSKeyboardViewActionProtocol <NSObject>

@optional


/**
 键盘更多按钮视图中的按钮类型
 
 @param keyboardMoreType SKSKeyboardMoreType 类型
 */
- (void)onTapKeyboardMoreType:(SKSKeyboardMoreType)keyboardMoreType;


/**
 发送文字按钮

 @param text 要发送的文字
 */
- (void)onSendText:(NSString *)text;


/**
 键盘中的文字正在变化

 @param text 键盘中输入文字控件中的内容，用于判断是否正在编辑
 */
- (void)onInputTextViewTextDidChange:(NSString *)text;



/**
 发送表情

 @param emoticonMeta 表情的元数据
 */
- (void)onSendEmoticon:(SKSEmoticonMeta *)emoticonMeta;


/**
 打开表情管理商城回调
 */
- (void)onOpenEmoticonShop;


/**
 表情预览
 @param emoticonMeta 表情元数据
 */
- (void)onPreviewWithEmoticonMeta:(SKSEmoticonMeta *)emoticonMeta;

/**
 * 表情按钮中的删除事件回调
 * */
- (void)onEmoticonDeleteButtonAction;

/**
 取消语音录音
 */
- (void)onCancelRecording;


/**
 停止语音录音
 */
- (void)onStopRecording;


/**
 开始语音录音
 */
- (void)onStartRecording;

/**
 * 正在录音的回调
 * @param voiceRecordState 用户的当前录音的状态
 * */
- (void)onRecordingProgressWithRecordVoiceState:(SKSVoiceRecordState)voiceRecordState countDown:(NSInteger)countDown;

@end
