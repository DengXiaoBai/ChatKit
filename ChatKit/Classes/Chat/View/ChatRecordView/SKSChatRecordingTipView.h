//
//  SKSChatRecordingTipView.h
//  ChatKit
//
//  Created by iCrany on 2017/1/4.
//
//



#import "SKSChatMessageConstant.h"

@protocol SKSChatKeyboardConfig;

@interface SKSChatRecordingTipView : UIView

- (instancetype)initWithFrame:(CGRect)frame
               keyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig
             voiceRecordState:(SKSVoiceRecordState)voiceRecordState;

- (void)updateWithVoiceRecordState:(SKSVoiceRecordState)voiceRecordState countDown:(NSInteger)countDown;

@end
