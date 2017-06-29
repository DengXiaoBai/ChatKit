//
//  SKSInputView.h
//  AtFirstSight
//
//  Created by iCrany on 2016/11/12.
//  Copyright © 2016年 Sachsen. All rights reserved.
//

#import "SKSDefaultChatSessionConfig.h"
#import "SKSChatRecordView.h"

@class SKSButtonInputView;
@class SKSInputTextView;
@class SKSKeyboardView;
@protocol SKSKeyboardViewActionProtocol;
@class SKSKeyboardBaseMoreView;

@protocol SKSKeyboardViewDelegate <NSObject>

/**
 键盘高度变化通知

 @param keyboardView 键盘实例
 */
- (void)inputTextViewHeightDidChange:(SKSKeyboardView *)keyboardView;

@optional

/**
 * 文字输入框的字数变化回调
 * @param text 文字输入框当前的内容
 * @param isSend 判断是否是点击发送的操作，文字的发送以及表情控件中的发送按钮触发的操作
 */
- (void)inputTextViewDidChange:(NSString *)text isSend:(BOOL)isSend;

@end


@interface SKSKeyboardView : UIView

- (instancetype)initWithSessionConfig:(id<SKSChatSessionConfig>)sessionConfig;


@property (nonatomic, weak) id<SKSKeyboardViewDelegate> delegate;
@property (nonatomic, weak) id<SKSKeyboardViewActionProtocol> actionDelegate;

/**
 语音按钮
 */
@property (nonatomic, strong, readonly) UIButton *voiceBtn;

/**
 语音按住说话按钮
 */
@property (nonatomic, strong, readonly) UIButton *holdToTalkBtn;


/**
 表情按钮
 */
@property (nonatomic, strong, readonly) SKSButtonInputView *emoticonBtn;


/**
 更多项按钮
 */
@property (nonatomic, strong, readonly) SKSButtonInputView *moreBtn;



/**
 键盘输入栏
 */
@property (nonatomic, strong, readonly) SKSInputTextView *inputTextView;



/**
 系统弹出键盘的高度
 */
@property (nonatomic, assign) CGFloat systemKeyboardViewHeight;


/**
 自定义键盘输入文字控件的高度， 既整个 SKSKeyboardView 对象的高度
 */
@property (nonatomic, assign) CGFloat customInputViewHeight;


@property (nonatomic, strong, readonly) SKSKeyboardBaseMoreView *moreView;


/**
 聊天配置选项

 @param config 实现了 SKSChatSessionConfig 协议的实例对象
 */
- (void)updateSessionConfig:(id<SKSChatSessionConfig>)config;

/**
 * 重置所有按钮状态
 * */
- (void)resetAllButtonState;

- (void)didRTCStartRecording;//easy_rtc 开始录音之后的回调，用于开启定时器等之类的资源
- (void)clearResource;//清理资源

@end
