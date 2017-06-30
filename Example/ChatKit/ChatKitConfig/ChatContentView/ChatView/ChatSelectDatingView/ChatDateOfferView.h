//
//  ChatDateOfferView.h
//  ChatKit
//
//  Created by iCrany on 2016/12/28.
//
//



@class SKSChatMessageModel;

@protocol DateOfferViewDelegate <NSObject>

- (void)selectDatingViewBtnActionAtIndex:(NSInteger)atIndex;

@end

@interface ChatDateOfferView : UIView

@property (nonatomic, weak) id<DateOfferViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;

@end
