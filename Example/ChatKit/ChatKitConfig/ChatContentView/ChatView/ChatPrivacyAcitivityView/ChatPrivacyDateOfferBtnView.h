//
//  ChatPrivacyDateOfferBtnView.h
//  ChatKit
//
//  Created by iCrany on 2017/6/7.
//
//

#include "../../../../../../../../Library/Caches/AppCode2017.2/DerivedData/ChatKit-audcfvhkaxgfyvhffdyzmapwhhcu/Build/Products/Debug-iphoneos/ChatKit/ChatKit.framework/Headers/SKSChatMessageModel.h"

@protocol ChatPrivacyDateOfferBtnViewDelegate <NSObject>

- (void)privacyActivityBtnIndex:(NSInteger)index;

@end

@interface ChatPrivacyDateOfferBtnView : UIView

@property (nonatomic, weak) id<ChatPrivacyDateOfferBtnViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;
- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel maxWidth:(CGFloat)maxWidth;

@end
