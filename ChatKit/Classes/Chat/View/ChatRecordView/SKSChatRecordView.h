//
//  SKSChatRecordView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/31.
//
//

@protocol SKSChatKeyboardConfig;
#import "SKSChatMessageConstant.h"

@protocol SKSChatRecordViewDelegate <NSObject>

- (void)chatRecordViewDidDismiss;

@end

@interface SKSChatRecordView : UIView

@property (nonatomic, weak) id<SKSChatRecordViewDelegate> delegate;

- (instancetype)initWithKeyboardConfig:(id<SKSChatKeyboardConfig>)keyboardConfig;

- (void)showChatRecordView;
- (void)dismissChatRecordView;

//Update UI
- (void)updateUIWithRecordState:(SKSVoiceRecordState)voiceRecordState countDown:(NSInteger)countDown;

- (void)clearResource;
- (void)updateLevel:(NSInteger)level;

@end
