//
//  ChatImpressBottomView.h
//  ChatKit
//
//  Created by iCrany on 2017/2/10.
//
//



@class SKSChatMessageModel;

@protocol ChatImpressBottomViewDelegate <NSObject>

- (void)impressBottomViewDidTapBtnIndex:(NSInteger)buttonIndex;

@end

@interface ChatImpressBottomView : UIView

@property (nonatomic, weak) id<ChatImpressBottomViewDelegate> delegate;

- (instancetype)initWithMessageModel:(SKSChatMessageModel *)messageModel;

- (void)updateUIWithMessageModel:(SKSChatMessageModel *)messageModel force:(BOOL)force;
+ (CGSize)getViewSizeWithMessageModel:(SKSChatMessageModel *)messageModel;

@end
