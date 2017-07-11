//
//  ChatPrivacyGiftOfferDescView.h
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//


@interface ChatPrivacyGiftOfferDescView : UIView

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;
- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

@end
