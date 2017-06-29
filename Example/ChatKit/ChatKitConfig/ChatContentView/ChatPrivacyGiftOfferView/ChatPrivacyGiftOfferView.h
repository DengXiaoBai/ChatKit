//
//  ChatPrivacyGiftOfferView.h
//  ChatKit
//
//  Created by iCrany on 2017/6/6.
//
//

#include <ChatKit/SKSChatMessageModel.h>

@protocol ChatPrivacyGiftOfferViewDelegate <NSObject>

- (void)privacySendRosesViewButtonTapIndex:(NSInteger)index;

@end

@interface ChatPrivacyGiftOfferView : UIView

@property (nonatomic, weak) id<ChatPrivacyGiftOfferViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;
- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel cellWidth:(CGFloat)cellWidth;

@end
