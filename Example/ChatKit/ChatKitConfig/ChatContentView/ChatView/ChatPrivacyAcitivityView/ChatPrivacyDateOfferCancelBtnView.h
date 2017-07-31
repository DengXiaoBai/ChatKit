//
//  ChatPrivacyDateOfferCancelBtnView.h
//  ChatKit
//
//  Created by iCrany on 2017/7/31.
//  Copyright (c) 2017 iCrany. All rights reserved.
//



@class SKSChatMessageModel;
@protocol ChatPrivacyDateOfferBtnViewDelegate;

@interface ChatPrivacyDateOfferCancelBtnView : UIView

@property (nonatomic, weak) id<ChatPrivacyDateOfferBtnViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;
- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel maxWidth:(CGFloat)maxWidth;

@end
