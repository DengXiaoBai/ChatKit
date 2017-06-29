//
//  SKSChatRecordingInsideView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/31.
//
//



@protocol SKSChatKeyboardConfig;

@interface SKSChatRecordingInsideView : UIView

- (instancetype)initWithFrame:(CGRect)frame keyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig;

- (void)clearResource;
- (void)updateLevel:(NSInteger)level;

- (void)startVoiceRecording;

@end
