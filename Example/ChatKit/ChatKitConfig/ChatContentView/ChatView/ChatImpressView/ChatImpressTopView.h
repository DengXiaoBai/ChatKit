//
//  ChatImpressTopView.h
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//



@class SKSChatMessageModel;

@interface ChatImpressTopView : UIView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;
+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
