//
//  SKSChatProgressView.h
//  ChatKit
//
//  Created by iCrany on 2017/1/3.
//
//



@interface SKSChatProgressView : UIView

- (instancetype)initWithNumber:(NSInteger)number viewSize:(CGSize)viewSize;

- (void)updateLevel:(NSInteger)level;
- (void)clearResource;
- (void)startVoiceRecording;

@end
