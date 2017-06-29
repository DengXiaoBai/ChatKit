//
//  ChatPrivacyActivityOfferCoverView.h
//  ChatKit
//
//  Created by iCrany on 2017/6/22.
//  Copyright (c) 2017 iCrany. All rights reserved.
//


@class SKSChatMessageModel;

@protocol ChatPrivacyActivityOfferCoverViewDelegate <NSObject>

- (void)chatPrivacyActivityOfferCoverDownloadCoverImageWithCompletion:(void(^)(UIImage *coverImage))completion;

@end

@interface ChatPrivacyActivityOfferCoverView : UIView

@property (nonatomic, weak) id<ChatPrivacyActivityOfferCoverViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)getSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
