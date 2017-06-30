//
//  ChatDateOfferBtnBottomView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//



@class SKSChatMessageModel;

@protocol ChatSelectDatingDescBottomViewDelegate <NSObject>

- (void)selectDatingDescBottomViewDidTapBtnIndex:(NSInteger)buttonIndex;

@end

@interface ChatDateOfferBtnBottomView : UIView

@property (nonatomic, weak) id<ChatSelectDatingDescBottomViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
