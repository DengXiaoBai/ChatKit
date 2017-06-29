//
//  SKSRealTimeVideoAndVoiceView.h
//  SKSChatKit
//
//  Created by iCrany on 2016/12/9.
//  Copyright (c) 2016 iCrany. All rights reserved.
//



@class SKSChatMessageModel;

@interface SKSRealTimeVideoOrVoiceView : UIView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

/**
 * 用于 Cell 重用的 Update UI
 * */
- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)realTimeVideoOrVoiceSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
