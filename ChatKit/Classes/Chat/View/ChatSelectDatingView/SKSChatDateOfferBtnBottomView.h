//
//  SKSChatDateOfferBtnBottomView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//



@class SKSChatMessageModel;

@protocol SKSChatSelectDatingDescBottomViewDelegate <NSObject>

- (void)selectDatingDescBottomViewDidTapBtnIndex:(NSInteger)buttonIndex;

@end

@interface SKSChatDateOfferBtnBottomView : UIView

@property (nonatomic, weak) id<SKSChatSelectDatingDescBottomViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
