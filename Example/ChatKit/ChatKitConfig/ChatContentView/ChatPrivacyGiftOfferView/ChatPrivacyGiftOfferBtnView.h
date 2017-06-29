//
//  ChatPrivacyGiftOfferBtnView.h
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//



@class SKSChatMessageModel;

@protocol SKSPrivacyGiftOfferBtnViewDelegate <NSObject>

- (void)privacyGiftOfferButtonTapIndex:(NSInteger)buttonIndex;

@end

@interface ChatPrivacyGiftOfferBtnView : UIView

@property (nonatomic, weak) id<SKSPrivacyGiftOfferBtnViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;
- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

@end
