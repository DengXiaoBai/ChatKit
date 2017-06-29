//
//  SKSDateCallView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/24.
//
//



@class SKSChatMessageModel;

@interface SKSDateCallView : UIView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)dateCallSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
