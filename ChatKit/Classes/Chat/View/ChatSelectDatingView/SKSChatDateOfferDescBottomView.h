//
//  SKSChatDateOfferDescBottomView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//



@class SKSChatMessageModel;

@interface SKSChatDateOfferDescBottomView : UIView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
